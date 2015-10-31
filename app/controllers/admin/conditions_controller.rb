# coding: utf-8

class Admin::ConditionsController < ApplicationController
  def index
    @conditions=Condition.active.all.paginate(:page => params[:page], :per_page => 10)
  end
  
  
  def show
    @condition=Condition.active.find(params[:id])
  end
  
  def new
    @condition=Condition.new
  end
  
  def edit
    @condition=Condition.active.find(params[:id])
  end
  
  def create
    @condition=Condition.new(condition_params)
    if @condition.save
      redirect_to admin_condition_path(@condition), notice: "「"+@condition.name+"」Registered !"
    else
    render "new"
    end
  end
  
  def update
    @condition=Condition.active.find(params[:id])
    @condition.assign_attributes(condition_params)
      
    if @condition.save
      redirect_to admin_condition_path(@condition), notice: "「"+@condition.name+"」Uploaded !"
    else
    render "edit"
    end
  end
  
  def destroy
    @condition=Condition.active.find(params[:id])
    @condition.deleted = true
    if @condition.save
      redirect_to admin_conditions_path, notice: "「"+@condition.name+"」Deleted !"
    end
  end
  
  def plural_destroy
    if params[:checked_conditions]
      conditions = params[:checked_conditions].keys
      @conditions=Condition.active.find(conditions)
      condition_count=@conditions.size
      @i=0
      @conditions.each do |condition|
        condition.deleted = true
        if condition.save
          @i=@i+1
        end
      end
      if @i=condition_count
        redirect_to admin_conditions_path, notice: condition_count.to_s+"件のCONDITIONを削除しました"
      end
    else
      redirect_to admin_conditions_path, notice: "削除するCONDITIONを選択してください"
    end
  end
  
  def search
    @conditions=Condition.active.search(params[:q]).paginate(:page => params[:page], :per_page => 10)
    render "index"
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def condition_params 
    params.require(:condition).permit(:name, :description, :create_user, :edit_user, :comment)
  end

end
