class ApplicationMailer < ActionMailer::Base

  default_url_options[:host] = Rails.env.production? ? 'wm-memories.herokuapp.com' : 'localhost:3000'
  default from: 'noreply@wm-memories.herokuapp.com'
  layout 'mailer'

end
