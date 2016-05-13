class PicturesController < ApplicationController

  def index
    @pictures = Picture.all
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.create(picture_params)
    Cloudinary::Uploader.upload(params[:picture][:pic_img])
    redirect_to pictures_path
  end

  private
  def picture_params
    params.require(:picture).permit(:pic_img)
  end

end