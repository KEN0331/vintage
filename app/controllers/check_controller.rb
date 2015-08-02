# coding: utf-8

class CheckController < ActionController::Base
  
  def pay
    begin
      webpay = WebPay.new('test_secret_bKR1DxbHX7iq0bdaTt8O0157')
      customer = webpay.customer.create(card: params[:webpay_token])
      webpay.charge.create(
        amount: params[:amount],
        currency: "jpy",
        card:
          {number: "4242-4242-4242-4242",
           exp_month: 8,
           exp_year: 2017,
           cvc: "123",
           name: "KENTARO SATA"},
        customer: customer.id
      )

      session[:cart] = Cart.new
      redirect_to thanks_path
    rescue
      return false
    end
  end
  
end