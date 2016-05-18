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
  end
end
