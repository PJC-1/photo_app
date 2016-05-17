class Picture < ActiveRecord::Base
  mount_uploader :pic_img, PicImgUploader

  belongs_to :user
  has_many :comments
  has_many :picture_tags
  has_many :tags, through: :picture_tags

  # returns pictures with that tag name
  def self.tagged_wtih(name)
    Tag.find_by_name!(name).pictures
  end

  # fetches all tags with a count
  def self.tag_counts
    Tag.select("tags.*, count(picture_tags.tag_id) as count").
    joins(:picture_tags).group("picture_tags.tag_id")
  end

  # returns list of the the tags
  def tag_list
    tags.map(&:name).join(", ")
  end

  # sets a list of tags
  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

end
