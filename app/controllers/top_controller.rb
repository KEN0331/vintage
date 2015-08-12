# coding: utf-8

class TopController < ApplicationController
  before_filter :do_before
  before_filter :authenticate_user!, only: [:checkout, :confirm]
  
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
  
  def checkout
    @cart = session[:cart]
    cards = Card.where(user_id: current_user.id)
    if cards.first
      webpay = WebPay.new('test_secret_bKR1DxbHX7iq0bdaTt8O0157')
      @cards = []
      cards.each do |card|
        @cards << webpay.customer.retrieve(card.customer_id)        
      end
    end
    
    @adresses = Adress.where(user_id: current_user.id)
  end
  
  
  
  ## メソッド概要 : 内容確認画面遷移メソッド            ##
  ## params :  card, adress, customer_form,     ##
  ##           postal_code_3, postal_code_4,    ##
  ##           todohuken, shikutyouson,         ##
  ##           adress_detail, last_name,        ##
  ##           last_name_kana, first_name,      ##
  ##           first_name_kana                  ##
  ##                                            ##
  ## @global : @name, @name_kana, @adress,      ##
  ##           @customer, @adress_id,           ##
  def confirm
    if session[:cart]
      webpay = WebPay.new('test_secret_bKR1DxbHX7iq0bdaTt8O0157')
      customer_info = params['customer_form']
      
      # ログインユーザーの登録済みのカード情報・住所が存在する場合
      if params[:card] && params[:adress] && current_user
        # 既存のカード、既存の住所を使う場合
        if params[:card][:id].present? && params[:adress][:id].present? && current_user

          # アウトプット用データの作成
          @adress_id = params[:adress][:id]
          adress = Adress.find(@adress_id)
          @adress = adress.postal_code_3 + " - " + adress.postal_code_4 +  "\n" + adress.todohuken + adress.shikutyouson + adress.adress_detail
          @name = current_user.last_name + "\n" + current_user.first_name
          @name_kana =  current_user.last_name_kana + "\n" + current_user.first_name_kana

          #顧客情報の取得
          @customer = webpay.customer.retrieve(params[:card][:id])
                    
        # 新規のカード、既存の住所を使う場合
        elsif params[:card][:id].empty? && params[:adress][:id].present? && current_user

          # アウトプット用データの作成
          @adress_id = params[:adress][:id]
          adress = Adress.find(@adress_id)
          @adress = adress.postal_code_3 + " - " + adress.postal_code_4 +  "\n" + adress.todohuken + adress.shikutyouson + adress.adress_detail
          @name = current_user.last_name + "\n" + current_user.first_name
          @name_kana =  current_user.last_name_kana + "\n" + current_user.first_name_kana
          
          # 顧客情報(カード)の登録
          detail = "[氏名： " + @name + "\n/\n " + @name_kana + "] \n[住所： " + @adress + "]"    #顧客詳細
          customer_info["description"] = detail
          @customer = webpay.customer.create(customer_info)

          #カード情報を顧客にひも付けDB登録
          card = Card.new(:user_id => current_user.id, :customer_id => @customer.id)        #カード情報オブジェクト
          user = User.find(current_user.id)
          user.cards << card            
          user.save
          
        # 既存のカード、新規の住所を使う場合
        elsif params[:card][:id].present? && params[:adress][:id].empty? && current_user
          
          # アウトプット用データの作成
          @customer = webpay.customer.retrieve(params[:card][:id])
          @name = current_user.last_name + "\n" + current_user.first_name
          @name_kana =  current_user.last_name_kana + "\n" + current_user.first_name_kana
          @adress = params[:postal_code_3] + " - " + params[:postal_code_4] + "\n" + params[:todohuken] + params[:shikutyouson] + params[:adress_detail]
          
          # 住所情報を顧客にひも付けDB登録
          adress = Adress.new(:user_id => current_user.id, :postal_code_3 => params[:postal_code_3],
                              :postal_code_4 => params[:postal_code_4], :todohuken => params[:todohuken], 
                              :shikutyouson => params[:shikutyouson], :adress_detail => params[:adress_detail])        #住所情報オブジェクト
          @adress_id = adress.id
          user = User.find(current_user.id)
          user.adresses << adress
          user.save
          
        # 新規のカード、新規の住所を使う場合
        elsif params[:card][:id].empty? && params[:adress][:id].empty? && current_user
          
          # アウトプット用データの作成
          @name = current_user.last_name + "\n" + current_user.first_name
          @name_kana =  current_user.last_name_kana + "\n" + current_user.first_name_kana
          @adress = params[:postal_code_3] + " - " + params[:postal_code_4] + "\n" + params[:todohuken] + params[:shikutyouson] + params[:adress_detail]
          
          # 顧客情報(カード)の登録
          detail = "[氏名： " + @name + "\n/\n " + @name_kana + "] \n[住所： " + @adress + "]"    #顧客詳細
          customer_info["description"] = detail
          @customer = webpay.customer.create(customer_info)

          # カード・住所情報を顧客にひも付けDB登録
          card = Card.new(:user_id => current_user.id, :customer_id => @customer.id)                                   #カード情報オブジェクト
          adress = Adress.new(:user_id => current_user.id, :postal_code_3 => params[:postal_code_3],
                              :postal_code_4 => params[:postal_code_4], :todohuken => params[:todohuken],
                              :shikutyouson => params[:shikutyouson], :adress_detail => params[:adress_detail])        #住所情報オブジェクト
          @adress_id = adress.id
          user = User.find(current_user.id)          
          user.adresses << adress
          user.cards << card
          user.save
        end
        
      # はじめての登録の場合
      else
        
        # アウトプット用データの作成
        @name = params[:last_name] +"\n"+ params[:first_name]
        @name_kana =  params[:last_name_kana] +"\n"+ params[:first_name_kana]
        @adress = params[:postal_code_3] + " - " + params[:postal_code_4] + "\n" + params[:todohuken] + params[:shikutyouson] + params[:adress_detail]
        
        # 顧客情報(カード)の登録
        detail = "[氏名： " + @name + "\n/\n " + @name_kana + "] \n[住所： " + @adress + "]"    #顧客詳細
        customer_info["description"] = detail
        @customer = webpay.customer.create(customer_info)

        # 顧客情報(氏名)のDB登録
        user = User.find(current_user.id)
        user.assign_attributes(:last_name => params[:last_name], :first_name => params[:first_name],
                               :last_name_kana => params[:last_name_kana], :first_name_kana => params[:first_name_kana])        #ユーザー情報オブジェクト

        # カード・住所情報を顧客にひも付けDB登録
        card = Card.new(:user_id => current_user.id, :customer_id => @customer.id)                                   #カード情報オブジェクト
        adress = Adress.new(:user_id => current_user.id, :postal_code_3 => params[:postal_code_3],
                            :postal_code_4 => params[:postal_code_4], :todohuken => params[:todohuken],
                            :shikutyouson => params[:shikutyouson], :adress_detail => params[:adress_detail])        #住所情報オブジェクト
        @adress_id = adress.id        
        user.adresses << adress
        user.cards << card                  
        user.save
      end
    end
  end
  
  ## メソッド概要 : 購入メソッド            ##
  ## params :  customer_id, adress_id  ##
  ## @global :                         ##
  def pay
    webpay = WebPay.new('test_secret_bKR1DxbHX7iq0bdaTt8O0157')
    
    # 顧客情報の取得
    customer = webpay.customer.retrieve(params[:customer_id])
    
    amount = session[:cart].getTotalPrice           #小計金額
    tax = amount.to_i*0.08/1.08                     #消費税
    
    # 顧客情報を使って支払い
    webpay.charge.create(
      amount: amount,
      currency: 'jpy',
      customer: customer.id
    )
    
    #購入商品リスト作成
    item_id_list = []
    items = session[:cart].items
    items.each do |item|
      item_id_list.push(item.id)
    end

    #顧客が今回使うカード
    card = Card.active.where(customer_id: customer.id).first
    
    #購入履歴の作成
    purchase = Purchase.new(:item_id_list => item_id_list, :card_id => card.id, :adress_id => params[:adress_id], :amount => amount, :tax => tax.to_s)
    if purchase.save
      session[:cart] = Cart.new
    end
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
