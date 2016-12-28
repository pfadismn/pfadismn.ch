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

  def heading(t, subtitle=nil, options={})
    icon = options[:icon]
    icon ||= 'abteilung/heading.png'
    quote = options[:quote]
    title t

    content_for :heading do
      render partial: 'layouts/heading', locals: { t: t, subtitle: subtitle, icon: icon, quote: quote }
    end
  end
end
