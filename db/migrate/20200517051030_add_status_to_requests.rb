class AddStatusToRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :file_no, :string
    add_column :requests, :file_name, :string
    add_column :requests, :expired_at, :date
    add_column :requests, :placed_at, :string
    add_column :requests, :status, :integer
  end
end
