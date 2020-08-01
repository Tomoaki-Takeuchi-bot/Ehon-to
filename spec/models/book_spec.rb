# == Schema Information
#
# Table name: books
#
#  id           :bigint           not null, primary key
#  author_image :string
#  author_name  :string           not null
#  image        :string
#  isbn         :integer
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
require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:book) { create(:book) }

  it '有効ファクトリーの確認' do
    expect(book).to be_valid
  end

end
