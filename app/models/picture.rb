class Picture < ActiveRecord::Base
  acts_as_votable
  mount_uploader :pic_img, PicImgUploader

  belongs_to :user
  has_many :comments
  has_many :picture_tags, dependent: :destroy
  has_many :tags, through: :picture_tags


  # used for displaying random pictures in the picture index
  def self.randomism
    random_arr = []
    new_arr = []
    c = Picture.count
    pictures = Picture.all
    id_arr = pictures.map(&:id)
    c.times do
      random_arr << id_arr[rand(0...c)]
    end
    c.times do
      new_arr << random_arr.map{|h| Picture.find_by_id(h)}
    end
    new_arr
  end

  # returns pictures with that tag name
  def self.tagged_with(name)
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

  def self.search(query)
    where("tag like ?", "%#{query}%")
  end

end
