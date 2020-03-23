require 'rails_helper'

RSpec.describe "Merchants API" do
  before :each do
    @invoice_item = create(:invoice_item, quantity: 10, unit_price: 43.79)
    @invoice_item.item.merchant = @invoice_item.invoice.merchant
    @invoice_item2 = create(:invoice_item, quantity: 1, unit_price: 1.99)
    @invoice_item2.item.merchant = @invoice_item2.invoice.merchant
    @invoice_item3 = create(:invoice_item, quantity: 7, unit_price: 10)
    @invoice_item3.item.merchant = @invoice_item3.invoice.merchant
    @invoice_item4 = create(:invoice_item, quantity: 17, unit_price: 12.43)
    @invoice_item4.item.merchant = @invoice_item4.invoice.merchant
    @transaction = create(:transaction, invoice: @invoice_item.invoice)
    @transaction2 = create(:transaction, invoice: @invoice_item2.invoice)
    @transaction3 = create(:transaction, invoice: @invoice_item3.invoice)
    @transaction4 = create(:transaction, invoice: @invoice_item4.invoice, result: "failed")
  end

  it 'can find merchant with most revenue' do

    x = '2'
    get "/api/v1/merchants/most_revenue?quantity=#{x}"

    expect(response).to be_successful

    merchant_response = JSON.parse(response.body)

    expect(merchant_response["data"].first['attributes']['name']).to eq(@invoice_item.item.merchant.name)
    expect(merchant_response["data"].last['attributes']['name']).to eq(@invoice_item3.item.merchant.name)
  end
end
