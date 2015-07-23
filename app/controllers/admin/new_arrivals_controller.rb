class Admin::NewArrivalsController < ApplicationController
  def index
    @new_arrivals=NewArrival.active.all.paginate(:page => params[:page], :per_page => 10)
  end
  
  def show
    @new_arrival=NewArrival.active.find(params[:id])
  end
  
  def new
  end
  
  def edit
    @new_arrival=NewArrival.active.find(params[:id])
  end
  
  def create
  end
  
  def update
    @new_arrival=NewArrival.active.find(params[:id])
    @new_arrival.assign_attributes(new_arrival_params)
      
    item=Item.active.find(@new_arrival.item_id)
    
    if @new_arrival.save
      redirect_to admin_new_arrival_path(@new_arrival), notice: "「"+item.name+"」Uploaded !"
    else
    render "edit"
    end
  end
  
  def destroy
    @new_arrival=NewArrival.active.find(params[:id])
    @new_arrival.deleted = true
    
    item=Item.active.find(@new_arrival.item_id)
    
    if @new_arrival.save
      redirect_to admin_new_arrivals_path, notice: "「"+item.name+"」Deleted !"
    end
  end
  
  def plural_destroy
    if params[:checked_new_arrivals]
      new_arrivals = params[:checked_new_arrivals].keys
      @new_arrivals=NewArrival.active.find(items)
      new_arrival_count=@new_arrivals.size
      @i=0
      @new_arrivals.each do |new_arrival|
        new_arrival.deleted = true
        if new_arrival.save
          @i=@i+1
        end
      end
      if @i=new_arrival_count
        redirect_to admin_new_arrivals_path, notice: new_arrival_count.to_s+"件のNEW ARRIVALを削除しました"
      end
    else
      redirect_to admin_new_arrivals_path, notice: "削除するNEW ARRIVALを選択してください"
    end
  end
  
  def search
    @new_arrivals=NewArrival.active.search(params[:q])
    render "index"
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def new_arrival_params 
    params.require(:new_arrival).permit(:item_id, :new_comment, :create_user, :edit_user, :comment)
  end
end
