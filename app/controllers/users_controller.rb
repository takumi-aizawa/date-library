class UsersController < ApplicationController #admin専用を作ったので不要　あとで削除

  def index
    #@users = User.order(id: :desc).page(params[:page]).per(25) #Userはモデル。order(id)でid情報取得
  end     #id降順にユーザ一覧取得  ページネーション(分割)適用 1pにつき25件まで取得

  def show #そのユーザid専用のページへ飛ばす。
  end

  def new
    @user = User.new #signupクリック時に実行するアクション。rails標準装備。Userモデルに.newアクションで情報生成。保存(.save)は別途必要。コンソールではUser.new（name:"tanaka" , email: "tech@gmail.com"）と入力
  end

  def create 
    @user = User.new(user_params) #@がつけばインスタンス変数、クラスを元にしたオブジェクトの中で常に値を保持している変数のこと

    if @user.save #user新規登録後保存。@をつけないとuserがviewに反映されない
      flash[:success] = 'ユーザを登録しました。'
      redirect_to cabinets_index_url #redirect_toは転送メソッド、action: :アクション名で実行。ちなみにredirect_to @user・・・get "/users/:id" => "users#show"の事。users showアクションへ強制移動、show.html.erbを呼ぶ。
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new #users/new.html.erbを表示するのみ（newアクションは実行しない）
    end
    
  end

  def edit
  end

  def update
  end

  def destroy
  end
end

  private

  def user_params #new.html.erbでform_for or withを利用する際は、二重ハッシュ（モデル名とバリュー）で情報が飛ばされます。そのため、コントローラー上、requireでモデル指定・permitでバリュー指定が必要になります。
    params.require(:user).permit(:name, :email, :password, :password_confirmation) 
    #Userモデルを収集先に宣言。permit→その中で取得を許可する値。ユーザと管理者の取得情報の区別も可
  end