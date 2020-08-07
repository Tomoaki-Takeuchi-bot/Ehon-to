# == Schema Information
#
# Table name: relationships
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  follow_id  :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_relationships_on_follow_id              (follow_id)
#  index_relationships_on_user_id                (user_id)
#  index_relationships_on_user_id_and_follow_id  (user_id,follow_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (follow_id => users.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Relationship, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
