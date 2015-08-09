class CreateAdresses < ActiveRecord::Migration
  def change
    create_table :adresses do |t|
      t.integer :user_id, null: false ,limit: 4                    #ユーザーID
      t.string :postal_code_3, null: false ,limit: 255             #郵便番号(3桁)
      t.string :postal_code_4, null: false ,limit: 255             #郵便番号(4桁)
      t.string :todohuken, null: false ,limit: 255                 #都道府県
      t.string :shikutyouson, null: false ,limit: 255              #市区町村
      t.string :adress_detail, null: false ,limit: 255             #住所詳細
      t.text :comment ,limit: 300                                  #コメント
      t.boolean :deleted, null: false, default: false              #削除フラグ
      t.string :create_user, limit: 255                            #作成者
      t.string :edit_user, limit: 255                              #最終編集者
      t.timestamps                                                 #作成日　最終編集日
    end
  end
end
