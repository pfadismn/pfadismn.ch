class MeetingProtocol < ActiveRecord::Base
  has_and_belongs_to_many :participants, class_name: 'Member', association_foreign_key: 'participant_id'
  belongs_to :organisational_unit
  
  validates :title, :body, :organisational_unit, presence: true
  
  def participant_ids=ps
    participants.clear
    ps.each do |p|
      participants << Member.find(p.to_i)
    end
  end
  
  def participant_ids
    participants.collect { |p| p.id }
  end
  
  def to_html
    ps = participants.collect { |p| "* #{p.name}\r\n" }.join
    bs = body.gsub(/^h3. /, "h4. ").gsub(/^h2. /, "h3. ").gsub(/^h1. /, "h2. ")

    content = <<-CONTENT
h1. #{title}

#{organisational_unit} _am (#{I18n.l(created_at, format: :short)})_

h2. Teilnehmer
#{ps}

#{bs}
CONTENT

    RedCloth.new(content).to_html.html_safe
  end
end
