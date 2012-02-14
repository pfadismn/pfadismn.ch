module IndexHelper
  def stickyposter style=nil, variant=nil, &block
    style ||= :paper
    variant = " variant_#{variant}"
    variant ||= ''
    
    content_tag :div, class: "stickyposter #{style}#{variant}", &block
  end
end
