require 'rails_helper'

RSpec.describe 'ユーザー', type: :request do
  before do
    timestamp!
    log_in
  end

  describe 'ユーザー取得動作' do
    before do
      (1..2).each do |index|
        create(:user, name: "User#{index}#{timestamp}")
      end
    end
    it 'ユーザー一覧ページのレンダー動作' do
      get users_path
      expect(response.status).to eq(200) # リクエスト200にて確認
      expect(response.body).to include(current_user.name)
      expect(response.body).to include("User1#{timestamp}")
      expect(response.body).to include("User2#{timestamp}")
    end
  end

  describe 'ユーザー詳細' do
    it 'showページのレンダー動作確認' do
      get user_path(current_user)
      expect(response.status).to eq(200) # リクエスト200にて確認
      expect(response.body).to include(current_user.name)
      expect(response.body).to include(current_user.email)
    end
  end

  describe 'フォロー動作' do
    let(:other_user) { create(:user) }

    context 'フォローしていない時' do
      it 'フォロー可能' do
        expect do
          post user_follow_path(other_user), xhr: true
        end.to change { Relationship.count }.by(1)
        expect(current_user.following?(other_user)).to eq(true)
      end
    end

    context 'フォローしている時' do
      it 'フォロー解除可能' do
        current_user.follow(other_user.id)
        expect(current_user.following?(other_user)).to eq(true)
        expect do
          post user_follow_path(other_user), xhr: true
        end.to change { Relationship.count }.by(-1)
        expect(current_user.following?(other_user)).to eq(false)
      end
    end
  end
end
