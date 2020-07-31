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
#
FactoryBot.define do
  factory :book do
    # --TODO association設定--
    name { 'マシューのゆめ' }
    image { File.new("#{Rails.root}/spec/factories/images/test.png") }
    publisher { '好学社' }
    author_name { 'レオ＝レオニ' }
    author_image { File.new("#{Rails.root}/spec/factories/images/test2.png") }
    price { 600 }
    isbn { 4-7690-2017-1 }
  end
end
