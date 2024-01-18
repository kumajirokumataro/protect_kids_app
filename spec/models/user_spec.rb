require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:posts).dependent(:destroy) }
  it { should have_many(:free_posts).dependent(:destroy) }
  it { should have_many(:selectings).dependent(:destroy) }
  it { should have_many(:areas).through(:selectings) }
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_most(40) }
  it { should validate_presence_of(:email) }
  it { should validate_length_of(:email).is_at_most(80) }
  it { should validate_length_of(:nickname).is_at_most(40) }
  it { should validate_length_of(:self_introduction).is_at_most(200) }
  # it { should validate_uniqueness_of(:email) }
  it { should allow_value('user@example.com').for(:email) }
  it { should_not allow_value('invalid_email').for(:email) }
  it { should validate_length_of(:password_digest).is_at_least(6) }

  describe "一意性を確認するテスト" do
    let!(:user) { FactoryBot.create(:user) }
    let(:area) { FactoryBot.build(:area, "徳丸") }
    it "同じものは作成できない" do
      expect(area.valid?).to be_falsey
    end
  end
  
end