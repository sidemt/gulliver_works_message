class CreateOccupationSubCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :occupation_sub_categories, id: :uuid, comment: '職種「中項目」' do |t|
      t.string :name, null: false, comment: '職種「中項目」名'
      t.references :occupation_main_category, foreign_key: true, type: :uuid

      t.timestamps
    end
    add_index :occupation_sub_categories, [:name], unique: true
  end
end
