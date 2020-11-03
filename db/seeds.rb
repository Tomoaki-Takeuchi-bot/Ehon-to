Faker::Config.locale = :ja

User.create!(
  remote_image_url: "https://image.ehon-to.net/DB/fixutures/admin/admin.png",
  name: "Admin User",
  email: "admin@example.com",
  password: "admin12345",
  password_confirmation: "admin12345",
  admin: true
)

1.upto(20) do |i|
  name = Faker::Name.name
  remote_image_url =
    "https://image.ehon-to.net/DB/fixutures/avatar/avatar-#{i}.jpg"
  email = "sample-#{i}@example.com"
  password = 'password'
  User.create!(
    remote_image_url: remote_image_url,
    name: name,
    email: email,
    password: password,
    password_confirmation: password
  )
end

# Book 作成
User.find_by(email: 'sample-1@example.com').books.create!(
  tag_list: %w[こころがあったかい話],
  name: 'こんとあき',
  remote_image_url: 'https://image.ehon-to.net/DB/fixutures/ehon/ehon-1.jpg',
  publisher: '福音館書店',
  author_name: '林明子',
  price: 1300,
  isbn: '9784834008302'
)

User.find_by(email: 'sample-2@example.com').books.create!(
  tag_list: %w[ゆかいな話],
  name: 'きんぎょがにげた',
  remote_image_url: 'https://image.ehon-to.net/DB/fixutures/ehon/ehon-2.jpg',
  publisher: '福音館書店',
  author_name: '五味太郎',
  price: 900,
  isbn: '9784834008999'
)

User.find_by(email: 'sample-3@example.com').books.create!(
  tag_list: %w[ゆかいな話],
  name: 'おばけの天ぷら',
  remote_image_url: 'https://image.ehon-to.net/DB/fixutures/ehon/ehon-3.jpg',
  publisher: 'ポプラ社',
  author_name: 'せなけいこ',
  price: 1200,
  isbn: '9784591004890'
)

User.find_by(email: 'sample-4@example.com').books.create!(
  tag_list: %w[ゆかいな話 こころがあったかい話],
  name: 'どろんこハリー',
  remote_image_url: 'https://image.ehon-to.net/DB/fixutures/ehon/ehon-4.jpg',
  publisher: '福音館書店',
  author_name: 'マーガレット・ブロイ・グレアム',
  price: 1200,
  isbn: '9784834000207'
)

User.find_by(email: 'sample-5@example.com').books.create!(
  tag_list: %w[ないた話 こころがあったかい話],
  name: 'ずーっとずっとだいすきだよ',
  remote_image_url: 'https://image.ehon-to.net/DB/fixutures/ehon/ehon-5.jpg',
  publisher: '評論社',
  author_name: 'ハンス・ウィルヘルム',
  price: 1200,
  isbn: '9784566002760'
)

User.find_by(email: 'sample-6@example.com').books.create!(
  tag_list: %w[こころがあったかい話],
  name: 'おしいれのぼうけん',
  remote_image_url: 'https://image.ehon-to.net/DB/fixutures/ehon/ehon-6.jpg',
  publisher: '童心社',
  author_name: 'ふるたたるひ',
  price: 1300,
  isbn: '9784494006069'
)

User.find_by(email: 'sample-7@example.com').books.create!(
  tag_list: %w[ためになる話],
  name: 'スイミー',
  remote_image_url: 'https://image.ehon-to.net/DB/fixutures/ehon/ehon-7.jpg',
  publisher: '好学社',
  author_name: 'レオ・レオニ',
  price: 1456,
  isbn: '9784769020011'
)

User.find_by(email: 'sample-8@example.com').books.create!(
  tag_list: %w[ふしぎな話],
  name: 'かようびのよる',
  remote_image_url: 'https://image.ehon-to.net/DB/fixutures/ehon/ehon-8.jpg',
  publisher: '徳間書店',
  author_name: 'デヴィット・ウィーズナー',
  price: 1400,
  isbn: '9784198611910'
)

User.find_by(email: 'sample-9@example.com').books.create!(
  tag_list: %w[ためになる話],
  name: 'おこだでませんように',
  remote_image_url: 'https://image.ehon-to.net/DB/fixutures/ehon/ehon-9.jpg',
  publisher: '小学館',
  author_name: 'くすのきしげのり',
  price: 1500,
  isbn: '9784097263296'
)

User.find_by(email: 'sample-10@example.com').books.create!(
  tag_list: %w[こころがあったかい話],
  name: 'マシューのゆめ',
  remote_image_url: 'https://image.ehon-to.net/DB/fixutures/ehon/ehon-10.jpg',
  publisher: '好学社',
  author_name: 'レオ・レオニ',
  price: 1456,
  isbn: '9784769020172'
)
