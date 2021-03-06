# Ehon-to

小さなお子様の読書習慣における、読んだ本の履歴を管理できるアプリです。<br>
読んだ本を忘れないように、また子供がどんな感想をもったのか記録できます。<br>
他のユーザーの方が読んだ本、カテゴリ毎の絵本の検索もできます。

## URL
https://www.ehon-to.net/

## アプリイメージ

![Ehon-to](https://user-images.githubusercontent.com/61924934/99157917-981e1380-2710-11eb-9fd6-f4fce8a9f477.gif)

## AWS 構成図

![Web App (PF) Architecture (6)](https://user-images.githubusercontent.com/61924934/96552430-b6017f80-12ee-11eb-9cd4-44efa6f63b00.png)

## ER 図

<img width="598" alt="スクリーンショット 2020-10-20 16 19 29" src="https://user-images.githubusercontent.com/61924934/96553563-4ab8ad00-12f0-11eb-84d1-863055369a37.png">

## アプリ開発背景

自分が子供の成長を考えた時、多くの絵本を読み聞かせしてあげたいと思いました。<br>
しかし、考えていた以上に子供が本と触れ合う場所は多くありました。<br>
幼稚園・図書館での読み聞かせ・友達と家に遊びに行った際・母親が読んだ本 等<br>
自分が知らない場所で多くの本と触れ合っている事に気付きました。<br>
本の評価サイトは多くありますが、幼少期の読書履歴管理とコミュニティ間の情報共有ツールが少ないと考え<br>
子供の読書管理と幼少期のコミュニティ間での絵本情報の共有で使用してもらう事を想定して作成しました。<br><br>

【追記】<br>
本アプリは幼稚園父母のアプリ使用感を元に都度フィードバックを元に更新を行っております。<br>
2021年3月まで更新作業を行った後にアプリコード引き渡しと運用をどなたかに委託する予定にて<br>
活動を行っております。

## アプリ機能一覧

- ユーザー機能
  - 新規登録・ログイン・ログアウト
  - パスワードリセット機能
  - マイページ編集機能
- 本の管理
  - 本の情報登録・本の画像・作者・価格・分類コード登録
- コメント機能
  - 読後感想簡易コメント機能
- タグ機能
  - 投稿者による本のタグ機能
- 検索機能
  - 本名・タグ・キーワード検索
- フォロー機能
  - フォロー、フォローワー表示
- ページネーション機能
- セキュリティチェック機能
  - XSS, SQL インジェクション, Dos 攻撃 (Brakeman 使用)
  - Gem 脆弱性検知(bundler-audit 使用)

## 使用技術

- AWS
  - EKS ( node2, nodes-min2, nodes-max5, cluster-version:1.17.9 )
  - CDN ( CloudFront:S3 による画像配信に使用 )
  - CloudFormation ( EKS 等リソース管理 )
  - RDS ( PostgreSQL )
  - IAM, VPC, ELB, EC2, ECR, Route53, ACM,
  - Secrets Manager ( RDS 設定 )
  - SystemManager ( セッションマネージャー )
- Ruby : v2.6.6
- Ruby on Rails : v6.0.3.3
- RSpec, Capybara, Chrome ( 単体テスト、システムテスト )
- Puma ( Web サーバー )
- GitHub Actions ( CI:Linter, Security, CD:Build to ECR )
- Docker : v19.03.13
- Docker-compose : v1.27.4
- shell script ( Docker-compose bash )

## project version log

- 2020.9.19
  v1.0.0
  v1.0.1

- 2020.9.26
  v1.1.0 for Dockerfile production mode test

- 2020.9.28
  v1.2.0 (fix gemfile etc)
  v1.2.1
  v1.2.2 (revert database.yml)
  v1.2.3 (revert hotfixes)
  v1.2.4

- 2020.9.30
  v1.3.0 (Dockerfile revision)

- 2020.10.1
  v1.4.0 (Carrierwave env revision)
  v1.5.0 (mail-dev revision)
  v1.6.0 (credential release)
  v1.6.1

- 2020.10.2
  v1.6.2 (credentila reset)

- 2020.10.4
  v1.6.3 (credential rebuild)

- 2020.10.5
  v1.6.4 (database.yml production set)

- 2020.10.10
  v1.7.0 (fog error work)

- 2020.10.11
  v1.8.0 (CloudFront https)

- 2020.10.12
  v1.8.1(image https)

- 2020.10.13
  v1.9.0(dockerfile revision)
  v1.10.0 (dockerfile revison webpacker compile)
  v1.10.1 (bundle exec add)
  v1.10.2 (RAILS_ENV add)

- 2020.10.16
  v1.11.0 (dockerfile revision webpack,migrate,seed)
  v1.11.1(dockerfile rm seed cmd)

- 2020.10.18
  v1.12.0(public_file_server-set)

- 2020.10.20
  v2.0.0(:tada: deployment)

- 2020.10.20-30
  v2.1.1(develop2 try1)
  v2.1.2(try2)

- 2020.10.31-11.6
  v2.2.0(admin function set &
         rm forgetpassword reset )
  v2.2.1(webpacker error image folder)
  v2.2.2(images folder set)

- 2020.11.6
  v3.0.0(:tada: deployment version3)

- 2020.11.7
  v3.1.0 (start search new function plan )

- 2020.11.15
  v4.0.0 (:tada: new function add version)
  - admin mail secret
  - login-user-books-list
  - users-index-pagenate-fix
  - home-index-design-update
  - users-show-revision
  - dockerfile continuing data file

- 2020.11.15
  v4.1.0
  - home.index style fix

- 2020.11.20
  remove WIP message
