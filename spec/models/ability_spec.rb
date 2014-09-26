require 'rails_helper'

RSpec.describe Ability, :type => :model do
  it "should allow admin to manage all" do
    abilty = Ability.new create(:admin)
    expect(abilty.can? :manage, :all).to eq(true)
  end
end
