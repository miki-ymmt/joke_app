# README

## サービス名
![image](https://github.com/miki-ymmt/joke_app/assets/156039979/93ff9b7a-f999-4dd3-b1df-c17045708444)

[EVERYDAY JOKE SHOW](https://joke-maker.onrender.com/)


## サービス概要
「EVERYDAY JOKE SHOW」は、元気で面白いAIのキャラクターが、ユーザーによって選ばれたテーマに沿って小話を生成するアプリです。
日常のちょっとした瞬間に笑いを届けることを目指しています。
作成された小話を読んでユーザーが自由にタイトルをつけて投稿することができます。
テーマを選び、小話を聞き、タイトルを決めるという簡単なステップで、誰でも手軽に楽しめます。


## このサービスを作った理由
時間ができた時にふと誰かの話が聞きたいけれど、多忙な日々の中で人と会う機会が減り、楽しさを共有したり誰かの考えに触れる機会が減っていると感じています。
人と直接会う機会がなかなかなくても笑顔になれる、価値観に触れられるような場をAIで作れたらいいなと思い、このサービスを開発しました。
自身が関西出身で親しみがあるコミュニケーションを大切にしてきたことから、馴染みがある関西弁を取り入れ、AIのキャラクターを通してアプリに親しみを持ってもらえたら嬉しいという思いがあります。


## 機能
- 会員登録・ログイン機能・パスワードリセット機能
  - sorceryを使用して、登録・ログイン機能・パスワードリセット機能を実装
- 小話生成機能
  - ユーザーが選んだテーマに沿った小話の生成をOpenAI APIによって実施。
  - ユーザーが生成された小話に対してタイトルを考えて投稿。
- 小話のタイトル編集、削除機能
  - ログインユーザーのみ、自分の投稿の編集と削除が可能
- 小話の一覧検索機能
  - テーマやタイトルによる検索機能
- マイページ
  - ユーザーのプロフィールの編集とアカウントの削除
  - ログインユーザーの投稿のみの一覧閲覧機能
- xへのシェア機能
- お問い合わせフォーム
  - Googleフォームを設置し、不具合やご意見などを収集できる。


## 使用技術
| 技術         | 詳細                                                                 |
|--------------|----------------------------------------------------------------------|
| フロントエンド | HTML, CSS, JavaScript, Tailwind CSS 3.4.4, DaisyUI 4.12.2                        |
| バックエンド   | Ruby 3.2.3, Rails 7.1.3.1                                                       |
| データベース   | PostgreSQL                                                          |
| 認証         |  Sorcery                                             |
| デプロイ     | Render                                             |
| バージョン管理 | Git, GitHub                                                   |                                                     
| API       | OpenAI API                                                        |
| 開発環境      | Docker                                                               

## ユーザー層に関して
- 年齢性別関係なく、誰かの話を聞きたいと思っている人
- 面白い話を聞いて笑いたいと思っている人
- 人とのコミュニケーションが減っていると感じている人

## サービスの差別化ポイント
[比較したサービス]
[AIで大阪のおばちゃんを作る技術
](https://zenn.dev/kazuwombat/articles/1abf9fb145baa5)

[差別化ポイント]

- 上記アプリは、LINEアカウントのみでの使用想定である
→本アプリは特定のSNSに限定せずスマートフォンやPCからアクセス可能であり、ほかのユーザーの投稿を閲覧することができるので、ユーザーが自分の好きな話を聞くことができたり、検索できる。
- テーマが選べることで、ユーザーが自分の好きな話を聞くことができる
- ユーザーが生成された小話に対してタイトルを考えて投稿することができることでアプリとの接点が増える
- ユーザーが自分の投稿のみの一覧閲覧機能があることで、自分の投稿を見返すことができる