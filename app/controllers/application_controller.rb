# coding: utf-8

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :authorize
  
  class Forbidden < StandardError;
  end
  
  private
  def authorize
    if session[:administrator_id]
      @current_user = Administrator.find_by_id(session[:administrator_id])
      session.delete(:administrator_id) unless @current_user
    end
  end
  
  def login_required
    raise Forbidden unless @current_user
  end
  
end

def getmenu
  categories=Category.all
  categories.each do |category|
    subcategories=Subcategory.find_by_category_id(category.id)
    subcategories_list.push=subcategories
  end
end