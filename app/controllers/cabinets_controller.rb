class CabinetsController < ApplicationController #cabinetへの登録申請、承認等
  before_action :require_user_logged_in, only: [:index] #ApplicationControllerで定義したメソッド
  #before_action :correct_user, only: [:destroy]

  
  def index
    @msg = 'Cabinet data.'
    @cabinets = Cabinet.order(id: :asc).page(params[:page]).per(10)
  end

  def show
    @cabinet = Cabinet.find(params[:id])
  end

  def new #request仕掛画面で承認ボタン押下後、実行するメソッドでなきゃいけない。5.22
    @cabinet = Cabinet.new #cabinet登録への登録用5.24　パラメータを渡したいができない。。。
    @request = Request.new #requestへの登録画面を表示 cabinet new画面表示用5.24
  end

  def create
    @cabinet = Cabinet.new(cabinet_params) #cabinet_paramsを登録するため
    
    if @cabinet.save
      flash[:success] = '書庫への登録申請を受付けました。'
      redirect_to cabinets_url #redirect_toアクションはデータ保存後画面遷移
    else
      flash.now[:danger] = '書庫への登録申請に失敗しました。再度やり直してください。'
      render :new
    end
    
    @request = Request.new(cabinet_params) #request_paramsを登録するため
    @request.cabinet_id = @cabinet.id #request_id = cabinet_idと定義
    @request.user_id = current_user.id #requestのuser_id = 現在のidと定義
    @request.save
    
  end


  def edit
    @cabinet = Cabinet.find(params[:id])
  end

  def update #編集申請
    @cabinet = Cabinet.find(params[:id])
    if @cabinet.update_attributes(status: "編集申請中", manager_id:"NULL")
      flash[:success] = '編集申請を受け付けました'
      redirect_to cabinets_url
    else
      flash.now[:danger] = '編集申請に失敗しました'
      render :edit
    end
  end
  
  def update_delete #削除申請ボタン
    @cabinet = Cabinet.find(params[:id])
    if @cabinet.update_attributes(status: "削除申請中", manager_id:"NULL")
      flash[:success] = '削除申請を受付けました'
      redirect_to cabinets_url
    else
      flash.now[:danger] = '削除申請に失敗しました'
      render :edit
    end
  end
  
  def update_cancel #申請取り消しボタン
    @cabinet = Cabinet.find(params[:id])
    if @cabinet.update_attributes(status: "登録済" )
      flash[:success] = '申請を取り消しました'
      redirect_to cabinets_url
    else
      flash.now[:danger] = '申請取り消しに失敗しました'
      render :edit
    end
  end

  def update_accept #承認ボタン
    @cabinet = Cabinet.find(params[:id])
    if @cabinet.update_attributes(status: "登録済", manager_id:current_user.id) #statusを登録済に変更
      #@cabinet.request.update(status: "登録済") #request statusの更新は不要なので一旦コメントアウト
      flash[:success] = 'requestは承認されました'
      redirect_to cabinets_url
    else
      flash.now[:danger] = 'requestの承認に失敗しました'
      render action: :edit
    end
    #binding.pry #ブレイクポイント
  end



    
  def destroy #一つのデータを削除
    @cabinet = Cabinet.find(params[:id])
    @cabinet.destroy

    flash[:success] = '申請を取り消しました'
    redirect_to cabinets_url
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
    params.require(:cabinet).permit(:file_no, :file_name, :expired_at, :placed_at, :user_id, :status, :manager_id)
    #Cabinetモデルを収集先に宣言。permit→その中で取得を許可する値。ユーザと管理者の取得情報の区別も可
  end
  
  def request_params #createに記載。使うために必要
    params.require(:request).permit(:file_no, :file_name, :expired_at, :placed_at, :user_id)
    #Requestモデルを収集先に宣言。permit→その中で取得を許可する値。ユーザと管理者の取得情報の区別も可
  end
