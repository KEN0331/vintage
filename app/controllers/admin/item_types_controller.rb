# coding: utf-8

class Admin::ItemTypesController < ApplicationController
  def index
    @item_types=ItemType.active.all.paginate(:page => params[:page], :per_page => 10)
  end
  
  
  def show
    @item_type=ItemType.active.find(params[:id])
  end
  
  def new
    @item_type=ItemType.new
  end
  
  def edit
    @item_type=ItemType.active.find(params[:id])
  end
  
  def create
    @item_type=ItemType.new(item_type_params)
    unit_id_list=params[:item_type][:unit_id_list]
    unit_id_list.delete("")
    @item_type.unit_id_list=unit_id_list
    if @item_type.save
      redirect_to admin_item_type_path(@item_type), notice: "「"+@item_type.name+"」Registered !"
    else
    render "new"
    end
  end
  
  def update
    @item_type=ItemType.active.find(params[:id])
    @item_type.assign_attributes(item_type_params)
    unit_id_list=params[:item_type][:unit_id_list]
    unit_id_list.delete("")
    @item_type.unit_id_list=unit_id_list
    if @item_type.save
      redirect_to admin_item_type_path(@item_type), notice: "「"+@item_type.name+"」Uploaded !"
    else
    render "edit"
    end
  end
  
  def destroy
    @item_type=ItemType.active.find(params[:id])
    @item_type.deleted = true
    if @item_type.save
      redirect_to admin_item_types_path, notice: "「"+@item_type.name+"」Deleted !"
    end
  end
  
  def plural_destroy
    if params[:checked_item_types]
      item_types = params[:checked_item_types].keys
      @item_types=ItemType.active.find(item_types)
      item_type_count=@item_types.size
      @i=0
      @item_types.each do |item_type|
        item_type.deleted = true
        if item_type.save
          @i=@i+1
        end
      end
      if @i=item_type_count
        redirect_to admin_item_types_path, notice: item_type_count.to_s+"件のITEM TYPEを削除しました"
      end
    else
      redirect_to admin_item_types_path, notice: "削除するITEM TYPEを選択してください"
    end
  end
  
  def search
    @item_types=ItemType.active.search(params[:q])
    render "index"
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def item_type_params 
    params.require(:item_type).permit(:name, :unit_id_list, :create_user, :edit_user, :comment)
   end

end
