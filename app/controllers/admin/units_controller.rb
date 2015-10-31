# coding: utf-8

class Admin::UnitsController < ApplicationController
  def index
    @units=Unit.active.all.paginate(:page => params[:page], :per_page => 10)
  end
  
  
  def show
    @unit=Unit.active.find(params[:id])
  end
  
  def new
    @unit=Unit.new
  end
  
  def edit
    @unit=Unit.active.find(params[:id])
  end
  
  def create
    @unit=Unit.new(unit_params)
    if @unit.save
      redirect_to admin_unit_path(@unit), notice: "「"+@unit.name+"」Registered !"
    else
    render "new"
    end
  end
  
  def update
    @unit=Unit.active.find(params[:id])
    @unit.assign_attributes(unit_params)
      
    if @unit.save
      redirect_to admin_unit_path(@unit), notice: "「"+@unit.name+"」Uploaded !"
    else
    render "edit"
    end
  end
  
  def destroy
    @unit=Unit.active.find(params[:id])
    @unit.deleted = true
    if @unit.save
      redirect_to admin_units_path, notice: "「"+@unit.name+"」Deleted !"
    end
  end
  
  def plural_destroy
    if params[:checked_units]
      units = params[:checked_units].keys
      @units=Unit.active.find(units)
      unit_count=@units.size
      @i=0
      @units.each do |unit|
        unit.deleted = true
        if unit.save
          @i=@i+1
        end
      end
      if @i=unit_count
        redirect_to admin_units_path, notice: unit_count.to_s+"件のUNITを削除しました"
      end
    else
      redirect_to admin_units_path, notice: "削除するUNITを選択してください"
    end
  end
  
  def search
    @units=Unit.active.search(params[:q]).paginate(:page => params[:page], :per_page => 10)
    render "index"
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def unit_params 
    params.require(:unit).permit(:name, :unit, :create_user, :edit_user, :comment)
  end
  
end
