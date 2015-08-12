# coding: utf-8

class Admin::PurchasesController < ApplicationController
  def index
    @purchases=Purchase.active.order(id: :desc).paginate(:page => params[:page], :per_page => 10)
  end
  
  
  def show
    @purchase=Purchase.active.find(params[:id])
    @purchase.assign_attributes(:read_flg => true)
    @purchase.save    
  end
  
  def edit
    @purchase=Purchase.active.find(params[:id])
  end
  
  def update
    @purchase=Purchase.active.find(params[:id])
    @purchase.assign_attributes(purchase_params)
      
    if @purchase.save
      redirect_to admin_purchase_path(@purchase), notice: "「購入番号"+@purchase.id+"」Uploaded !"
    else
    render "edit"
    end
  end
  
  def destroy
    @purchase=Purchase.active.find(params[:id])
    @purchase.deleted = true
    if @purchase.save
      redirect_to admin_purchases_path, notice: "「購入番号"+@purchase.id+"」Deleted !"
    end
  end
  
  def plural_destroy
    if params[:checked_purchases]
      purchases = params[:checked_purchases].keys
      @purchases=Purchase.active.find(purchases)
      purchase_count=@purchases.size
      @i=0
      @purchases.each do |purchase|
        purchase.deleted = true
        if purchase.save
          @i=@i+1
        end
      end
      if @i=purchase_count
        redirect_to admin_purchase_path, notice: purchase_count.to_s+"件のPURCHASEを削除しました"
      end
    else
      redirect_to admin_purchases_path, notice: "削除するPURCHASEを選択してください"
    end
  end
  
  def search
    @purchases=Purchase.active.search(params[:q]).order(id: :desc)
    render "index"
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def purchase_params
    params.require(:purchase).permit(:shipping, :status, :read_flg, :return_flg, :edit_user, :comment)
   end
end
