# encoding: UTF-8

module AddressesHelper
  def formatted_address address
    content_tag :div, class: 'address' do
        [
          (content_tag :span do
              address.line1
            end if address.line1),
          (content_tag :span do
              address.line2
            end if address.line2),
          (content_tag :span do
              address.zip + " " + address.place
            end),
          (content_tag :span do
              address.country
            end if address.country)
        ].join.html_safe
      end if address
    end
  end