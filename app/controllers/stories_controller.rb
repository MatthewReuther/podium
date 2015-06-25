class StoriesController < ApplicationController
  before_action :find_story, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @stories = Story.all.order("created_at DESC")
  end

  def show
    @comments = Comment.where(story_id: @story)
  end

  def new
    @story = current_user.stories.build
  end

  def create
    @story = current_user.stories.build(story_params)

    if @story.save
      redirect_to @story, notice: "Successfully Created New Story"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @story.update(story_params)
      redirect_to @story, notice: "Story was Successfully updated"
    else
      render 'edit'
    end
  end

  def destroy
    @story.destroy
      redirect_to root_path
  end


  private

  def story_params
    params.require(:story).permit(:title, :link, :description, :image)
  end

  def find_story
    @story = Story.find(params[:id])
  end
end


