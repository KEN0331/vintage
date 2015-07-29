# coding: utf-8

class CheckController < ActionController::Base
  
  def pay(amount)
    begin
      webpay = WebPay.new('test_secret_bKR1DxbHX7iq0bdaTt8O0157')
      webpay.charge.create(
        amount: amount,
        currency: "jpy",
        card:
          {number: "4242-4242-4242-4242",
           exp_month: 8,
           exp_year: 2017,
           cvc: "123",
           name: "KENTARO SATA"}
      )
    rescue
      return false
    end
  end

end