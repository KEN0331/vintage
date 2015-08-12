class ModifyColors < ActiveRecord::Migration
  def change
    change_column :colors, :code, :string, null: false ,limit: 255                       #カラーコード
  end
end
