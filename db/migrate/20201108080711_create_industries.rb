class CreateIndustries < ActiveRecord::Migration[6.0]
  def change
    create_table :industries, id: :uuid, comment: '業種' do |t|
      t.string :name, null: false, comment: '業種名'
      t.references :industry_category, foreign_key: true, type: :uuid

      t.timestamps
    end
    add_index :industries, [:name, :industry_category_id], unique: true
  end
end
