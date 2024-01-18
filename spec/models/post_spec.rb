require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should belong_to(:area) }
  it { should belong_to(:user) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:type) }
  it { should validate_presence_of(:latitude) }
  it { should validate_presence_of(:longitude) }
  it { should validate_length_of(:title).is_at_most(100) }
  it { should validate_length_of(:content).is_at_most(200) }
end