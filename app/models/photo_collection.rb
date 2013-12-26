require 'zip'

module PhotoCollection
  BASE_PATH = "#{Rails.root}/public/photos"
  BASE_URL = "/photos"
  XSL_PATH = "#{Rails.root}/config/photos"
    
  class Album
    attr_accessor :name, :caption, :photos, :path, :place, :thumbnail
  
    def initialize(path)
      raise StandardError unless Album.album_exists?(path)
      @indexed = false
      @photos = []
      @path = path
      
      load_head
    end
    
    def photos
      unless @indexed
        load_index
        @indexed = true
      end
      
      return @photos
    end
    
    def self.album_exists? (path)
      File.exists?("#{path}/index.xml")
    end
    
    def index_file
      "#{path}/index.xml"
    end
    
    def url
      "#{PhotoCollection::BASE_URL}#{relative_path}"
    end
    
    def id
      /\A\/(?<year>.+)\/(?<id>.+)\z/.match(relative_path)
    end
    
    def relative_path
      path.gsub(PhotoCollection::BASE_PATH, '')
    end
    
    def destroy
      FileUtils.rmtree(path)
    end
    
    private
    def load_index
      xslt = Nokogiri::XSLT(File.read("#{PhotoCollection::XSL_PATH}/index.xsl"))
      doc = xslt.transform(Nokogiri::XML(open(index_file).read))
      album_node = doc.xpath('/album')
      
      #      @name     = album_node.at_xpath('albumName').try(:content).try(:strip)
      #      @caption  = album_node.at_xpath('albumCaption').try(:content).try(:strip)
      #      @place    = album_node.at_xpath('albumPlace').try(:content).try(:strip)
      
      album_node.xpath('images/image').each do |image_node|
        p = Photo.new(image_node.at_xpath('filename').content.strip, {
            caption:  image_node.at_xpath('caption').try(:content).try(:strip),
            height:   image_node.at_xpath('height').try(:content).try(:strip),
            width:    image_node.at_xpath('width').try(:content).try(:strip),
            size:     image_node.at_xpath('size').try(:content).try(:strip),
            album:    self
          }
        )
      
        thumb_node = image_node.at_xpath('thumbnail')
      
        if thumb_node
          t = Thumbnail.new(thumb_node.at_xpath('filename').content.strip, {
              height: thumb_node.at_xpath('height').try(:content).try(:strip),
              width: thumb_node.at_xpath('width').try(:content).try(:strip), 
              photo: p
            }
          )
        
          p.thumbnail = t
        end
        @photos << p
      end
    end
    
    def load_head
      xslt = Nokogiri::XSLT(File.read("#{PhotoCollection::XSL_PATH}/head.xsl"))
      doc = xslt.transform(Nokogiri::XML(open(index_file).read))
      album_node =  doc.xpath('/album')
      
      @name     = album_node.at_xpath('albumName').try(:content).try(:strip)
      @caption  = album_node.at_xpath('albumCaption').try(:content).try(:strip)
      @place    = album_node.at_xpath('albumPlace').try(:content).try(:strip)
      
      thumb_node = album_node.at_xpath('thumbnail')
      
      @thumbnail = Thumbnail.new(thumb_node.at_xpath('filename').content.strip, {
          height: thumb_node.at_xpath('height').try(:content).try(:strip),
          width: thumb_node.at_xpath('width').try(:content).try(:strip), 
          album: self
        }
      )
    end
  end

  class Photo
    attr_accessor :height, :width, :thumbnail, :caption, :size, :album, :filename
  
    def initialize(filename, attributes={})
      self.filename = filename
    
      @height    = attributes[:height]    if attributes[:height].present?
      @width     = attributes[:width]     if attributes[:width].present?
      @caption   = attributes[:caption]   if attributes[:caption].present?
      @size      = attributes[:size]      if attributes[:size].present?
      @album     = attributes[:album]     if attributes[:album].present?
      @thumbnail = attributes[:thumbnail] if attributes[:thumbnail].present?
    end
  
    def url
      "#{album.url}/#{filename}"
    end
  end

  class Thumbnail
    attr_accessor :height, :width, :filename, :photo, :album
  
    def initialize(filename, attributes={})
      @filename = filename
      @height = attributes[:height] if attributes[:height].present?
      @width = attributes[:width] if attributes[:width].present?
      @album = attributes[:album] if attributes[:album].present?
      
      self.photo = attributes[:photo] if attributes[:photo].present?
    end
    
    def photo= p
      @photo = p
      @album = p.album
    end
  
    def url
      "#{album.url}/#{filename}"
    end
  end
  
  class AlbumFactory
    def self.build(year, id)
      Album.new("#{PhotoCollection::BASE_PATH}/#{year}/#{id}") rescue nil
    end
      
    def self.list_years
      albums = {}
      
      Dir.chdir("#{PhotoCollection::BASE_PATH}") do
        Dir.glob("*").each do |year|
          next unless File.directory? year
          Dir.chdir(year) do
            albums[year] = []
        
            Dir.glob("*").each do |album|
              album_path = "#{Dir.pwd}/#{album}"
              albums[year] << (Album.new(album_path)) rescue nil
            end
        
            albums[year].compact!
          end
        end
      end

      albums = albums.delete_if { |y,a| a.empty? }
      albums
    end
  end
  
  class AlbumUpload
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming
   
    attr_accessor :year, :file
  
    validates_presence_of :year, :file
    validates_format_of :year, with: /[\w\-]+/
    validate do
      errors.add :file, I18n.t('activerecord.errors.models.transaction.attributes.file.invalid') if file.content_type != "application/zip"
    end
  
    def persisted?
      false
    end
  
    def initialize(attributes={})
      @year = attributes[:year].strip.underscore if attributes[:year].present?
      @file = attributes[:file] if attributes[:file].present?
    end
    
    def path
      "#{PhotoCollection::BASE_PATH}/#{year}"
    end
    
    def save
      return false unless valid?
        Zip::File.open(file.path) { |zip|
          zip.each { |f|
            destination_path = File.join(path, f.name)
            FileUtils.mkdir_p File.dirname destination_path
            next unless File.extname(f.to_s).match /\A(\.jp?g)|(\.xml)\z/
            zip.extract(f, destination_path) rescue nil
          }
        }
      true
    end
  end
end