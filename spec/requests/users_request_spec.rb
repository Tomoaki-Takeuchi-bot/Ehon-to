require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before do
    timestamp!
    log_in
  end

  describe 'GET /users' do
    before do
      (1..2).each do |index|
        create(:user, name: "User#{index}#{timestamp}")
      end
    end
    it 'render to index page' do
      get users_path
      expect(response.status).to eq(200)
      expect(response.body).to include(current_user.name)
      expect(response.body).to include("User1#{timestamp}")
      expect(response.body).to include("User2#{timestamp}")
    end

    context 'when search' do
      it 'render to index page specify name' do
        get users_path(q: { name_cont: timestamp })
        expect(response.status).to eq(200)
        expect(response.body).not_to include(current_user.name)
        expect(response.body).to include("User1#{timestamp}")
        expect(response.body).to include("User2#{timestamp}")
      end
    end
  end

  describe 'GET /users/:id' do
    it 'render to show page' do
      get user_path(current_user)
      expect(response.status).to eq(200)
      expect(response.body).to include(current_user.name)
      expect(response.body).to include(current_user.email)
    end
  end

  describe 'POST /users/:user_id/follow' do
    let(:other_user) { create(:user) }

    context 'not followed' do
      it 'follow' do
        expect do
          post user_follow_path(other_user), xhr: true
        end.to change { Relationship.count }.by(1)
        expect(current_user.following?(other_user)).to eq(true)
      end
    end

    context 'followed' do
      it 'unfollow' do
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
