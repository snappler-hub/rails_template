module ApplicationHelper

  def flash_message(klass, message)
    snack_klass = "#{klass} callout "
    snack_klass += 'callout-success' if klass == 'success' || klass == 'notice'
    snack_klass += 'callout-danger' if klass == 'error' || klass == 'danger' || klass == 'alert'
    snack_klass += 'callout-warning' if klass == 'warning'
    flash.discard(klass)
    content_tag :div, '', class: "snackbar-message #{klass}",
    data: {toggle: :snackbar, style: snack_klass, content: message, timeout: 10000}
  end

 def flash_messages
   capture do
     flash.each do |type, message|
       concat flash_message(type, message)
     end
   end
 end

 def icon(name, html_options={})
   html_options[:class] = ['fa', "fa-#{name}", html_options[:class]].compact
   content_tag(:i, nil, html_options)
 end

end