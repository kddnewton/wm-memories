# typed: strict
# frozen_string_literal: true

module ApplicationHelper
  extend T::Sig

  # build the main google map from the given stories
  sig {
    params(stories: Story::ActiveRecord_Relation)
      .returns(ActiveSupport::SafeBuffer)
  }
  def init_map_from(stories)
    stories = stories.map { |story| view_story_from(story) }.to_json
    javascript_tag(
      "MapManager.init(#{Rails.configuration.x.lat}, " \
      "#{Rails.configuration.x.lng}, #{stories})"
    )
  end

  # build a json structure a story for the view
  sig { params(story: Story).returns(T::Hash[Symbol, T.any(Numeric, String)]) }
  def view_story_from(story)
    {
      lat: story.lat,
      lng: story.lng,
      body: j(story.identifier + ': ' + truncate(story.body, length: 200)),
      storyId: story.id
    }
  end

  # build a nav link
  sig {
    params(label: String, path: String, glyph: Symbol)
      .returns(ActiveSupport::SafeBuffer)
  }
  def nav_link(label, path, glyph)
    css_class = 'col-sm-2 col-xs-4 ' + (current_page?(path) ? 'active' : '')

    link_to(path, class: css_class) do
      concat content_tag(:span, nil, class: "glyphicon glyphicon-#{glyph}")
      concat '&nbsp'.html_safe
      concat content_tag(:span, label, class: 'hidden-xs')
    end
  end

  # render the body of the story
  sig {
    params(story: Story, query: T.nilable(String))
      .returns(ActiveSupport::SafeBuffer)
  }
  def story_body(story, query:)
    if query
      highlight(simple_format(excerpt(story.body, query, radius: 200)), query)
    else
      simple_format(truncate(story.body, length: 300))
    end
  end

  # translate the key based on the current controller and action
  sig {
    params(key: String, substitutions: T.nilable(T::Hash[Symbol, String]))
      .returns(String)
  }
  def view_translate(key, substitutions = {})
    components = ['views'] + params[:controller].split('/') + [key]
    t(components.join('.'), substitutions)
  end
  alias vt view_translate
end
