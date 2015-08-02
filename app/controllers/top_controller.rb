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
      if !item.sold_flag
        session[:cart].add_to_cart(item)
      end
    end
    @cart = session[:cart]
    render :action => 'cart.html.erb'
  end
  
  def delete_cart_item
    if session[:cart]
      @cart = session[:cart]
      @cart.destroy(params[:no].to_i)
    end
    render :action => 'cart.html.erb'
  end
  
  def plural_delete_cart_item
    if session[:cart]
      @cart = session[:cart]
      @cart.plural_destroy(params[:checked_items])
    end
    render :action => 'cart.html.erb'
  end
  
  def confirm
    if session[:cart]
      @cart = session[:cart]
    end
    
    webpay = WebPay.new('test_secret_bKR1DxbHX7iq0bdaTt8O0157')
    customer_info = params['customer_form']
      
    # 顧客情報詳細(名前 住所)
    @name = params[:last_name] +"\n"+ params[:first_name]
    @name_kana =  params[:last_name_kana] +"\n"+ params[:first_name_kana]
    @postal_code_4 = params[:postal_code_4]
    @postal_code_3 = params[:postal_code_3]
    @todohuken = params[:todohuken]
    @shikutyouson = params[:shikutyouson]
    @adress_detail = params[:adress_detail]
    detail = "[氏名： " + @name + "\n/\n " + @name_kana + "] \n[住所： " + @postal_code_4 + " - " + @postal_code_3 + "\n" + @todohuken + @shikutyouson + @adress_detail + "]" 
    customer_info["description"] = detail 
    
    # 顧客情報の登録    
    @customer = webpay.customer.create(customer_info)
  end
  
  def pay
    webpay = WebPay.new('test_secret_bKR1DxbHX7iq0bdaTt8O0157')
    
    # 顧客情報の登録
    customer = webpay.customer.retrieve(params[:customer_id])

    # 顧客情報を使って支払い
    webpay.charge.create(
      amount: params[:amount],
      currency: 'jpy',
      customer: customer.id
    )
    session[:cart] = Cart.new
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
