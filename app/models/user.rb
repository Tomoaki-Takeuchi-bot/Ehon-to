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
class User < ApplicationRecord # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable # Include default devise modules. Others available are:
  devise :database_authenticatable,
         :registerable,
         :rememberable,
         :validatable

  attr_accessor :current_password

  THUMBNAIL_SIZE = [100, 100].freeze
  mount_uploader :image, ImageUploader

  validates :name, presence: true, length: { maximum: 30 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  before_validation { email.downcase! }

  validates :email,
            presence: true,
            uniqueness: true,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX }

  has_many :books, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy # タグ機能（Userモデルからいいねした本を取得するためリレーション追加）
  has_many :favorite_books, through: :favorites, source: :book # ユーザーフォロー機能---
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships,
           class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user #---

  def follow(other_user_id)
    relationships.find_or_create_by(follow_id: other_user_id) unless id == other_user_id.to_i
  end

  def unfollow(other_user_id)
    relationship = relationships.find_by(follow_id: other_user_id)
    relationship&.destroy
  end

  def following?(other_user)
    followings.include?(other_user)
  end
end
