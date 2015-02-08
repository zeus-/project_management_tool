class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_discussion

  def create
    @comment = @discussion.comments.new(comment_params) 
    @project = @discussion.project
    @comment.user = current_user
    if @comment.save
      unless @discussion.user == current_user
        CommentMailer.notify_discussion_owner(@comment).deliver_now
      end
      redirect_to @project, notice: "Cmnted on page"
    else
      flash[:alert] = "plz include a comment body!"
      redirect_to project_path(@project, comment: comment_params)
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = @discussion.comments.find(params[:id])
    @project = @discussion.project
    if @comment.user == current_user && @comment.update(comment_params) 
      redirect_to @project, notice: "Updated successfully"
    else
      flash.now[:alert] = "You can't update this cmnt!"
      render "/comments/edit"
    end
  end
  def destroy
    @comment = @discussion.comments.find(params[:id]) 
    @project = @discussion.project
    if @comment.user == current_user && @comment.destroy
      redirect_to @project, notice: "cmnt deleted"
    else
      flash[:alert] = "You cant destroy this comment!"
      redirect_to project_path(@project)
    end
  end

  private 
    def comment_params
      params.require(:comment).permit([:body])
    end

    def find_discussion 
      @discussion = Discussion.find(params[:discussion_id])
    end

end
