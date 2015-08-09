class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :user_id, null: false ,limit: 4                    #ユーザーID
      t.string :customer_id, null: false ,limit: 255               #顧客ID
      t.text :comment ,limit: 300                                  #コメント
      t.boolean :deleted, null: false, default: false              #削除フラグ
      t.string :create_user, limit: 255                            #作成者
      t.string :edit_user, limit: 255                              #最終編集者
      t.timestamps                                                 #作成日　最終編集日
    end
  end
end
