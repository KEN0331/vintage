class ModifyUsers < ActiveRecord::Migration
  def change
    remove_column :users, :postal_code_3
    remove_column :users, :postal_code_4
    remove_column :users, :todohuken
    remove_column :users, :shikutyouson
    remove_column :users, :adress_detail
    remove_column :users, :customer_id
  end
end
