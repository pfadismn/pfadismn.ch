# encoding: UTF-8

module ApplicationHelper
  def form_element(label, &block)
    content_tag(:li, class: :input) do
      concat(content_tag(:label, class: :label) do
        label
      end)
      concat(content_tag(:div, class: 'field-content') do
        capture(&block)
      end)
    end
  end

  def content_separator
    image_tag 'pfadiischseil.png', style: "margin-top:-10px; margin-bottom: 5px;"
  end

  def clearer
    content_tag :div, nil, class: 'clear'
  end

  def title t
    content_for :title do
      t
    end
  end

  def image_url(file)
    request.protocol + request.host_with_port + path_to_image(file)
  end

  def heading(t, subtitle=nil, options={})
    icon = options[:icon]
    icon ||= 'abteilung/heading.png'
    quote = options[:quote]
    title t

    content_for :heading do
      content_tag :div, class: 'heading' do
          concat content_tag :div, image_tag(icon), class: 'icon'
          concat content_tag :h1, t
          concat content_tag :h2, subtitle
          concat content_tag :blockquote, quote if quote
      end
    end
  end
end