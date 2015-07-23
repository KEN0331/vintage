class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.integer :item_id, null: false, limit: 4           #商品ID
      t.integer :related_item_id1, limit: 4               #関連商品１
      t.integer :related_item_id2, limit: 4               #関連商品２
      t.integer :related_item_id3, limit: 4               #関連商品３
      t.integer :related_item_id4, limit: 4               #関連商品４
      t.text :recommendation, limit: 300                  #おすすめコメント
      t.text :comment, limit: 300                         #コメント
      t.boolean :deleted, null: false, default: false     #削除フラグ
      t.string :create_user, limit: 255                   #作成者
      t.string :edit_user, limit: 255                     #最終編集者
      t.timestamps                                        #作成日　最終編集日
    end
  end
end
