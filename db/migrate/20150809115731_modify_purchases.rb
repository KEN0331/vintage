class ModifyPurchases < ActiveRecord::Migration
  def change
    rename_column :purchases, :user_id, :card_id           #ユーザーID => カードID
  end
end
