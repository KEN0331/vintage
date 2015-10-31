class Admin::RecommendationsController < ApplicationController
  def index
    @recommendations=Recommendation.active.all.paginate(:page => params[:page], :per_page => 10)
  end
  
  def show
    @recommendation=Recommendation.active.find(params[:id])
  end
  
  def new
  end
  
  def edit
    @recommendation=Recommendation.active.find(params[:id])
    #binding.pry
    if !@recommendation.recommendation_image
      @recommendation_image=RecommendationImage.new
    end
  end
  
  def create
  end
  
  def update
    @recommendation=Recommendation.active.find(params[:id])
    @recommendation.assign_attributes(recommendation_params)

    if @recommendation.recommendation_image
      if !@recommendation.recommendation_image.image.kind_of?(String)
        @recommendation.recommendation_image.image=@recommendation.recommendation_image.image.read
      end
    end
    
    item=Item.active.find(@recommendation.item_id)
    
    if @recommendation.save
      redirect_to admin_recommendation_path(@recommendation), notice: "「"+item.name+"」Uploaded !"
    else
    render "edit"
    end
  end
  
  def destroy
    @recommendation=Recommendation.active.find(params[:id])
    @recommendation.deleted = true
    
    item=Item.active.find(@recommendation.item_id)
    
    if @recommendation.save
      redirect_to admin_recommendations_path, notice: "「"+item.name+"」Deleted !"
    end
  end
  
  def plural_destroy
    if params[:checked_recommendations]
      recommendations = params[:checked_recommendations].keys
      @recommendations=Recommendation.active.find(recommendations)
      recommendation_count=@recommendations.size
      @i=0
      @recommendations.each do |recommendation|
        recommendation.deleted = true
        if recommendation.save
          @i=@i+1
        end
      end
      if @i=recommendation_count
        redirect_to admin_recommendations_path, notice: recommendation_count.to_s+"件のRECOMMENDATIONを削除しました"
      end
    else
      redirect_to admin_recommendations_path, notice: "削除するRECOMMENDATIONを選択してください"
    end
  end
  
  def search
    @recommendations=Recommendation.active.search(params[:q]).paginate(:page => params[:page], :per_page => 10)
    render "index"
  end
  
  def get_image
    @recomendation_image = RecommendationImage.where(recommendation_id: params[:id]).first
    if @recomendation_image
      send_data(@recomendation_image.image, :disposition => "inline", :type => "image/png")
    end
  end
    
  # Never trust parameters from the scary internet, only allow the white list through.
  def recommendation_params 
    params.require(:recommendation).permit(:item_id, :related_item_id1, :related_item_id2, :related_item_id3, :related_item_id4, :recommendation, :comment, :create_user, :edit_user, recommendation_image_attributes: [:id, :image, :recommendation_id])
  end
end
