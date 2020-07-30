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
require 'rails_helper'

RSpec.describe Book, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
