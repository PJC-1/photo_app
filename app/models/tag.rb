class Tag < ActiveRecord::Base
  has_many :picture_tags
  has_many :pictures, through: :picture_tags
end
