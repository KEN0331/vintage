class CreateMainImages < ActiveRecord::Migration
  def change
    create_table :main_images do |t|
      t.binary :image, null: false ,limit: 1.5.megabyte   #メイン写真
      t.integer :item_id, null: false ,limit: 4           #商品ID
      t.text :comment, limit: 300                         #コメント
      t.boolean :deleted, null: false, default: false     #削除フラグ
      t.string :create_user, limit: 255                   #作成者
      t.string :edit_user, limit: 255                     #最終編集者
      t.timestamps                                        #作成日　最終編集日
    end
  end
end
