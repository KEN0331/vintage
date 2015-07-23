class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :name, null: false, limit: 255             #寸法名
      t.string :unit, null: false, limit: 255             #単位
      t.text :comment, limit: 300                         #コメント
      t.boolean :deleted, null: false, default: false     #削除フラグ
      t.string :create_user, limit: 255                   #作成者
      t.string :edit_user, limit: 255                     #最終編集者
      t.timestamps                                        #作成日　最終編集日
    end
  end
end
