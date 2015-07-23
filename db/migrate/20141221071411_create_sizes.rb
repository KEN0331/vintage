class CreateSizes < ActiveRecord::Migration
  def change
    create_table :sizes do |t|
      t.integer :unit_id, null: false, limit: 4             #単位ID
      t.integer :item_type_id, null: false, limit: 4        #商品タイプID
      t.boolean :deleted, null: false, default: false       #削除フラグ
      t.string :create_user, limit: 255                     #作成者
      t.string :edit_user, limit: 255                       #最終編集者
      t.timestamps                                          #作成日　最終編集日
    end
  end
end
