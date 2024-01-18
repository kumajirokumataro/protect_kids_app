require 'rails_helper'

RSpec.describe FreePost, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:kind) }
  it { should validate_presence_of(:target_child_age) }
  it { should validate_length_of(:title).is_at_most(100) }
  it { should validate_length_of(:content).is_at_most(1500) }
end