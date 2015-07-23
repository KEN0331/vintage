class CreateItemTypes < ActiveRecord::Migration
  def change
    create_table :item_types do |t|
      t.string :name, null: false, limit: 255             #商品タイプ名
      t.text :unit_id_list, null: false, limit: 300       #単位ID(配列)
      t.text :comment, limit: 300                         #コメント
      t.boolean :deleted, null: false, default: false     #削除フラグ
      t.string :create_user, limit: 255                   #作成者
      t.string :edit_user, limit: 255                     #最終編集者
      t.timestamps                                        #作成日　最終編集日
    end
  end
end
