# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE)
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  image                  :string
#  name                   :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = build(:user) }

  it '有効：ファクトリー確認' do
    expect(build(:user)).to be_valid
  end

  it '有効：名前、メール、パスワードがある場合' do
    user =
      User.new(
        name: 'TestUser', email: 'test@example.com', password: 'password'
      )
    expect(user).to be_valid
  end

  describe '有効・無効確認' do
    it '名前がない場合、無効' do
      @user.name = ''
      @user.valid?
      expect(@user).to_not be_valid
    end
  end

  # フォロー機能の確認
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  context 'フォロー状態の確認' do
    subject { user.following?(other_user) }
    context 'フォローしている時' do
      before { user.follow(other_user.id) }
      it 'trueを返す' do
        expect(subject).to eq(true)
      end
    end

    context 'フォローしていない時' do
      it 'falseを返す' do
        expect(subject).to eq(false)
      end
    end
  end

  context 'フォロー・フォロー解除動作' do
    it 'フォローした後にフォロー解除可能' do
      user.follow(other_user.id)
      expect(user.followings.size).to eq(1)
      expect(user.followings.first.id).to eq(other_user.id)

      user.unfollow(other_user.id)
      expect(user.followings.size).to eq(0)
    end

    it '自分自身のフォロー不可' do
      user.follow(user.id)
      expect(user.followings.size).to eq(0)
    end
  end
end
