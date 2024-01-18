require 'rails_helper'

RSpec.describe Area, type: :model do

  it { should have_many(:selectings).dependent(:destroy) }
  it { should have_many(:posts) }
  it { should have_many(:users).through(:selectings) }
  it { should have_many(:selecting_users).through(:selectings).source(:user) }

  describe "一意性を確認するテスト" do
    let(:area) { FactoryBot.build(:area, "徳丸") }
    it "同じものは作成できない" do
      expect(area.valid?).to be_falsey
    end
  end

end