class JokesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy] #ログインしていないユーザーをログインページにリダイレクトする
  before_action :set_joke, only: [:show, :edit, :update, :destroy]

  def index
    @jokes = Joke.page(params[:page]).order(created_at: :desc).per(6) #ページネーションを設定する
  end

  def show #選択されたジョークを表示する
  end

  def new  #新しいジョークを作成する
    @themes = ["仕事", "学校", "家族", "友達", "食べ物", "お金", "趣味", "恋愛"]
  end

  def create  #選択されたテーマに沿ったジョークを生成する
    theme = params[:theme]  #フォームから送信されたテーマのパラメータを取得する
    joke_content = generate_joke(theme)  #OpenAI APIを使用してジョークを生成する
    #Rails.logger.info "Generated Joke: #{joke_content}" #デバッグ用
    @joke = Joke.new(content: joke_content, theme: theme)  #生成されたジョークをデータベースに保存する

    if @joke.save
      redirect_to edit_joke_path(@joke), notice: "小話を登録しました"  #ジョークが保存された場合、ジョーク詳細ページにリダイレクトする
    else
      #Rails.logger.error "Failed to save joke: #{@joke.errors.full_messages.join(', ')}" #デバッグ用
      flash[:alert] = "もう一回テーマを選んでください"
      render :new, status: :unprocessable_entity  #ジョークが保存されなかった場合、新規ジョーク作成ページを再表示する
    end
  end


  def update
    @joke = Joke.find(params[:id])  #選択されたジョークを取得する
    if @joke.update(joke_params)
      redirect_to jokes_path, notice: "タイトルを保存しました"  #ジョークが更新された場合、ジョーク一覧ページにリダイレクトする
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
    params.require(:joke).permit(:title)
  end

  def generate_joke(theme)#OpenAI APIに送信するプロンプトを作成する
    prompt =  <<-PROMPT
    あんたは大阪出身の60歳の愉快なおばちゃんやで。以下のテーマについて関西弁で笑える面白いジョークを話してな～。ネタは必ず100字以上200字以下でお願いな。最後に関西人がよく言う,
    ほんまかどうかは知らんという意味の、"知らんけど(笑)"を追記してくれると嬉しいで！:
    テーマ: #{theme}
    PROMPT

    # 環境変数が正しく読み込まれているか確認
  #Rails.logger.info "OpenAI API Key: #{ENV['OPENAI_API_KEY']}"デバッグ用

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
  #rescue Faraday::UnauthorizedError => e
    #Rails.logger.error "OpenAI API error: #{e.message}"
    #raise "APIキーが正しく設定されているか確認してください"
  end
end
