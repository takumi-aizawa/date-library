class CabinetsController < ApplicationController #cabinetへの登録申請、承認等
  before_action :require_user_logged_in, only: [:index] #ApplicationControllerで定義したメソッド
  #before_action :correct_user, only: [:destroy]

  
  def index
    @msg = 'Cabinet data.'
    @cabinets = Cabinet.order(id: :asc).page(params[:page]).per(10)
  end

  def show
  end

  def new #request仕掛画面で承認ボタン押下後、実行するメソッドでなきゃいけない。5.22
    #@cabinet = Cabinet.find(params[:id]) #cabinet登録への登録用5.24　パラメータを渡したいができない。。。
    @request = Request.new #requestへの登録画面を表示 cabinet new画面表示用5.24
  end

  def create
    @cabinet = Cabinet.new(cabinet_params) #cabinet_paramsを登録するため
    
    if @cabinet.save
      flash[:success] = '書庫への登録が完了しました。'
      redirect_to cabinets_url #redirect_toアクションはデータ保存後画面遷移
    else
      flash.now[:danger] = '書庫への登録に失敗しました。再度やり直してください。'
      render 'requests/index' #※要確認！5.19
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

  def destroy #一つのデータを削除
    @message.destroy

    flash[:success] = 'Message は正常に削除されました'
    redirect_to messages_url
  end
  
  def destroy_all #複数のデータを削除
    checked_data = params[:deletes].keys # ここでcheckされたデータを受け取っています。
    if @cabinets.destroy(checked_data)
      flash[:success] = '削除申請を受け付けました。'
      redirect_to cabinets_url
    else
      flash.now[:danger] = '削除申請に失敗しました。再度やり直してください。'
      render :new #cabinets/new.html.erbを表示するのみ（newアクションは実行しない）
    end
  end
end  



  private

  def cabinet_params #セキュリティ対策。newメソッドのフォーム入力データをフィルタリングする。HTTPリク攻撃防止
    params.require(:cabinet).permit(:file_no, :file_name, :expired_at, :placed_at) 
    #Cabinetモデルを収集先に宣言。permit→その中で取得を許可する値。ユーザと管理者の取得情報の区別も可
  end
  
  def request_params #createに記載。使うために必要
    #params.require(:request).permit(:file_no, :file_name, :expired_at, :placed_at)  
    #Requestモデルを収集先に宣言。permit→その中で取得を許可する値。ユーザと管理者の取得情報の区別も可
  end
  
  #def user_admin
  #   @users = User.all
  #   if  current_user.admin == false
  #       redirect_to root_path
  #   else
  #       render action: "index"
  #   end
  #end