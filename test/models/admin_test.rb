# frozen_string_literal: true
require 'test_helper'

class AdminTest < ActiveSupport::TestCase

  def test_email_presence_validation
    assert_validates_presence_of Admin, :email
  end

  def test_email_uniqueness_validation
    assert_validates_uniqueness_of Admin, :email
  end

  def test_email_format_validation
    assert_validates_format_of Admin, :email, 'testemailtest.com'
  end
end
