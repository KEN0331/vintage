# coding: utf-8

class Admin::UsersController < ApplicationController
  def index
    @denominations=Denomination.active.all.paginate(:page => params[:page], :per_page => 10)
  end
  
  
  def show
    @denomination=Denomination.active.find(params[:id])
  end
  
  def new
    @denomination=Denomination.new
  end
  
  def edit
    @denomination=Denomination.active.find(params[:id])
  end
  
  def create
    @denomination=Denomination.new(denomination_params)
    if @denomination.save
      redirect_to admin_denomination_path(@denomination), notice: "「"+@denomination.name+"」Registered !"
    else
    render "new"
    end
  end
  
  def update
    @denomination=Denomination.active.find(params[:id])
    @denomination.assign_attributes(denomination_params)
      
    if @denomination.save
      redirect_to admin_denomination_path(@denomination), notice: "「"+@denomination.name+"」Uploaded !"
    else
    render "edit"
    end
  end
  
  def destroy
    @denomination=Denomination.active.find(params[:id])
    @denomination.deleted = true
    if @denomination.save
      redirect_to admin_denominations_path, notice: "「"+@denomination.name+"」Deleted !"
    end
  end
  
  def plural_destroy
    if params[:checked_denominations]
      denominations = params[:checked_denominations].keys
      @denominations=Denomination.active.find(denominations)
      denomination_count=@denominations.size
      @i=0
      @denominations.each do |denomination|
        denomination.deleted = true
        if denomination.save
          @i=@i+1
        end
      end
      if @i=denomination_count
        redirect_to admin_denominations_path, notice: denomination_count.to_s+"件のDENOMINATIONを削除しました"
      end
    else
      redirect_to admin_denominations_path, notice: "削除するDENOMINATIONを選択してください"
    end
  end
  
  def search
    @denominations=Denomination.active.search(params[:q]).paginate(:page => params[:page], :per_page => 10)
    render "index"
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def denomination_params 
    params.require(:denomination).permit(:name, :create_user, :edit_user, :comment)
   end
end
