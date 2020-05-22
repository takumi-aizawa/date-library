class RenameStausColumnToTrackings < ActiveRecord::Migration[5.2]
  def change
    rename_column :trackings, :staus, :status
  end
end
