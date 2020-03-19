require 'rails_helper'

RSpec.describe "Merchants API" do
  it "sends a list of merchants" do
    # merchant = create(:merchant)
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(3)
  end

  it "can get a single merchant by id" do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}"

    merchant_resp = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant_resp["id"]).to eq(merchant.id)
  end
end