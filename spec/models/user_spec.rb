require 'rails_helper'

RSpec.describe User, type: :model do
  let! (:user) do
    User.create({first_name: "Phillbert", last_name: "Cheng", email: "phillbert@phillbert.com"})
  end
  describe "validations" do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    it { should validate_length_of(:password).is_at_least(6) }
    it { should have_many(:pictures) }
    it { should have_many(:comments) }
    it { expect(user).to_not allow_value("DUMMY").for(:email) }
    it { expect(user).to allow_value("foo@bar.com").for(:email) }

    context "when validating an email" do
      it "should contain an @ symbol" do
        user.email = "asdf"
        expect{owner.save!}.to raise_error
      end
    end
  end

  describe "#first_name" do
    it "joins first name and last name" do
      expect(user.first_name).to eq("Phillbert")
    end
  end

  describe "#last_name" do
    it "joins first name and last name" do
      expect(user.last_name).to eq("Cheng")
    end
  end

end
