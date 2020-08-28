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
require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:book) { create(:book) }
  let(:user) { create(:user) }

  context 'has_favorites?' do
    subject { book.has_favorites?(user) }

    context 'has no favorites' do
      it 'false' do
        expect(subject).to eq(false)
      end
    end

    context 'has favorites' do
      before do
        book.like(user.id)
      end
      it 'true' do
        expect(subject).to eq(true)
      end
    end
  end

  context 'like/unlike' do
    it 'anable to switch like unlike' do
      book.like(user.id)
      expect(book.favorites.size).to eq(1)
      expect(book.favorites.first.user_id).to eq(user.id)

      book.unlike(user.id)
      expect(book.favorites.size).to eq(0)
    end
  end
end
