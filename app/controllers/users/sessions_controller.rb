class Users::SessionsController < Devise::SessionsController
  layout 'top'
  before_filter :configure_sign_in_params, only: [:create]
  before_filter :do_before
   
  # GET /resource/sign_in
   def new
     super
   end

  # POST /resource/sign_in
   def create
     super
   end

  # DELETE /resource/sign_out
   def destroy
     super
   end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
   def configure_sign_in_params
     devise_parameter_sanitizer.for(:sign_in) << :attribute
   end
   
   def do_before
     @categories=Category.where(gmenu_flag: true, deleted: false).all
     @subcategories_list=[]
     @categories.each do |category|
       subcategories=Subcategory.where(category_id: category.id, deleted: false).all
       @subcategories_list.push(subcategories)
     end
   end
end
