class ManagersController < ApplicationController #cabinetへの登録申請、承認等
  before_action :require_user_logged_in, only: [:index] #ApplicationControllerで定義したメソッド
  #before_action :correct_user, only: [:destroy]
  
  #before_action user_admin, only: [:index]
  
  def index
    @msg = 'Cabinet data.'
    @cabinets = Cabinet.order(id: :asc).page(params[:page]).per(25)
  end

  def show
  end

  def new
    @cabinet = Cabinet.new
  end

  def create
    @cabinet = Cabinet.new(cabinet_params)

    if @cabinet.save
      flash[:success] = '申請を受け付けました。'
      redirect_to cabinets_url #redirect_toアクションはデータ保存後画面遷移
    else
      flash.now[:danger] = '申請受付に失敗しました。再度やり直してください。'
      render :new #cabinets/new.html.erbを表示するのみ（newアクションは実行しない）
    end
  end


  def edit
  end

  def update
    if @message.update(message_params)
      flash[:success] = 'Message は正常に更新されました'
      redirect_to @message
    else
      flash.now[:danger] = 'Message は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @message.destroy

    flash[:success] = 'Message は正常に削除されました'
    redirect_to messages_url
  end
  
end  



  private

  def cabinet_params #セキュリティ対策。newメソッドのフォーム入力データをフィルタリングする。HTTPリク攻撃防止
    params.require(:cabinet).permit(:file_no, :file_name, :expired_at, :placed_at) 
    #Cabinetモデルを収集先に宣言。permit→その中で取得を許可する値。ユーザと管理者の取得情報の区別も可
  end
  
  #def user_admin
  #   @users = User.all
  #   if  current_user.admin == false
  #       redirect_to root_path
  #   else
  #       render action: "index"
  #   end
  #end