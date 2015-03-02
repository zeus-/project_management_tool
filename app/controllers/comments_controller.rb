class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_discussion

  def create
    @comment = Comment.new(comment_params) 
    #@project = @discussion.project
    @comment.discussion = @discussion 
    @comment.user = current_user
    respond_to do |f|
    if @comment.save
      unless @discussion.user == current_user
        CommentMailer.delay.notify_discussion_owner(@comment)
      end
      f.js { render }
      f.html { redirect_to @project, notice: "Cmnted on page" }
    else
      f.js { render }
      f.html { flash[:alert] = "plz include a comment body!"
      redirect_to project_path(@project, comment: comment_params)
      }
    end 
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
    respond_to do |f|
    if @comment.user == current_user && @comment.destroy
      f.js { render }
      f.html { redirect_to @project, notice: "cmnt deleted" }
    else
      f.js { render }
      f.html { flash[:alert] = "You cant destroy this comment!"
      redirect_to project_path(@project)
      }
    end
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
