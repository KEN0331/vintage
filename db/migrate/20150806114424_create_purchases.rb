class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.text :item_id_list, null: false, limit: 300       #商品ID(配列)
      t.integer :user_id, null: false, limit: 4           #ユーザーID
      t.string :amount, null: false, limit: 255           #合計額
      t.integer :tax, null: false, limit: 4               #消費税
      t.string :shipping, limit: 255                      #送料
      t.integer :status, null: false, default: 0          #ステータス
      t.boolean :read_flg, null: false, default: false    #既読フラグ
      t.boolean :returne_flg, null: false, default: false #返品フラグ
      t.text :comment, limit: 300                         #コメント
      t.boolean :deleted, null: false, default: false     #削除フラグ
      t.string :edit_user, limit: 255                     #最終編集者
      t.timestamps                                        #作成日　最終編集日
    end
  end
end
