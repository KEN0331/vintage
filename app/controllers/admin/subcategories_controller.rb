# coding: utf-8

class Admin::SubcategoriesController < ApplicationController
  def index
    @subcategories=Subcategory.active.all.paginate(:page => params[:page], :per_page => 10)
  end
  
  
  def show
    @subcategory=Subcategory.active.find(params[:id])
  end
  
  def new
    @subcategory=Subcategory.new
  end
  
  def edit
    @subcategory=Subcategory.active.find(params[:id])
  end
  
  def create
    @subcategory=Subcategory.new(subcategory_params)
    if @subcategory.save
      redirect_to admin_subcategory_path(@subcategory), notice: "「"+@subcategory.name+"」Registered !"
    else
    render "new"
    end
  end
  
  def update
    @subcategory=Subcategory.active.find(params[:id])
    @subcategory.assign_attributes(subcategory_params)
      
    if @subcategory.save
      redirect_to admin_subcategory_path(@subcategory), notice: "「"+@subcategory.name+"」Uploaded !"
    else
    render "edit"
    end
  end
  
  def destroy
    @subcategory=Subcategory.active.find(params[:id])
    @subcategory.deleted = true
    if @subcategory.save
      redirect_to admin_subcategories_path, notice: "「"+@subcategory.name+"」Deleted !"
    end
  end
  
  def plural_destroy
    if params[:checked_subcategories]
      subcategories = params[:checked_subcategories].keys
      @subcategories=Subcategory.active.find(subcategories)
      subcategory_count=@subcategories.size
      @i=0
      @subcategories.each do |subcategory|
        subcategory.deleted = true
        if subcategory.save
          @i=@i+1
        end
      end
      if @i=subcategory_count
        redirect_to admin_subcategories_path, notice: subcategory_count.to_s+"件のSUBCATEGORYを削除しました"
      end
    else
      redirect_to admin_subcategories_path, notice: "削除するSUBCATEGORYを選択してください"
    end
  end
  
  def search
    @subcategories=Subcategory.active.search(params[:q])
    render "index"
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def subcategory_params 
    params.require(:subcategory).permit(:name, :category_id, :create_user, :edit_user, :comment)
   end

end
