class CreateIndustryCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :industry_categories, id: :uuid, comment: '業種カテゴリー' do |t|
      t.string :name, null: false, comment: '業種カテゴリー名'

      t.timestamps
    end
    add_index :industry_categories, [:name], unique: true
  end
end
