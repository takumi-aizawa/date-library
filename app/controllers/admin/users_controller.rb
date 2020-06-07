class Admin::UsersController < ApplicationController #Admin・・・管理機能専用のコントローラ。将来管理系の機能を追加することを想定して新たに作成
  def index
    #@users = User.all
  end
  
  def show
   @user = User.find(user_params)
  end
  
  def new
    @user = User.new
  end

  def edit
    @user = User.find(user_params)
  end
  
  def create
    @user = User.new(user_params) #下部のprivateで定義しないと使えない！
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to admin_signup_url
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new #users/new.html.erbを表示するのみ（newアクションは実行しない）
    end
  end

  def update
    @user = User.find(params[:id])
  
    if @user.update(user_params)
      redirect_to admin_users_url(@user), notice: "ユーザー「#{@user.name}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_url, notice: "ユーザー「#{@user.name}」を削除しました。"
  end

  private

  def user_params #ユーザIDメソッド
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation) #adminを追記
    #Userモデルを収集先に宣言。permit→その中で取得を許可する値。ユーザと管理者の取得情報の区別も可
  end
  
  def require_admin #管理者以外禁止メソッド
    redirect_to root_url unless current_user.admin #管理者以外がURL直入力でtryしたときはログイン画面へ飛ばす
  end
end