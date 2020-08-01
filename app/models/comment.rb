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
class Comment < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :comment, length: { maximum: 500 }
end
