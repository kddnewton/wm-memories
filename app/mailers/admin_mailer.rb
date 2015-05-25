class AdminMailer < ApplicationMailer

  # notify of a new story
  def story_created(story)
    @story = story
    emails = Subscription.validated.pluck(:email)
    
    if emails.any?
      mail(to: emails, subject: "[WM-Memories] #{story.identifier} Created")
    end
  end

end
