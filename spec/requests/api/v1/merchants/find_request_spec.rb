require 'rails_helper'

RSpec.describe 'Merchant Find Api' do
  it 'find merchant by name' do
    merchant = create(:merchant, name: "Chambray")
    merchant2 = create(:merchant, name: "Ray of Sunshine")
    merchant3 = create(:merchant, name: "Nope")
    value = "ray"
    attribute = 'name'

    get "/api/v1/merchants/find?#{attribute}=#{value}"

    expect(response).to be_successful

    merchant_response = JSON.parse(response.body)

    expect(merchant_response["data"].first['attributes']['name']).to eq(merchant.name)
    expect(merchant_response["data"].last['attributes']['name']).to eq(merchant2.name)
  end

  xit 'find merchant by created_at' do
    merchant = create(:merchant, name: "Chambray")
    # require "pry"; binding.pry
    merchant.created_at.strftime('%Y-%m-%d')
    value = Date.today.strftime('%Y-%m-%d')
    attribute = 'created_at'

    get "/api/v1/merchants/find?#{attribute}=#{value}"

    expect(response).to be_successful

    merchant_response = JSON.parse(response.body)

    expect(merchant_response["data"].first['attributes']['date']).to eq(merchant.created_at)
  end
end
