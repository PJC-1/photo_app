class CommentsController < ApplicationController

  def index
    @picture = Picture.find(params[:picture_id])
    @comments = @picture.comments
    render :index
  end


  def create
    @picture = Picture.find_by_id(params[:picture_id])
    @comment = Comment.new(comment_params)
  end


  private
  def comment_params
    params.require(:comment).permit(:post, :user_id, :picture_id)
  end
end
