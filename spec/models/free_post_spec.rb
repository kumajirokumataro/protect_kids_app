require 'rails_helper'

RSpec.describe FreePost, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:kind) }
  it { should validate_presence_of(:target_child_age) }
  it { should validate_length_of(:title).is_at_most(100) }
  it { should validate_length_of(:content).is_at_most(1500) }
  
  describe '検索機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:freepost) { FactoryBot.create(:free_post, user: user) }
    let!(:other_user) { FactoryBot.create(:other_user) }
    let!(:second_freepost) { FactoryBot.create(:second_free_post, user: other_user ) }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含む投稿が絞り込まれる" do
        expect(FreePost.title_search('大火傷')).to include(freepost)
        expect(FreePost.title_search('大火傷')).not_to include(second_freepost)
        expect(FreePost.title_search('大火傷').count).to eq 1
      end
    end
    context 'scopeメソッドで子供の対象年齢検索をした場合' do
      it "対象年齢に完全一致するタスクが絞り込まれる" do
        expect(FreePost.target_child_age_search('0歳')).to include(freepost)
        expect(FreePost.target_child_age_search('0歳')).not_to include(second_freepost)
        expect(FreePost.target_child_age_search('0歳').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(FreePost.search('大火傷','0歳')).to include(freepost)
        expect(FreePost.search('大火傷','0歳')).not_to include(second_freepost)
        expect(FreePost.search('大火傷','0歳').count).to eq 1
      end
    end
  end
end