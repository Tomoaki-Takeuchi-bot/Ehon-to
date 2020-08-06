# == Schema Information
#
# Table name: comments
#
#  id            :bigint           not null, primary key
#  comment       :string
#  feeling_image :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  book_id       :bigint
#  user_id       :bigint
#
# Indexes
#
#  index_comments_on_book_id  (book_id)
#  index_comments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :comment do
    association :user
    association :book
    comment { "テスト投稿です。" }
  end
end
