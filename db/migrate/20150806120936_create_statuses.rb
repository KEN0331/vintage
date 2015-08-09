class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :name, null: false ,limit: 255                      #ステータス名
      t.integer :ratio, null: false ,limit: 4                      #進捗度
      t.integer :color_id, null: false ,limit: 4                   #タグ色
      t.text :comment ,limit: 300                                  #コメント
      t.boolean :deleted, null: false, default: false              #削除フラグ
      t.string :create_user, limit: 255                            #作成者
      t.string :edit_user, limit: 255                              #最終編集者
      t.timestamps            
    end
  end
end
