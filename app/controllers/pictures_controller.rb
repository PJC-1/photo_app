class PicturesController < ApplicationController

    def index
      @pictures = current_user.pictures
    end

    def new
      @picture = Picture.new
    end

    def create
      @picture = Picture.create(picture_params)
      Cloudinary::Uploader.upload(params[:picture][:pic_img])
                                  # :public_id => "",
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

    private
    def picture_params
      params.require(:picture).permit(:pic_img)
    end

end
