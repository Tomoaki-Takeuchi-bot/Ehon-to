# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE)
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  image                  :string
#  name                   :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :user do
    sequence(:name) { |i| "User#{i}" }
    sequence(:email) { |i| "email#{i}@sample.com" }
    password { 'password' }
  end

  factory :admin do
    association :user
    sequence(:name) { |i| "AdminUser#{i}" }
    sequence(:email) { |i| "admin#{i}@example.com" }
    password { 'admin12345' }
    admin { true }

    trait :user_with_admin do
      after(:create) do | admin |
        { create(:admin, admin: admin) }
      end
    end
  end
end
