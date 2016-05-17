class CommentsController < ApplicationController

  def index
    @picture = Picture.find(params[:picture_id])
    @comments = @picture.comments
    # render :index
  end

  def show
    @picture = Picture.find(params[:picture_id])
    @comment = Picture.comments.find(params[:comment_id])
    @user = @comment.user
    # render :show
  end

  def new
    @picture = Picture.find(params[:picture_id])
    @comment = Comment.new
    if current_user
      #  render :new
    else
      flash[:notice]="You are not authorized to create comments for this picture!"
      redirect_to root_path
    end
  end

  def create
    @picture = Picture.find(params[:picture_id])
    @user = current_user
    @comment = @picture.comments.create(comment_params)
    @picture.comments << @comment
    @user.comments << @comment
    redirect_to picture_path(@picture)
  end

  def edit
    @picture = Picture.find(params[:picture_id])
    @comment = @picture.comments.find(params[:comment_id])
    if current_user == @comment.user
      render :edit
    else
      flash[:notice]="You are not authorized to edit comments!"
      redirect_to root_path
    end
  end

  def update
    @picture = Picture.find(params[:picture_id])
    @comment = Comment.find(params[:comment_id])
    @comment.update(comment_params)
    flash[:notice] = "Comment succesfully updated!"
    redirect_to root_path
  end

  def destory
    @picture = Picture.find(params[:picture_id])
    @comment = @picture.comments.find(params[:comment_id])
    if current_user == @comment.user
      @picture.comments.destory(@comment)
      flash[:notice] = "Succesfully deleted comment!"
      redirect_to root_path
    else
      flash[:notice] = "You are not authorizedto delete comments!"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:post)
  end
end
