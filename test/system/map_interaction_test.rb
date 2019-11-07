# typed: false
# frozen_string_literal: true

require 'application_system_test_case'

class MapInteractionTest < ApplicationSystemTestCase
  test 'creating a story' do
    visit root_path

    assert_selector '#map'
    assert find_all('.modal-content').empty?

    find_by_id('map').double_click
    assert find('.modal-content').visible?

    fill_in 'story[year]', with: '2013'
    fill_in 'story[body]', with: 'foo bar'

    assert_difference -> { Story.count }, +1 do
      click_on 'Submit'
    end
  end

  test 'clicking on a story' do
    visit root_path

    execute_script <<~JS
      MapManager.markers[0].infoWindow.open(
        MapManager.map,
        MapManager.markers[0].marker
      )
    JS

    find('#map a', text: 'Read more...').click

    assert_current_path story_path(stories(:second))
  end
end
