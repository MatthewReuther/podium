class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @story = Story.find(params[:story_id])
    @comment = Comment.create(params[:comment].permit(:content))
    @comment.user_id = current_user.id
    @comment.story_id = @story.id

    if @comment.save
      redirect_to story_path(@story)
    else
      render 'new'
    end
  end
end
