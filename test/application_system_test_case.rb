require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driver = ENV['CI'] ? :firefox : :chrome
  driven_by :selenium, using: driver, screen_size: [1400, 1400]
end
