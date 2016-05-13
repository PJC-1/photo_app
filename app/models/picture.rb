class Picture < ActiveRecord::Base
  mount_uploader :pic_img, PicImgUploader

  belongs_to :user
  has_many :comments
  has_many :picture_tags
  has_many :tags, through: :picture_tags
end
