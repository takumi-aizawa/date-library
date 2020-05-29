class RequestsController < ApplicationController #cabinetへの登録申請、承認等
  before_action :require_user_logged_in, only: [:index] #ApplicationControllerで定義したメソッド。ログインしていないユーザをログイン画面に強制的にとばす
  before_action :set_request, only: [:show, :edit, :update, :destroy] #特定のパラメータを取り出す。つまりアクションに選択するメソッドを追加・共通化する
  #before_action :correct_user, only: [:destroy] #before_action では only: で指定されたアクションに対して、事前処理を設定できます

  
  def index
    @msg = 'Request data.'
    @requests = Request.order(id: :asc).page(params[:page]).per(10)
  end

  def show
  end

  def new
    @request = Request.new #Cabinetの登録申請ボタン押下で実行するアクション
  end

  def create
    @request = Request.new(request_params)

    if @request.save
      flash[:success] = '登録申請を受け付けました。'
      redirect_to cabinets_url #redirect_toアクションはデータ保存後画面遷移
    else
      flash.now[:danger] = '登録申請に失敗しました。再度やり直してください。'
      render 'cabinets/new' #render :newだとrequests/new.html.erbを自動表示するので、別フォルダを指定したい場合に左記のように書く。
      #renderはsave実行後にViewを表示。一方redirectはsave実行後に別のコントローラのアクション(cabinet/index)を実行。アクションが１つか２つかの違い
    end
  end


  def edit
  end

  def update
    if @request.update(message_params)
      flash[:success] = 'Message は正常に更新されました'
      redirect_to @message
    else
      flash.now[:danger] = 'Message は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @request.destroy #destroy前にfindしている

    flash[:success] = 'Request は正常に削除されました'
    redirect_to new_cabinet_url
    
  end
  
  def destroy_all
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

  def request_params #セキュリティ対策。newメソッドのフォーム入力データをフィルタリングする。HTTPリク攻撃防止
    params.require(:request).permit(:file_no, :file_name, :expired_at, :placed_at)  #Cabinet登録申請ボタンが機能する
    #Requestモデルを収集先に宣言。permit→その中で取得を許可する値。ユーザと管理者の取得情報の区別も可
  end
  
  def set_request
    @request = Request.find(params[:id])
  end
  
  
  
  
  #def user_admin
  #   @users = User.all
  #   if  current_user.admin == false
  #       redirect_to root_path
  #   else
  #       render action: "index"
  #   end
  #end