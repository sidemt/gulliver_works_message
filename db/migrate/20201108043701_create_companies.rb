class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies, id: :uuid, comment: '企業' do |t|
      t.string :name, null: false, comment: '法人名'
      t.string :name_kana, null:false, comment: '法人名(ふりがな)'
      t.string :head_office_location, null:false, comment: '本店所在地'
      t.string :year_of_establishment, null:false, comment: '設立年'
      t.string :hp_url, comment: 'HPのURL'
      t.string :phone, comment: '電話番号'
      t.integer :capital, null:false, comment: '資本金'
      t.boolean :is_listed, null:false, default: false, comment: '上場 / 非上場'
      t.string :representative, null:false, comment: '代表指名'
      t.string :representative_kana, null:false, comment: '代表氏名(ふりがな)'
      t.string :net_sales, comment: '前年度の売上高'
      t.string :numbers_of_employees, null:false, comment: '従業員数'
      t.integer :average_age, comment: '平均年齢'
      t.text :business_summary, null: false, comment: '事業概要'
      t.string :corporate_pr, comment: '企業PR'

      t.timestamps
    end
  end
end
