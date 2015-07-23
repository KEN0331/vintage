class CreateAuthorities < ActiveRecord::Migration
  def change
    create_table :authorities do |t|
      t.string :name, null: false, limit: 255             #権限名
      t.text :authority, null: false, limit: 300          #新着コメント
      t.text :comment, limit: 300                         #コメント
      t.boolean :deleted, null: false, default: false     #削除フラグ
      t.timestamps                                        #作成日　最終編集日
    end
  end
end
