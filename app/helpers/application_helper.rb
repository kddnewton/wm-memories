module ApplicationHelper

  # render the body of the story
  def story_body(story, context)
    case context
    when :feed
      simple_format(truncate(story.body, length: 300))
    when :search
      simple_format(highlight(excerpt(story.body, @query, radius: 200), @query))
    end
  end

end
