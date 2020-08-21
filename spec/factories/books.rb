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
FactoryBot.define do
  factory :book do
    # --TODO association設定--
    association :user
    name { 'マシューのゆめ' }
    image { File.new("#{Rails.root}/spec/factories/images/test.png") }
    publisher { '好学社' }
    author_name { 'レオ＝レオニ' }
    price { 600 }
    isbn { '4-7690-2017-1' }

    trait :book_with_comment do
      after(:create) do |book|
        3.times { create(:comment, book: book) }
      end
    end

    trait :with_image do
      image { File.new("#{Rails.root}/spec/factories/images/test.png") }
    end
  end
end
