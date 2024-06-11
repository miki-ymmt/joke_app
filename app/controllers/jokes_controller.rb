class JokesController < ApplicationController
  before_action :require_login, except: [:index, :show] #ログインしていなくても一覧と詳細を見ることができる
  before_action :set_joke, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @q = Joke.includes(:user).ransack(params[:q])  #ransackを使用して検索フォームを作成する
    @jokes = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(6) #ページネーションを設定する
  end


  def show; end #選択されたジョークを表示する

  def new  #新しいジョークを作成する
    @themes = ["仕事", "学校", "家族", "友達", "食べ物", "お金", "趣味", "恋愛", "人生"]
  end

  def create  #選択されたテーマに沿ったジョークを生成する
    theme = params[:theme]  #フォームから送信されたテーマのパラメータを取得する
    joke_content = generate_joke(theme)  #OpenAI APIを使用してジョークを生成する
    @joke = Joke.new(content: joke_content, theme: theme, user: current_user)  #生成されたジョークをデータベースに保存する

    if @joke.save
      redirect_to edit_joke_path(@joke), notice: "小話が出来上がりました"  #ジョークが保存された場合、ジョーク編集ページにリダイレクトする
    else
      flash.now[:alert] = "もう一回テーマを選んでください"
      render :new, status: :unprocessable_entity  #ジョークが保存されなかった場合、新規ジョーク作成ページを再表示する
    end
  end

  def edit; end

  def update
    @joke = Joke.find(params[:id])  #選択されたジョークを取得する
    if @joke.update(joke_params)
      redirect_to joke_path(@joke), notice: "タイトルを保存しました"  #ジョークが更新された場合、ジョーク一覧ページにリダイレクトする
    else
      render :edit, status: :unprocessable_entity  #ジョークが更新されなかった場合、ジョーク詳細ページを再表示する
    end
  end

  def destroy
    @joke.destroy
    redirect_to jokes_path, notice: "小話を削除しました" #削除後にジョーク一覧ページにリダイレクトする
  end

  private

  def set_joke
    @joke = Joke.find(params[:id])  #選択されたジョークを取得する
  end

  def joke_params
    params.require(:joke).permit(:title, :user_id)
  end

  def authorize_user!
    redirect_to jokes_path, alert: "権限がありません" if @joke.user != current_user  #ジョークの作成者以外は編集、削除できないようにする
  end

  def generate_joke(theme)#OpenAI APIに送信するプロンプトを作成する
    prompt =  <<-PROMPT
    あんたは大阪出身の60歳の愉快なおばちゃんやで。以下のテーマについて関西弁で笑える面白いジョークを話してな～。ネタは必ず100字以上200字以下でお願いな。最後に関西人がよく言う,
    ほんまかどうかは知らんという意味の、"知らんけど(笑)"を追記してくれると嬉しいで！:
    テーマ: #{theme}
    PROMPT

    client = OpenAI::Client.new #OpenAIのAPIクライアントを初期化

    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: prompt }],
        max_tokens: 300, #生成されるテキストの最大トークン数を制御
        temperature: 0.7 # 生成されるテキストのランダム性を制御
      }
    )

    response.dig("choices",0,"message","content").strip
  end
end
