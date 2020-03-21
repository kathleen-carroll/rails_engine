require 'rails_helper'

RSpec.describe 'Merchant Items Api' do
  it 'sends a list of items' do
    item1 = create(:item)
    item2 = create(:item, merchant: item1.merchant)
    item3 = create(:item)

    get "/api/v1/merchants/#{item1.merchant.id}/items"

    expect(response).to be_successful

    items_response = JSON.parse(response.body)

    expect(items_response["data"].count).to eq(2)
  end
end
