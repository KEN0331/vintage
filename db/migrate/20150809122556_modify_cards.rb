class ModifyCards < ActiveRecord::Migration
  def change
    change_column :cards, :customer_id, :string, :unique => true               #顧客ID (UNIQUEに変更)
  end
end
