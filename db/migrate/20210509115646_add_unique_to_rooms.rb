class AddUniqueToRooms < ActiveRecord::Migration[6.0]
  def change
    add_index :rooms, [:account_id, :company_id], unique: true
  end
end
