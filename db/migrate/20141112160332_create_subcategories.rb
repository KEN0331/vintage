class CreateSubcategories < ActiveRecord::Migration
  def change
    create_table :subcategories do |t|
      t.string :name, null: false, limit: 255             #サブカテゴリ名
      t.integer :category_id, null: false, limit: 4       #カテゴリID
      t.text :comment, limit: 300                         #コメント
      t.boolean :deleted, null: false, default: false     #削除フラグ
      t.string :create_user, limit: 255                   #作成者
      t.string :edit_user, limit: 255                     #最終編集者
      t.timestamps                                        #作成日　最終編集日
      t.timestamps
    end
  end
end
