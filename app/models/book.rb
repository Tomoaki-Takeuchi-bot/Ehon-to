# == Schema Information
#
# Table name: books
#
#  id          :bigint           not null, primary key
#  author_name :string           not null
#  image       :string
#  isbn        :string
#  name        :string           not null
#  price       :integer
#  publisher   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
# Indexes
#
#  index_books_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Book < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  mount_uploader :image, ImageUploader

  # タグ設定---
  acts_as_taggable_on :tags

  TAGS = %w[
    ゆかいな話
    ふしぎな話
    こわい話
    ためになる話
    ないた話
    こころがあったかい話
  ].freeze
  #---

  THUMBNAIL_SIZE = [150, 150].freeze
  # バリデーション設定
  # （presence: 書籍名、画像イメージ、作者名のみ）
  validates :name, presence: true, length: { maximum: 200 }
  validates :author_name, presence: true
  validates :image, presence: true

  scope :find_with_comments, ->(id) { find(id) }

  def has_favorites?(favorite_user)
    favorites.to_a.find do |favorite|
      favorite.user_id == favorite_user.id
    end.present?
  end

  def like(favorite_user_id)
    favorites.new(user_id: favorite_user_id).save!
  end

  def unlike(favorite_user_id)
    favorite_id = favorites.find_by(user_id: favorite_user_id).id
    favorites.destroy(favorite_id)
  end
end
