class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages, id: :uuid, comment: 'メッセージ' do |t|
      t.string :content, comment: '内容'
      t.references :room, foreign_key: true, type: :uuid
      t.references :account, foreign_key: true, type: :uuid
      t.references :employee, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
