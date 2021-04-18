class CreatePrefectures < ActiveRecord::Migration[6.0]
  def change
    create_table :prefectures, id: :uuid, comment: '都道府県' do |t|
      t.string :name, null: false, comment: ' 都道府県名'

      t.timestamps
    end
    add_index :prefectures, [:name], unique: true
  end
end
