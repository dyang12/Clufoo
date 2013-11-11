class UserMailer < ActionMailer::Base
  default from: "notifications@clufoo.com"
  helper_method :display_attribute
  
  def notification_email(email, entry)
    @entry = entry
    @form = entry.form
    mail(to: email, subject: entry.form.title)
  end
  
  def display_attribute(entry, field)
    if entry.response_data[field.id.to_s].is_a?(Array)
      entry.response_data[field.id.to_s].join(", ")
    else
      entry.response_data[field.id.to_s]
    end
  end
end
