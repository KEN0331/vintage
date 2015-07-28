# coding: utf-8

class TopController < ApplicationController
  before_filter :do_before
  
  def index
    @items=Item.active.all.paginate(:page => params[:page], :per_page => 15)
  end
  
  def about_us
  end
  
  def show_item
    @showitem=Item.active.where(id: params[:item]).first
    @related_items=Item.where(subcategory_id: @showitem.subcategory_id, sold_flag: false).where.not(id: params[:item]).active.all.sample(8)
  end
  
  def categorized
    @category = params[:category]
    @subcategory=params[:subcategory]
    @category_name=params[:category_name]
    @subcategory_name=params[:subcategory_name]
    
#   カテゴリー名とサブカテゴリー名でページタイトル作成
    if @category_name&&@subcategory_name
      @title=@category_name+"&"+@subcategory_name
    elsif @category_name
      @title=@category_name
    end  
      
#   

    if @category_name&&@subcategory_name
      @items=Item.where(subcategory_id: @subcategory,deleted: false).all.paginate(:page => params[:page], :per_page => 15)
    elsif @category
      id=Subcategory.where(category_id: @category,deleted: false).all
      @items=Item.where(subcategory_id: id,deleted: false).all.paginate(:page => params[:page], :per_page => 15)
    end

    
  end
  
  def new_arrivals
    @new_arrivals=NewArrival.active.all.paginate(:page => params[:page], :per_page => 15)
  end
  
  def recommend
    @recommendations=Recommendation.active.all.paginate(:page => params[:page], :per_page => 15)
  end
  
  def blog
    
  end
  
  def contact
    
  end
  
  def add
    session[:cart] ||= Cart.new
    if params[:id]
      item = Item.find(params[:id])
      session[:cart].add_to_cart(item)
    end
    @cart = session[:cart]
    render :action => 'cart.html.erb'
  end

  def search
    @items=Item.search(params[:q]).paginate(:page => params[:page], :per_page => 15)
    render "index"
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
  
    
  def do_before
    @categories=Category.where(gmenu_flag: true, deleted: false).all
    @subcategories_list=[]
    @categories.each do |category|
      subcategories=Subcategory.where(category_id: category.id, deleted: false).all
      @subcategories_list.push(subcategories)
    end
  end
  
end
