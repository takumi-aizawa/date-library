class CreateUsers < ActiveRecord::Migration[5.2]
  def change #usersテーブルを作成する命令　def change~end
    create_table :users do |t| #Model名の小文字複数形がテーブル名(users)になる規則
      t.string :name #カラム
      t.string :email #ログイン時必須なので追加3/21  ※ここで編集してもデータベースmysqlは変更されない
      t.string :password_digest

      t.timestamps
    end
  end
end
