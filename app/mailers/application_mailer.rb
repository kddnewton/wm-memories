# frozen_string_literal: true
class ApplicationMailer < ActionMailer::Base

  default from: 'noreply@wm-memories.herokuapp.com'
  layout 'mailer'

end
