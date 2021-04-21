class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms, id: :uuid, comment: 'トークルーム' do |t|
      t.references :account, foreign_key: true, type: :uuid
      t.references :company, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
