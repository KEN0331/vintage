# coding: utf-8

class Admin::CategoriesController < ApplicationController
  def index
    @categories=Category.active.all.paginate(:page => params[:page], :per_page => 10)
  end
  
  
  def show
    @category=Category.active.find(params[:id])
  end
  
  def new
    @category=Category.new
  end
  
  def edit
    @category=Category.active.find(params[:id])
  end
  
  def create
    @category=Category.new(category_params)
    if @category.save
      redirect_to admin_category_path(@category), notice: "「"+@category.name+"」Registered !"
    else
    render "new"
    end
  end
  
  def update
    @category=Category.active.find(params[:id])
    @category.assign_attributes(category_params)
      
    if @category.save
      redirect_to admin_category_path(@category), notice: "「"+@category.name+"」Uploaded !"
    else
    render "edit"
    end
  end
  
  def destroy
    @category=Category.active.find(params[:id])
    @category.deleted = true
    if @category.save
      redirect_to admin_categories_path, notice: "「"+@category.name+"」Deleted !"
    end
  end
  
  def plural_destroy
    if params[:checked_categories]
      categories = params[:checked_categories].keys
      @categories=Category.active.find(categories)
      category_count=@categories.size
      @i=0
      @categories.each do |category|
        category.deleted = true
        if category.save
          @i=@i+1
        end
      end
      if @i=category_count
        redirect_to admin_categories_path, notice: category_count.to_s+"件のCATEGORYを削除しました"
      end
    else
      redirect_to admin_categories_path, notice: "削除するCATEGORYを選択してください"
    end
  end
  
  def search
    @categories=Category.active.search(params[:q])
    render "index"
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def category_params 
    params.require(:category).permit(:name, :gmenu_flag, :create_user, :edit_user, :comment)
   end
  
end
