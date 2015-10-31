# coding: utf-8

class Admin::AuthoritiesController < ApplicationController
  def index
    @authorities=Authority.active.all.paginate(:page => params[:page], :per_page => 10)
  end
  
  
  def show
    @authority=Authority.active.find(params[:id])
  end
  
  def new
    @authority=Authority.new
  end
  
  def edit
    @authority=Authority.active.find(params[:id])
  end
  
  def create
    @authority=Authority.new(authority_params)
    if @authority.save
      redirect_to admin_authority_path(@authority), notice: "「"+@authority.name+"」Registered !"
    else
    render "new"
    end
  end
  
  def update
    @authority=Authority.active.find(params[:id])
    @authority.assign_attributes(authority_params)
      
    if @authority.save
      redirect_to admin_authority_path(@authority), notice: "「"+@authority.name+"」Uploaded !"
    else
    render "edit"
    end
  end
  
  def destroy
    @authority=Authority.active.find(params[:id])
    @authority.deleted = true
    if @authority.save
      redirect_to admin_authorities_path, notice: "「"+@authority.name+"」Deleted !"
    end
  end
  
  def plural_destroy
    if params[:checked_authorities]
      authorities = params[:checked_authorities].keys
      @authorities=Authority.active.find(authorities)
      authority_count=@authorities.size
      @i=0
      @authorities.each do |authority|
        authority.deleted = true
        if authority.save
          @i=@i+1
        end
      end
      if @i=authority_count
        redirect_to admin_authorities_path, notice: authority_count.to_s+"件のAUTHORITYを削除しました"
      end
    else
      redirect_to admin_authorities_path, notice: "削除するAUTHORITYを選択してください"
    end
  end
  
  def search
    @authorities=Authority.active.search(params[:q]).paginate(:page => params[:page], :per_page => 10)
    render "index"
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def authority_params 
    params.require(:authority).permit(:name, :authority, :comment)
  end
  
end
