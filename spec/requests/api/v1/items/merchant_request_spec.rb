require 'rails_helper'

RSpec.describe 'Items Merchant Api' do
  it 'sends merchant for an item' do
    item1 = create(:item)

    get "/api/v1/items/#{item1.id}/merchant"

    expect(response).to be_successful

    merchant_response = JSON.parse(response.body)

    expect(merchant_response["data"]['attributes']['name']).to eq(item1.merchant.name)
  end
end
