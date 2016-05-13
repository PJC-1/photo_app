class PictureTag < ActiveRecord::Base
  belongs_to :picture
  belongs_to :tag
end
