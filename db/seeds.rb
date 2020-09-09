Faker::Config.locale = :ja

1.upto(20) do |i|
  name = Faker::Name.name
  image = open("#{Rails.root}/db/fixtures/avatar/avatar-#{i}.jpg")
  email = "sample-#{i}@example.com"
  password = 'password'
  User.create!(
    image: image,
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    created_at: Time.zone.now
  )
end

# Book 作成
User.find_by(email: 'sample-1@example.com').books.create!(
  tag_list: %w[こころがあったかい話],
  name: 'こんとあき',
  image: open("#{Rails.root}/db/fixtures/ehon/ehon-1.jpg"),
  publisher: '福音館書店',
  author_name: '林明子',
  price: 1300,
  isbn: '9784834008302',
  created_at: Random.rand(Time.zone.now..Time.zone.now.next_year)
)

User.find_by(email: 'sample-2@example.com').books.create!(
  tag_list: %w[ゆかいな話],
  name: 'きんぎょがにげた',
  image: open("#{Rails.root}/db/fixtures/ehon/ehon-2.jpg"),
  publisher: '福音館書店',
  author_name: '五味太郎',
  price: 900,
  isbn: '9784834008999',
  created_at: Random.rand(Time.zone.now..Time.zone.now.next_year)
)

User.find_by(email: 'sample-3@example.com').books.create!(
  tag_list: %w[ゆかいな話],
  name: 'おばけの天ぷら',
  image: open("#{Rails.root}/db/fixtures/ehon/ehon-3.jpg"),
  publisher: 'ポプラ社',
  author_name: 'せなけいこ',
  price: 1200,
  isbn: '9784591004890',
  created_at: Random.rand(Time.zone.now..Time.zone.now.next_year)
)

User.find_by(email: 'sample-4@example.com').books.create!(
  tag_list: %w[ゆかいな話 こころがあったかい話],
  name: 'どろんこハリー',
  image: open("#{Rails.root}/db/fixtures/ehon/ehon-4.jpg"),
  publisher: '福音館書店',
  author_name: 'マーガレット・ブロイ・グレアム',
  price: 1200,
  isbn: '9784834000207',
  created_at: Random.rand(Time.zone.now..Time.zone.now.next_year)
)

User.find_by(email: 'sample-5@example.com').books.create!(
  tag_list: %w[ないた話 こころがあったかい話],
  name: 'ずーっとずっとだいすきだよ',
  image: open("#{Rails.root}/db/fixtures/ehon/ehon-5.jpg"),
  publisher: '評論社',
  author_name: 'ハンス・ウィルヘルム',
  price: 1200,
  isbn: '9784566002760',
  created_at: Random.rand(Time.zone.now..Time.zone.now.next_year)
)

User.find_by(email: 'sample-6@example.com').books.create!(
  tag_list: %w[こころがあったかい話],
  name: 'おしいれのぼうけん',
  image: open("#{Rails.root}/db/fixtures/ehon/ehon-6.jpg"),
  publisher: '童心社',
  author_name: 'ふるたたるひ',
  price: 1300,
  isbn: '9784494006069',
  created_at: Random.rand(Time.zone.now..Time.zone.now.next_year)
)

User.find_by(email: 'sample-7@example.com').books.create!(
  tag_list: %w[ためになる話],
  name: 'スイミー',
  image: open("#{Rails.root}/db/fixtures/ehon/ehon-7.jpg"),
  publisher: '好学社',
  author_name: 'レオ・レオニ',
  price: 1456,
  isbn: '9784769020011',
  created_at: Random.rand(Time.zone.now..Time.zone.now.next_year)
)

User.find_by(email: 'sample-8@example.com').books.create!(
  tag_list: %w[ふしぎな話],
  name: 'かようびのよる',
  image: open("#{Rails.root}/db/fixtures/ehon/ehon-8.jpg"),
  publisher: '徳間書店',
  author_name: 'デヴィット・ウィーズナー',
  price: 1400,
  isbn: '9784198611910',
  created_at: Random.rand(Time.zone.now..Time.zone.now.next_year)
)

User.find_by(email: 'sample-9@example.com').books.create!(
  tag_list: %w[ためになる話],
  name: 'おこだでませんように',
  image: open("#{Rails.root}/db/fixtures/ehon/ehon-9.jpg"),
  publisher: '小学館',
  author_name: 'くすのきしげのり',
  price: 1500,
  isbn: '9784097263296',
  created_at: Random.rand(Time.zone.now..Time.zone.now.next_year)
)

User.find_by(email: 'sample-10@example.com').books.create!(
  tag_list: %w[こころがあったかい話],
  name: 'マシューのゆめ',
  image: open("#{Rails.root}/db/fixtures/ehon/ehon-10.jpg"),
  publisher: '好学社',
  author_name: 'レオ・レオニ',
  price: 1456,
  isbn: '9784769020172',
  created_at: Random.rand(Time.zone.now..Time.zone.now.next_year)
)
