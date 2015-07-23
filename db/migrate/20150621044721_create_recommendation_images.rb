class CreateRecommendationImages < ActiveRecord::Migration
  def change
    create_table :recommendation_images do |t|
      t.integer :recommendation_id, null: false ,limit: 4      #おすすめ商品ID
      t.binary :image, limit: 1.5.megabyte                     #おすすめ写真
      t.text :comment, limit: 300                              #コメント
      t.boolean :deleted, null: false, default: false          #削除フラグ
      t.string :create_user, limit: 255                        #作成者
      t.string :edit_user, limit: 255                          #最終編集者
      t.timestamps
    end
  end
end
