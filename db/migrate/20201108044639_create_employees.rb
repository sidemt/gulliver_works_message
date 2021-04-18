class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees, id: :uuid, comment: '従業員' do |t|
      t.string :email, null: false, comment: 'メールアドレス'
      t.string :password_digest, null: false, comment: 'パスワードのハッシュ値'
      t.integer :email_verification_status, null: false, default: 0, comment: 'メールアドレスの確認状態'
      t.uuid :email_verification_token, comment: 'メール確認用のトークン'
      t.references :company, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
