class PicturesController < ApplicationController

    def index
      @pictures = Picture.all
    end

    def new
      @picture = Picture.new
    end

    def show
      @picture = Picture.find_by_id(params[:id])
      @comments = @picture.comments
      @user = current_user
    end

    def create
      @picture = Picture.create(picture_params)
      Cloudinary::Uploader.upload(params[:picture][:pic_img])
      current_user.pictures << @picture
      redirect_to pictures_path
    end

    def destroy
      @user = User.find_by_id(params[:id])
      @pictures = Picture.find_by_id(params[:id])
      if current_user == @pictures.user
        @pictures.destroy
        redirect_to user_path(current_user)
      else
        flash[:notice]="You are not authorized to delete this picture!"
        redirect_to user_path(current_user)
      end
    end

    private
    def picture_params
      params.require(:picture).permit(:pic_img)
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end

end
