class AddAdressIdToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :adress_id, :integer, null: false, limit: 4           #住所ID
  end
end
