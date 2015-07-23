# coding: utf-8

class Admin::AdministratorsController < ApplicationController
  def index
    @administrators=Administrator.active.all.paginate(:page => params[:page], :per_page => 10)
  end
  
  
  def show
    @administrator=Administrator.active.find(params[:id])
  end
  
  def new
    @administrator=Administrator.new
  end
  
  def edit
    @administrator=Administrator.active.find(params[:id])
  end
  
  def create
    @administrator=Administrator.new(administrator_params)
    if @administrator.save
      redirect_to admin_administrator_path(@administrator), notice: "「"+@administrator.name+"」Registered !"
    else
    render "new"
    end
  end
  
  def update
    @administrator=Administrator.active.find(params[:id])
    @administrator.assign_attributes(administrator_params)
      
    if @administrator.save
      redirect_to admin_administrator_path(@administrator), notice: "「"+@administrator.name+"」Uploaded !"
    else
    render "edit"
    end
  end
  
  def destroy
    @administrator=Administrator.active.find(params[:id])
    @administrator.deleted = true
    if @administrator.save
      redirect_to admin_administrators_path, notice: "「"+@administrator.name+"」Deleted !"
    end
  end
  
  def plural_destroy
    if params[:checked_administrators]
      administrators = params[:checked_administrators].keys
      @administrators=Administrator.active.find(administrators)
      administrator_count=@administrators.size
      @i=0
      @administrators.each do |administrator|
        administrator.deleted = true
        if administrator.save
          @i=@i+1
        end
      end
      if @i=administrator_count
        redirect_to admin_administrators_path, notice: administrator_count.to_s+"件のADMINISTRATORを削除しました"
      end
    else
      redirect_to admin_administrators_path, notice: "削除するADMINISTRATORを選択してください"
    end
  end
  
  def search
    @administrators=Administrator.active.search(params[:q])
    render "index"
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def administrator_params 
    params.require(:administrator).permit(:name, :userid, :password, :password_confirmation, :authority_id, :tel, :email, :create_user, :edit_user, :comment)
  end
  
end
