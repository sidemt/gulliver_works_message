class CreateOccupationMainCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :occupation_main_categories, id: :uuid, comment: '職種「大項目」' do |t|
      t.string :name, null: false, comment: '職種「大項目」名'

      t.timestamps
    end
    add_index :occupation_main_categories, [:name], unique: true
  end
end
