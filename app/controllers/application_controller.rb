class ApplicationController < ActionController::Base #すべてのコントローラに適用できる

  include SessionsHelper #includeを使う事でsessionshelperが使用可能になる

  private #メソッドのアクセスを制約するキー。private以下のメソッドは、クラスの中からしか呼び出せない。セキュリティ対策

  def require_user_logged_in #"require_user_logged_in"メソッド定義。userモデルのデータ収集を収集、ログインについて確認するメソッドを定義
    unless logged_in? # sessionshelperで定義したメソッド。ユーザがログインしていなければ？true
      redirect_to login_url #ログイン画面へいってね。redirect_to名前_url アクションはデータ保存後画面遷移。session/new実行
    end
  end
  

end
