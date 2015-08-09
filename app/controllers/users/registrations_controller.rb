class Users::RegistrationsController < Devise::RegistrationsController
  layout 'top'
  before_filter :configure_sign_up_params, only: [:create]
  before_filter :configure_account_update_params, only: [:update]
  before_filter :do_before
    
  # GET /resource/sign_up
   def new
     super
   end

  # POST /resource
   def create
     super
   end

  # GET /resource/edit
   def edit
     super
   end

  # PUT /resource
   def update
     super
   end

  # DELETE /resource
   def destroy
     super
   end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
   def cancel
     super
   end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
   def configure_sign_up_params
     devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:password, :password_confirmation,:current_password,:email,:last_name, :first_name,:last_name_kana,:first_name_kana, adress_attributes: [:id, :postal_code_3,:postal_code_4,:todohuken,:shikutyouson,:adress_detail], card_attributes: [:id, :customer_id] ) }
   end

  # If you have extra params to permit, append them to the sanitizer.
   def configure_account_update_params
     devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:password, :password_confirmation,:current_password,:email,:last_name, :first_name,:last_name_kana,:first_name_kana, adress_attributes: [:id, :postal_code_3,:postal_code_4,:todohuken,:shikutyouson,:adress_detail], card_attributes: [:id, :customer_id] ) }
   end

  # The path used after sign up.
   def after_sign_up_path_for(resource)
     super(resource)
   end

  # The path used after sign up for inactive accounts.
   def after_inactive_sign_up_path_for(resource)
     super(resource)
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
