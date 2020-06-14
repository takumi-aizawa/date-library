class RequestsController < ApplicationController #cabinetへの登録申請、承認等
  before_action :require_user_logged_in, only: [:index] #ApplicationControllerで定義したメソッド。ログインしていないユーザをログイン画面に強制的にとばす
  before_action :set_request, only: [:show, :edit, :update, :destroy] #特定のパラメータを取り出す。つまりアクションに選択するメソッドを追加・共通化する
  #before_action :correct_user, only: [:destroy] #before_action では only: で指定されたアクションに対して、事前処理を設定できます
  #before_action :set_current_user, only: [:create]
  
  def index
    @msg = 'Cabinet data.'
   #@cabinets = Cabinet.order(id: :asc).page(params[:page]).per(10)
    @requests = Cabinet.order(id: :asc).page(params[:page]).per(10).where.not(status: '登録済') #status=登録済以外を表示
  end

  def show
    @request = Cabinet.find(params[:id])
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
    if @request.update(request_params)
      flash[:success] = 'Request は正常に更新されました'
      redirect_to @request
    else
      flash.now[:danger] = 'Request は更新されませんでした'
      render :edit
    end
  end

  def update_accept #承認ボタン
    @cabinet = Cabinet.find(params[:id])
    if @cabinet.update_attributes(status: "登録済")
      @cabinet.request.update(status: "登録済")
      flash[:success] = '書庫に正常に登録されました'
      redirect_to cabinets_url
    else
      flash.now[:danger] = '書庫の登録に失敗しました'
      render :edit
    end
  end


  def destroy
    @request.destroy #destroy前にfindしている

    flash[:success] = '申請を差し戻しました'
    redirect_to requests_path
    
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
    @request = Cabinet.find(params[:id])
  end
