class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name, null: false ,limit: 255                      #商品名
      t.integer :subcategory_id, null: false ,limit: 4             #サブカテゴリID
      t.integer :price, null: false ,limit: 4                      #価格
      t.integer :denomination_id, null: false ,limit: 4            #通貨単位ID
      t.integer :condition_id, null: false ,limit: 4               #品質状態
      t.string :size, null: false ,limit: 255                      #サイズ
      t.integer :fabric_id, null: false ,limit: 4                  #素材ID
      t.text :description, null: false ,limit: 300                 #詳細説明
      t.text :spike_url, null: false ,limit: 300                   #SPIKE_URL
      t.text :comment ,limit: 300                                  #コメント
      t.boolean :sold_flag, null: false, default: false            #売り切れフラグ
      t.boolean :deleted, null: false, default: false              #削除フラグ
      t.string :create_user, limit: 255                            #作成者
      t.string :edit_user, limit: 255                              #最終編集者
      t.timestamps                                                 #作成日　最終編集日
    end
  end
end
