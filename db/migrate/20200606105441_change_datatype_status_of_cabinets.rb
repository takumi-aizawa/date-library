class ChangeDatatypeStatusOfCabinets < ActiveRecord::Migration[5.2]
  def change
   change_column :cabinets, :status, :string
  end
end
