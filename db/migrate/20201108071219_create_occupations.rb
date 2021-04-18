class CreateOccupations < ActiveRecord::Migration[6.0]
  def change
    create_table :occupations, id: :uuid, comment: '職種「小項目」' do |t|
      t.string :name, null: false, comment: '職種「小項目」名'
      t.references :occupation_sub_category, foreign_key: true, type: :uuid

      t.timestamps
    end
    add_index :occupations, [:name], unique: true
  end
end
