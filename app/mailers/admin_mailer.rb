class AdminMailer < ApplicationMailer

  # notify of a new story
  def story_created(story)
    @story = story
    mail(to: 'kevin.deisz@gmail.com', subject: "[WM-Memories] #{story.identifier} Created")
  end

end
