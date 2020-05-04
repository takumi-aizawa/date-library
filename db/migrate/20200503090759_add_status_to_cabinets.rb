class AddStatusToCabinets < ActiveRecord::Migration[5.2]
  def change
    add_column :cabinets, :status, :integer, null: false #カラ保存をさせない
    add_column :cabinets, :user_id, :bigint, null: false #カラ保存をさせない
    add_column :cabinets, :manager_id, :bigint, null: false #カラ保存をさせない
  end
end
