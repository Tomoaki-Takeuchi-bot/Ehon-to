require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:login_user) { create(:user) }
  before do
    timestamp!
    log_in(login_user)
  end

  describe 'GET /users' do
    before do
      (1..2).each { |index| create(:user, name: "User#{index}#{timestamp}") }
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
        expect(response.body).to include(current_user.name)
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
        expect { post user_follow_path(other_user), xhr: true }.to change {
          Relationship.count
        }.by(1)
        expect(current_user.following?(other_user)).to eq(true)
      end
    end

    context 'followed' do
      it 'unfollow' do
        current_user.follow(other_user.id)
        expect(current_user.following?(other_user)).to eq(true)
        expect { post user_follow_path(other_user), xhr: true }.to change {
          Relationship.count
        }.by(-1)
        expect(current_user.following?(other_user)).to eq(false)
      end
    end
  end

  describe 'admin' do
    describe 'DELETE /users/:user_id/user_delete' do
      let(:other_user) { create(:user) }

      context "when admin" do
        let(:login_user) { create(:user, :admin) }
        it 'delete user' do
          delete user_user_delete_path(other_user)
          expect(response).to redirect_to(root_path)
          follow_redirect!
          expect(response.body).to include('ユーザー抹消しました。')
        end
      end

      context "when not admin" do
        it 'raise error' do
          expect { delete user_user_delete_path(other_user) }.to raise_error("管理者限定機能です")
        end
      end
    end

  end
end
