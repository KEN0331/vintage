class AddUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_name, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name_kana, :string
    add_column :users, :first_name_kana, :string
    add_column :users, :postal_code_4, :string
    add_column :users, :postal_code_3, :string
    add_column :users, :todohuken, :string
    add_column :users, :shikutyouson, :string
    add_column :users, :adress_detail, :string
    add_column :users, :customer_id, :string
    
    add_index :users, :customer_id,          unique: true
  end
end
