# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_categories_on_name  (name) UNIQUE
#
class Category < ApplicationRecord
  validates :name, presence:true, length: { maximum:50 }
  has_many :books, through: :books_categories
  has_many :books_categories, dependent: :destroy
end
