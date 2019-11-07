# typed: strict
# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  extend T::Sig

  default from: 'noreply@wm-memories.herokuapp.com'
  layout 'mailer'
end
