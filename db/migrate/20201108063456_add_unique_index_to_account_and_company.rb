class AddUniqueIndexToAccountAndCompany < ActiveRecord::Migration[6.0]
  def change
    add_index :accounts, :email, unique: true
    add_index :employees, :email, unique: true
    add_index :companies, :name, unique: true
  end
end
