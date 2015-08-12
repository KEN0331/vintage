# coding: utf-8

class Admin::ColorsController < ApplicationController
  def index
    @colors=Color.active.all.paginate(:page => params[:page], :per_page => 10)
  end
  
  
  def show
    @color=Color.active.find(params[:id])
  end
  
  def new
    @color=Color.new
  end
  
  def edit
    @color=Color.active.find(params[:id])
  end
  
  def create
    @color=Color.new(color_params)
    if @color.save
      redirect_to admin_color_path(@color), notice: "「"+@color.name+"」Registered !"
    else
    render "new"
    end
  end
  
  def update
    @color=Color.active.find(params[:id])
    @color.assign_attributes(color_params)
      
    if @color.save
      redirect_to admin_color_path(@color), notice: "「"+@color.name+"」Uploaded !"
    else
    render "edit"
    end
  end
  
  def destroy
    @color=Color.active.find(params[:id])
    @color.deleted = true
    if @color.save
      redirect_to admin_colors_path, notice: "「"+@color.name+"」Deleted !"
    end
  end
  
  def plural_destroy
    if params[:checked_colors]
      colors = params[:checked_colors].keys
      @colors=Color.active.find(colors)
      color_count=@colors.size
      @i=0
      @colors.each do |color|
        color.deleted = true
        if color.save
          @i=@i+1
        end
      end
      if @i=color_count
        redirect_to admin_colors_path, notice: color_count.to_s+"件のCOLORを削除しました"
      end
    else
      redirect_to admin_colors_path, notice: "削除するCOLORを選択してください"
    end
  end
  
  def search
    @colors=Color.active.search(params[:q])
    render "index"
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def color_params 
    params.require(:color).permit(:name, :code, :create_user, :edit_user, :comment)
   end
end
