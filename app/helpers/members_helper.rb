module MembersHelper
  def formatted_phone_number number
    content_tag :div, class: 'address' do
      content_tag :span do
        number.to_s
      end
    end
  end

  def contact_name member
    content_tag :div, class: 'contact-name' do
        concat content_tag :span, member.name, class: 'name'
        concat " "
        concat content_tag :span, mail_to(member.alias, member.alias.split('@').first + '@...', encode: 'javascript'), class: 'email'
    end
  end
end
