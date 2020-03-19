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

  it 'can create a new merchant' do
    merchant_params = { name: create(:merchant).name }

    post '/api/v1/merchants', params: {merchant: merchant_params}
    merchant = Merchant.last

    expect(response).to be_successful
    expect(merchant.name).to eq(merchant_params[:name])
  end

  it 'can update a merchant' do
    merchant = create(:merchant)
    og_name = merchant.name
    new_name = create(:merchant).name
    merchant_params = {name: new_name}

    patch "/api/v1/merchants/#{merchant.id}", params: {merchant: merchant_params}
    updated_merchant = Merchant.find(merchant.id)

    expect(response).to be_successful
    expect(updated_merchant.name).to eq(new_name)
    expect(updated_merchant.name).to_not eq(og_name)
  end

  it 'can destroy a merchant' do
    merchant = create(:merchant)

    expect(Merchant.count).to eq(1)

    delete "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful
    expect(Merchant.count).to eq(0)
    expect{(Merchant.find(merchant.id))}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
