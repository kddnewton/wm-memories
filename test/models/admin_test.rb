require 'test_helper'

class AdminTest < ActiveSupport::TestCase

  def test_email_presence_validation
    subscription = Admin.new
    assert_not subscription.save
    assert_not subscription.errors[:email].blank?
  end

  def test_email_uniqueness_validation
    subscription = Admin.new(email: admins(:kevin).email)
    assert_not subscription.save
    assert_not subscription.errors[:email].blank?
  end

  def test_email_format_validation
    subscription = Admin.new(email: 'testemailtest.com')
    assert_not subscription.save
    assert_not subscription.errors[:email].blank?
  end

end
