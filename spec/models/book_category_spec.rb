# == Schema Information
#
# Table name: book_categories
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  book_id     :integer
#  category_id :integer
#
# Indexes
#
#  index_book_categories_on_book_id                  (book_id)
#  index_book_categories_on_book_id_and_category_id  (book_id,category_id) UNIQUE
#  index_book_categories_on_category_id              (category_id)
#
require 'rails_helper'

RSpec.describe BookCategory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
