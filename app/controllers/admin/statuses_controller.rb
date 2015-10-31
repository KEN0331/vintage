# coding: utf-8

class Admin::StatusesController < ApplicationController
  def index
    @statuses=Status.active.all.paginate(:page => params[:page], :per_page => 10)
  end
  
  
  def show
    @status=Status.active.find(params[:id])
  end
  
  def new
    @status=Status.new
  end
  
  def edit
    @status=Status.active.find(params[:id])
  end
  
  def create
    @status=Status.new(status_params)
    if @status.save
      redirect_to admin_status_path(@status), notice: "「"+@status.name+"」Registered !"
    else
    render "new"
    end
  end
  
  def update
    @status=Status.active.find(params[:id])
    @status.assign_attributes(status_params)
      
    if @status.save
      redirect_to admin_status_path(@status), notice: "「"+@status.name+"」Uploaded !"
    else
    render "edit"
    end
  end
  
  def destroy
    @status=Status.active.find(params[:id])
    @status.deleted = true
    if @status.save
      redirect_to admin_statuses_path, notice: "「"+@status.name+"」Deleted !"
    end
  end
  
  def plural_destroy
    if params[:checked_statuses]
      statuses = params[:checked_statuses].keys
      @statuses=Status.active.find(statuses)
      status_count=@statuses.size
      @i=0
      @statuses.each do |status|
        status.deleted = true
        if status.save
          @i=@i+1
        end
      end
      if @i=status_count
        redirect_to admin_statuses_path, notice: status_count.to_s+"件のSTATUSを削除しました"
      end
    else
      redirect_to admin_statuses_path, notice: "削除するSTATUSを選択してください"
    end
  end
  
  def search
    @statuses=Status.active.search(params[:q]).paginate(:page => params[:page], :per_page => 10)
    render "index"
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def status_params 
    params.require(:status).permit(:name, :ratio, :color_id, :create_user, :edit_user, :comment)
   end
end
