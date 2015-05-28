module ApplicationHelper

  # build the main google map from the given stories
  def init_map_from(stories)
    stories = stories.map { |story| { lat: story.lat, lng: story.lng, body: j(story.identifier + ': ' + truncate(story.body, length: 200)), storyId: story.id } }
    javascript_tag("window.Memories.init(#{Rails.configuration.x.lat}, #{Rails.configuration.x.lng}, #{stories.to_json})")
  end

  # build a nav link
  def nav_link(label, path, glyph)
    link_to(path, class: 'col-sm-2 col-xs-4 ' + (current_page?(path) ? 'active' : '')) do
      concat content_tag(:span, nil, class: "glyphicon glyphicon-#{glyph}")
      concat '&nbsp'.html_safe
      concat content_tag(:span, label, class: 'hidden-xs')
    end
  end

  # render the body of the story
  def story_body(story, context:)
    case context
    when :feed
      simple_format(truncate(story.body, length: 300))
    when :search
      simple_format(highlight(excerpt(story.body, @query, radius: 200), @query))
    end
  end

end
