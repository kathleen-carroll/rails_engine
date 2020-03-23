require 'rails_helper'

RSpec.describe "Merchants API" do
  before :each do
    @invoice_item = create(:invoice_item, quantity: 10, unit_price: 43.79)
    @invoice_item.item.merchant = @invoice_item.invoice.merchant
    @transaction = create(:transaction, invoice: @invoice_item.invoice)

    @invoice_item2 = create(:invoice_item, quantity: 11, unit_price: 1.99)
    @invoice_item2.item.merchant = @invoice_item2.invoice.merchant
    @transaction2 = create(:transaction, invoice: @invoice_item2.invoice)

    @invoice_item3 = create(:invoice_item, quantity: 12, unit_price: 10)
    @invoice_item3.item.merchant = @invoice_item3.invoice.merchant
    @transaction3 = create(:transaction, invoice: @invoice_item3.invoice)

    @invoice_item4 = create(:invoice_item, quantity: 17, unit_price: 12.43)
    @invoice_item4.item.merchant = @invoice_item4.invoice.merchant
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

  it 'can find merchant with most items' do
    x = '2'
    get "/api/v1/merchants/most_items?quantity=#{x}"

    expect(response).to be_successful

    merchant_response = JSON.parse(response.body)

    expect(merchant_response["data"].first['attributes']['name']).to eq(@invoice_item3.item.merchant.name)
    expect(merchant_response["data"].last['attributes']['name']).to eq(@invoice_item2.item.merchant.name)
  end

  it 'can find revenue for one merchant' do
    id = @invoice_item.item.merchant.id
    get "/api/v1/merchants/#{id}/revenue"

    expect(response).to be_successful

    merchant_response = JSON.parse(response.body)

    expect(merchant_response["data"].first['attributes']['revenue']).to eq(@invoice_item.unit_price * @invoice_item.quantity)

    new_invoice = create(:invoice, merchant: @invoice_item.invoice.merchant)
    new_item = create(:item, merchant: @invoice_item.invoice.merchant)
    new_invoice_item = create(:invoice_item, quantity: 20, unit_price: 50.79, item: new_item, invoice: new_invoice)
    new_trans = create(:transaction, invoice: new_invoice)
    revenue = (@invoice_item.unit_price * @invoice_item.quantity) + (new_invoice_item.unit_price * new_invoice_item.quantity)

    id = @invoice_item.item.merchant.id
    get "/api/v1/merchants/#{id}/revenue"

    new_merchant_response = JSON.parse(response.body)

    expect(new_merchant_response["data"].first['attributes']['revenue']).to eq(revenue)
  end

  it 'can find revenue across date range' do
    new_invoice = create(:invoice, merchant: @invoice_item.invoice.merchant)
    new_item = create(:item, merchant: @invoice_item.invoice.merchant)
    new_invoice_item = create(:invoice_item, quantity: 20, unit_price: 50.79, item: new_item, invoice: new_invoice)
    new_trans = create(:transaction, invoice: new_invoice, created_at: '2012-03-27 14:54:09 UTC')

    new_invoice2 = create(:invoice, merchant: @invoice_item.invoice.merchant)
    new_item2 = create(:item, merchant: @invoice_item.invoice.merchant)
    new_invoice_item2 = create(:invoice_item, quantity: 20, unit_price: 50.79, item: new_item2, invoice: new_invoice2)
    new_trans2 = create(:transaction, invoice: new_invoice2, created_at: '2012-03-27 14:54:09 UTC')
    revenue = (20 * 50.79) + (20 * 50.79)

    get "/api/v1/revenue?start=2012-03-09&end=2012-03-28"

    expect(response).to be_successful

    resp = JSON.parse(response.body)

    expect(resp["data"].first["attributes"]["revenue"]).to eq(revenue)
  end
end
