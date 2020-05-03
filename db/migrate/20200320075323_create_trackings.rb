class CreateTrackings < ActiveRecord::Migration[5.2]
  def change
    create_table :trackings do |t|
      t.string :file_no
      t.string :file_name
      t.integer :staus
      t.datetime :expired_at
      t.string :placed_at
      
      t.references :user, foreign_key: true
      t.references :manager, foreign_key: true

      t.timestamps
    end
  end
end
