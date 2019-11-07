# typed: false
# frozen_string_literal: true

require 'test_helper'

class ModeratorTest < ActiveSupport::TestCase
  def test_email_presence_validation
    assert_validates_presence_of Moderator, :email
  end

  def test_email_uniqueness_validation
    assert_validates_uniqueness_of Moderator, :email
  end

  def test_email_format_validation
    assert_validates_format_of Moderator, :email, 'testemailtest.com'
  end
end
