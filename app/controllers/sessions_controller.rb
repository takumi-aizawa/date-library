class SessionsController < ApplicationController
  #before_action :require_user_logged_in, only: [:index, :show]
  #before_action :correct_user, only: [:destroy]
  
  #before_action user_admin, only: [:index]
  
  def new
  end


  def create
    email = params[:session][:email].downcase # paramsは配列に名前を入力すれば値を取り出せる。ユーザの送信値emailを小文字で取り出す。
    password = params[:session][:password] # ユーザ入力パスワードをparamsで取り出し、代入
    if login(email, password) #mail,pwが合致すれば、の意味？
      flash[:success] = 'ログインに成功しました。' #画面遷移後に表示する
      redirect_to cabinets_url #redirect_to アドレス　が一般的。cabinets/indexに飛ぶ
    else
      flash.now[:danger] = 'ログインに失敗しました。' #flash.now⇒現在のページでメッセを表示したい場合
      render :new #sessions/new.html.erbを表示するのみ（newアクションは実行しない）
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to login_url #redirect_to root_urlはtoppageに飛ぶ
  end

  private

  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      # ログイン成功
      session[:user_id] = @user.id
      return true
    else
      # ログイン失敗
      return false
    end
  end
end