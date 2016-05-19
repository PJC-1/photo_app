require 'rails_helper'

RSpec.describe Picture, type: :model do
  let! (:picture) do
    Picture.create({title: "This is a pic title"})
  end
  describe "validations" do
    it { should have_many(:tags) }
    it { should have_many(:picture_tags) }
    it { should have_many(:comments) }

  end
end
