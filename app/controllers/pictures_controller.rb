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
      current_user.pictures << @picture
      redirect_to pictures_path
    end

    private
    def picture_params
      params.require(:picture).permit(:pic_img)
    end

end
