# coding: utf-8

class Admin::ItemsController < ApplicationController
  def index
    @items=Item.active.all.paginate(:page => params[:page], :per_page => 10)
  end
  
  def show
    @item=Item.active.find(params[:id])
  end
  
  def new
    @item=Item.new
    
    new_arrival=NewArrival.new
    @item.new_arrival=new_arrival
    
    recommendation=Recommendation.new
    @item.recommendation=recommendation
    
    main_image=MainImage.new
    @item.main_image=main_image
    
    3.times do ||
      subimage=Subimage.new
      @item.subimages << subimage
    end
  end
  
  def edit
    @item=Item.active.find(params[:id])
    @subcategory=Subcategory.active.find(@item.subcategory_id)
    @category=Category.active.find(@subcategory.category_id)

    if new_arrival=NewArrival.active.where(:item_id => params[:id]).first
      @new_arrival_param=new_arrival
      @new_arrival_flg="1"
    elsif new_arrival=NewArrival.where(:item_id => params[:id]).first
      @new_arrival_param=new_arrival
      @new_arrival_flg="2"
    else
      @new_arrival_param=NewArrival.new
      @new_arrival_flg="3"
    end
    
    if recommendation=Recommendation.active.where(:item_id => params[:id]).first
      @recommendation_param=recommendation
      @recommendation_flg="1"
    elsif recommendation=Recommendation.where(:item_id => params[:id]).first
      @recommendation_param=recommendation
      @recommendation_flg="2"
    else
      @recommendation_param=Recommendation.new
      @recommendation_flg="3"
    end
    
    if !@item.main_image
      @main_image=MainImage.new
    end

    @subimages=Array.new
    i=@item.subimages.length
    i=3-i
    i.times do ||
      subimage=Subimage.new
      @subimages << subimage
    end
    
    category_def=Category.active.first
    @subcategories=Subcategory.active.where(:category_id => params[:category_id] ).all
      if !@subcategories.present?
        @subcategories=Subcategory.active.where(:category_id => category_def ).all
      end
  end
  
  def create
    @item=Item.new(item_params)

    if @item.main_image
      @item.main_image.image=@item.main_image.image.read
    end

    if @item.subimages
      @item.subimages.each do |subimage|
        subimage.image=subimage.image.read
        @item.subimages << subimage
      end
    end      
    
    if @item.save
      redirect_to admin_item_path(@item), notice: "「"+@item.name+"」Registered !"
    else
    render "new"
    end
  end
  
  def update
    @item=Item.active.find(params[:id])
    @item.assign_attributes(item_params)

    if @item.main_image
      if !@item.main_image.image.kind_of?(String)
        @item.main_image.image=@item.main_image.image.read
      end
    end
    
    if @item.subimages
      @item.subimages.each do |subimage|
        if !subimage.image.kind_of?(String)
          subimage.image=subimage.image.read
          subimage.item_id=@item.id
          @item.subimages << subimage
        end
      end
    end
      
    if @item.save
      redirect_to admin_item_path(@item), notice: "「"+@item.name+"」Uploaded !"
    else
    render "edit"
    end
  end
  
  def destroy
    @item=Item.active.find(params[:id])
    @item.deleted = true
    if @item.save
      redirect_to admin_items_path, notice: "「"+@item.name+"」Deleted !"
    end
  end
  
  def plural_destroy
    if params[:checked_items]
      items = params[:checked_items].keys
      @items=Item.active.find(items)
      item_count=@items.size
      @i=0
      @items.each do |item|
        item.deleted = true
        if item.save
          @i=@i+1
        end
      end
      if @i=item_count
        redirect_to admin_items_path, notice: item_count.to_s+"件のITEMを削除しました"
      end
    else
      redirect_to admin_items_path, notice: "削除するITEMを選択してください"
    end
  end
  
  def search
    @items=Item.active.search(params[:q]).paginate(:page => params[:page], :per_page => 10)
    render "index"
  end
  
  def subcategory
    if request.xhr?
      @subcategories=Subcategory.active.where(:category_id => params[:category_id] ).all
    end
  end
  
  def units
    if request.xhr?
      @item_type=ItemType.active.find(params[:item_type_id])
      @unit=@item_type.unit_id_list
    end
  end
  
  
  def get_image1
    @main_image = MainImage.where(item_id: params[:id]).first
    if @main_image
      send_data(@main_image.image, :disposition => "inline", :type => "image/png")
    end
  end
  
  def get_image2
    @subimage = Subimage.where(item_id: params[:id]).first
    if @subimage
      send_data(@subimage.image, :disposition => "inline", :type => "image/png")
    end
  end
  
  def get_image3
    @subimage = Subimage.where(item_id: params[:id]).offset(1).first
    if @subimage
      send_data(@subimage.image, :disposition => "inline", :type => "image/png")
    end
  end
  
  def get_image4
    @subimage = Subimage.where(item_id: params[:id]).offset(2).first
    if @subimage
      send_data(@subimage.image, :disposition => "inline", :type => "image/png")
    end
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def item_params 
    params.require(:item).permit(:name, :subcategory_id, :price, :denomination_id, :condition_id, :size, :fabric_id, :spike_url, :sold_flag, :create_user, :edit_user, :description, :comment, main_image_attributes: [:id, :image, :item_id], subimages_attributes: [:id, :image, :item_id], new_arrival_attributes: [:id, :item_id, :deleted], recommendation_attributes: [:id, :item_id, :deleted])
  end
  
end
