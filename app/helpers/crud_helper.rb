# encoding: UTF-8

module CrudHelper
  def clearer
    content_tag :div, nil, class: 'clear'
  end

  def show_field name, record=nil, options={}, &block
    label = ""
    value = ""

    if block_given?
      label = record.class.human_attribute_name(name) if record
      label ||= name
      value = capture &block
    else
      label = record.class.human_attribute_name(name)
      value = field_value record.try(name), options
    end

    content_tag :li do
      concat content_tag :div, label, class: 'label'
      concat content_tag :div, value, class: 'value'
      concat clearer
    end
  end

  def field_value raw, options={}
    v ||= link_to raw, raw if raw.is_a?(ActiveRecord::Base)
    v ||= l raw if raw.is_a?(Date) || raw.is_a?(DateTime)
    v ||= raw.to_sentence if raw.is_a?(Array)
    v ||= "✓" if raw.is_a?(TrueClass)
    v ||= "✕" if raw.is_a?(FalseClass)
    v ||= "-" if raw.nil?
    v ||= raw.to_s
    v
  end

  def show_section title, &block
    content_tag :div, class: 'show-section' do
        concat content_tag :h3, title.to_s.camelize
        concat content_tag :ol, &block
    end
  end

  def crud_links path_array, options={}
    options[:except] ||= []
    options[:parent_resource] ||= nil

    modcord = path_array.last
    path_struct = path_array
    path_struct.pop

    if modcord.is_a? Class
      model = modcord
    else
      record = modcord
      model = record.class
    end

    content_tag :ul, class: 'buttons' do
        concat content_tag(:li, link_to("Übersicht", path_struct + [model], class: 'index'))
       if record.present? && !record.new_record?
         concat content_tag(:li, link_to("Anzeigen", path_struct + [record], class: 'show', title: 'Anzeigen')) if !options[:except].include? :show && can?(:read, record)
         concat content_tag(:li, link_to("Bearbeiten", [:edit] + path_struct + [record], class: 'edit', title: 'Bearbeiten')) if !options[:except].include?(:edit) && can?(:update, record)
         concat content_tag(:li, link_to("Löschen", path_struct + [record], method: :delete, confirm: t(:really_delete?), class: 'delete', title: 'Löschen')) if !options[:except].include? :destroy && can?(:destroy, record)
      end
        concat content_tag(:li, link_to("Neu", [:new] + path_struct + [model.model_name.singular.to_sym], class: 'new', title: 'Neu')) if !options[:except].include? :new && !record.try(:new_record?) && can?(:create, record)
    end
  end

  def crud_navigation path_array, options={}, &block
    if path_array.is_a?(Array)
      modcord = path_array.last
    else
      modcord = path_array
      path_array = [modcord]
    end

    model ||= modcord if modcord.is_a?(Class)
    model ||= modcord.class

    content_tag :div, class: 'crud-navigation' do
        concat content_tag :h2, model.model_name.human
        concat crud_links path_array, options
        concat capture &block if block_given?
    end
  end
end
