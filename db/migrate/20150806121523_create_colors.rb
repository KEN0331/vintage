class CreateColors < ActiveRecord::Migration
  def change
    create_table :colors do |t|
      t.string :name, null: false ,limit: 255                      #色名
      t.integer :code, null: false ,limit: 4                       #カラーコード
      t.text :comment ,limit: 300                                  #コメント
      t.boolean :deleted, null: false, default: false              #削除フラグ
      t.string :create_user, limit: 255                            #作成者
      t.string :edit_user, limit: 255                              #最終編集者
      t.timestamps            
    end
  end
end
