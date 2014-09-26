require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) { create :user }

  describe "#newcomer?" do
    it "return true for first sign_in" do
      user.update(:sign_in_count => 0)
      expect(user.newcomer?).to eq true

      user.update(:sign_in_count => 1)
      expect(user.newcomer?).to eq true
    end

    it "return false for subsequent sign_in" do
      user.update(:sign_in_count => 2)
      expect(user.newcomer?).to eq false
    end
  end

  shared_examples 'group_member' do |user_type|
    describe "##{user_type}?" do
      it "should return true is user in #{user_type} group" do
        expect(create(user_type).send("#{user_type}?")).to eq true
      end

      it "should return false if user not in #{user_type} group" do
        expect(create(:user).send("#{user_type}?")).to eq false
      end
    end
  end

  it_behaves_like 'group_member', :admin

  describe "#force_profile_update?" do
    it "should return false if user profile updated" do
      user.update(:sign_in_count => 1)
      user.update(key: 'sdasdfsad')
      expect(user.force_profile_update?).to eq false
    end

    it "should return false if user is not a newcomer" do
      user.update(:sign_in_count => 2)
      expect(user.force_profile_update?).to eq false
    end

    it "should return true if user profile not updated and is a newcomer" do
      newcomer = create :newcomer
      expect(newcomer.force_profile_update?).to eq true
    end
  end
end
