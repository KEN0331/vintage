# coding: utf-8
class Admin::SessionsController < ApplicationController
  def create
    administrator = Administrator.authenticate(params[:userid],params[:password])
    if administrator
      session[:administrator_id] = administrator.id 
    else
      flash.alert = "ユーザーIDとパスワードが一致しません。"
    end
    redirect_to params[:form] || :admin_root
  end
  
  def destroy
    session.delete(:administrator_id)
    redirect_to :admin_root
  end
end
