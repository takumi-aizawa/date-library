module SessionsHelper #ヘルパーでメソッドを定義する。ログインやサインインの条件分岐を助ける
  def current_user #ログインユーザの確認メソッドを定義
    @current_user ||= User.find_by(id: session[:user_id]) #ログインユーザなら何もしない、違うならログインユーザを取得する
  end

  def logged_in? #ログイン有無の確認メソッドを定義
    !!current_user #!でnot演算子よりfalse、!!でtrue。ログインユーザならtrue、違うならfalseを出す
  end
  

end
