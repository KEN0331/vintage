class CreateDenominations < ActiveRecord::Migration
  def change
    create_table :denominations do |t|
      t.string :name, null: false, limit: 255             #通貨名
      t.text :comment, limit: 300                         #コメント
      t.boolean :deleted, null: false, default: false     #削除フラグ
      t.string :create_user, limit: 255                   #作成者
      t.string :edit_user, limit: 255                     #最終編集者
      t.timestamps                                        #作成日　最終編集日
    end
  end
end
