class CreateEmploymentStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :employment_statuses, id: :uuid, comment: '雇用形態' do |t|
      t.string :name, null: false, comment: '雇用形態名'

      t.timestamps
    end
    add_index :employment_statuses, [:name], unique: true
  end
end
