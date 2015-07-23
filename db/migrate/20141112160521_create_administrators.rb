class CreateAdministrators < ActiveRecord::Migration
  def change
    create_table :administrators do |t|
      t.string :name, null: false, limit: 255                    #ユーザー名
      t.string :userid, null: false, limit: 255                  #ユーザーID
      t.string :password_digest, null: false, limit: 255         #パスワード
      t.integer :authority_id, null: false, limit: 4             #権限ID
      t.string :tel, limit: 255                                  #電話番号
      t.text :email, limit: 300                                  #E-mail
      t.text :comment, limit: 300                                #コメント
      t.boolean :deleted, null: false, default: false            #削除フラグ
      t.string :create_user, limit: 255                          #作成者
      t.string :edit_user, limit: 255                            #最終編集者
      t.timestamps                                               #作成日　最終編集日
    end
  end
end
