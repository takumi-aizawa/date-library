class CreateCabinets < ActiveRecord::Migration[5.2]
  def change
    create_table :cabinets do |t|
      t.string :file_no
      t.string :file_name
      t.date :expired_at
      t.string :placed_at
      
      
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
