class PicturesController < ApplicationController

    def index
      @pictures = Picture.all
    end

    def new
      @picture = Picture.new
    end

    def show
      @picture = Picture.find_by_id(params[:id])
    end

    def create
      @picture = Picture.create(picture_params)
      Cloudinary::Uploader.upload(params[:picture][:pic_img])
                                  # :crop => :limit, :width => 2000, :height => 2000,
                                  # :eager => [
                                  #   { :width => 200, :height => 200,
                                  #     :crop => :thumb, :gravity => :face,
                                  #     :radius => 20, :effect => :sepia },
                                  #   { :width => 100, :height => 150,
                                  #     :crop => :fit, :format => 'png'}
                                  #   ],
                                  #   :tags => ['special', 'for_homepage'])
      current_user.pictures << @picture

      redirect_to pictures_path
    end

    def destroy
      @user = User.find_by_id(params[:id])
      @pictures = Picture.find_by_id(params[:id])
      if current_user
        @current_user.pictures.find_by_id(params[:id]).destroy
        redirect_to user_path(current_user)
      else
        flash[:notice]="You are not authorized to delete pictures!"
        redirect_to user_path(@user)
      end
    end

    private
    def picture_params
      params.require(:picture).permit(:pic_img)
    end

end
