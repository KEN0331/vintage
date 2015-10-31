# coding: utf-8

class Admin::FabricsController < ApplicationController
  def index
    @fabrics=Fabric.active.all.paginate(:page => params[:page], :per_page => 10)
  end
  
  
  def show
    @fabric=Fabric.active.find(params[:id])
  end
  
  def new
    @fabric=Fabric.new
  end
  
  def edit
    @fabric=Fabric.active.find(params[:id])
  end
  
  def create
    @fabric=Fabric.new(fabric_params)
    if @fabric.save
      redirect_to admin_fabric_path(@fabric), notice: "「"+@fabric.name+"」Registered !"
    else
    render "new"
    end
  end
  
  def update
    @fabric=Fabric.active.find(params[:id])
    @fabric.assign_attributes(fabric_params)
      
    if @fabric.save
      redirect_to admin_fabric_path(@fabric), notice: "「"+@fabric.name+"」Uploaded !"
    else
    render "edit"
    end
  end
  
  def destroy
    @fabric=Fabric.active.find(params[:id])
    @fabric.deleted = true
    if @fabric.save
      redirect_to admin_fabrics_path, notice: "「"+@fabric.name+"」Deleted !"
    end
  end
  
  def plural_destroy
    if params[:checked_fabrics]
      fabrics = params[:checked_fabrics].keys
      @fabrics=Fabric.active.find(fabrics)
      fabric_count=@fabrics.size
      @i=0
      @fabrics.each do |fabric|
        fabric.deleted = true
        if fabric.save
          @i=@i+1
        end
      end
      if @i=fabric_count
        redirect_to admin_fabrics_path, notice: fabric_count.to_s+"件のFABRICを削除しました"
      end
    else
      redirect_to admin_fabrics_path, notice: "削除するFABRICを選択してください"
    end
  end
  
  def search
    @fabrics=Fabric.active.search(params[:q]).paginate(:page => params[:page], :per_page => 10)
    render "index"
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def fabric_params 
    params.require(:fabric).permit(:name, :description, :create_user, :edit_user, :comment)
   end

end
