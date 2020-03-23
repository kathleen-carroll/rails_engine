class Api::V1::Merchants::BusinessController < ApplicationController
  def most_revenue
    query = Merchant
      .joins(:transactions)
      .joins(:invoice_items)
      .where("transactions.result ='success'")
      .select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue')
      .group(:id)
      .order('revenue desc')
      .limit("#{params[:quantity]}")

      render json: MerchantSerializer.new(query)
  end

  def most_items
    query = Merchant
      .joins(:transactions)
      .joins(:invoice_items)
      .where("transactions.result ='success'")
      .select('merchants.*, sum(invoice_items.quantity) as max_items')
      .group(:id)
      .order('max_items desc')
      .limit("#{params[:quantity]}")

      render json: MerchantSerializer.new(query)
  end
end
