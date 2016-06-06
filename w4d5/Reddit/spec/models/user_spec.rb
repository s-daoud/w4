require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) do
    User.new(username: "ari", password: "nutmeg")
  end

  it {
    should validate_presence_of(:username)
  }
  it {
    should validate_presence_of(:password_digest)
  }
  it {
    should validate_length_of(:password).is_at_least(6)
  }

  it {
    should have_many(:subreddits)
  }
  it {
    should have_many(:user_votes)
  }
  it {
    should have_many(:comments)
  }

  describe "#reset_session_token!" do
    it "sets a new session token on the user" do
      old_session_token = user.session_token
      user.reset_session_token!

      expect(user.session_token).to_not eq(old_session_token)
    end

    it "returns the new session token" do
      expect(user.reset_session_token!).to eq(user.session_token)
    end
  end

  describe "#is_password?" do
    it "verifies a password is correct" do
      expect(user.is_password?("nutmeg")).to be true
    end

    it "verifies a password is not correct" do
      expect(user.is_password?("afadsgsf")).to be false
    end
  end

  describe ".find_by_credentials" do
    before { user.save! }

    it "returns user given good credentials" do
      expect(User.find_by_credentials("ari", "nutmeg")).to eq(user)
    end

    it "returns nil given bad credentials" do
      expect(User.find_by_credentials("ari", "agsgasfsd")).to eq(nil)
    end
  end
end
