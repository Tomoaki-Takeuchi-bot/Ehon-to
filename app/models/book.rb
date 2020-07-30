# == Schema Information
#
# Table name: books
#
#  id           :bigint           not null, primary key
#  author_image :string
#  author_name  :string
#  image        :string
#  isbn         :integer
#  name         :string
#  price        :integer
#  publisher    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Book < ApplicationRecord
  # <TODO>
  # アソシエーション設定は別スケジュールにて実装

  # バリデーション設定
  # （presence: 書籍名、画像イメージ、作者名のみ）
  validates :name, presence: true, length: { maximum: 100 }

  # <TODO>
  # 画像イメージ機能実装後に設定
  # validates :image, presende: true
end
