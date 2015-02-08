class CommentMailer < ApplicationMailer
  default from: "PMStool1@example.com"

  def notify_discussion_owner(comment)
    @comment = comment
    @discussion = @comment.discussion
    @user = @discussion.user
    mail to: @user.email, subject: "#{@comment.user.first_name} commented on your discussion!"
  end

end
