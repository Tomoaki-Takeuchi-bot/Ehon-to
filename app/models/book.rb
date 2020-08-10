# == Schema Information
#
# Table name: books
#
#  id           :bigint           not null, primary key
#  author_image :string
#  author_name  :string           not null
#  image        :string
#  isbn         :string
#  name         :string           not null
#  price        :integer
#  publisher    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint
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

  # タグ設定
  has_many :book_categories, dependent: :destroy
  has_many :categories, through: :book_categories

  # バリデーション設定
  # （presence: 書籍名、画像イメージ、作者名のみ）
  validates :name, presence: true, length: { maximum: 200 }
  validates :author_name, presence: true

  scope :find_with_comments, lambda { |id|
    includes(:favorites, comments: :user).find(id)
  }

  def has_favorites?(favorite_user)
    favorites.to_a.find { |favorite| favorite.user_id == favorite_user.id }.present?
  end

  def like(favorite_user_id)
    favorites.new(user_id: favorite_user_id).save!
  end

  def unlike(favorite_user_id)
    favorite_id = favorites.find_by(user_id: favorite_user_id).id
    favorites.destroy(favorite_id)
  end

  # --タグ機能--
  def save_categories(tags)
    # 現状カテゴリーの取得
    current_tags = self.categories.pluck(:name) unless self.categories.nil?
    # 古いカテゴリータグの取得
    old_tags = current_tags - tags
    # 新しいタグの取得
    new_tags = tags - current_tags

    # 古いタグを消去
    old_tags.each do |old_name|
      self.categories.delete Category.find_by(name:old_name)
    end

    # 新しいタグを作成
    new_tags.each do |new_name|
      article_category = Category.find_or_create_by(name:new_name)
      self.categories << article_category
    end
  end

  # <TODO>
  # 画像イメージ機能実装後に設定
  # validates :image, presende: true
end
