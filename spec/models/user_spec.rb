# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
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
  before do
    @user = build(:user)
  end

  it '有効：ファクトリー確認' do
    expect(build(:user)).to be_valid
  end

  it '有効：名前、メール、パスワードがある場合' do
    user = User.new(
      name: 'TestUser',
      email: 'test@example.com',
      password: 'password'
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
end
