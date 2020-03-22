require 'rails_helper'

RSpec.describe 'Item Find Api' do
  it 'find item by name' do
    item = create(:item, name: "Chambray")
    item2 = create(:item, name: "Ray of Sunshine")
    item3 = create(:item, name: "Nope")
    value = "ray"
    attribute = 'name'

    get "/api/v1/items/find?#{attribute}=#{value}"

    expect(response).to be_successful

    item_response = JSON.parse(response.body)

    expect(item_response["data"]['attributes']['name']).to eq(item.name)
  end

  xit 'find item by created_at' do
    item = create(:item, name: "Chambray")
    # require "pry"; binding.pry
    item.created_at.strftime('%Y-%m-%d')
    value = Date.today.strftime('%Y-%m-%d')
    attribute = 'created_at'

    get "/api/v1/items/find?#{attribute}=#{value}"

    expect(response).to be_successful

    item_response = JSON.parse(response.body)

    expect(item_response["data"].first['attributes']['date']).to eq(item.created_at)
  end

  it 'find items by name' do
    item = create(:item, name: "Chambray")
    item2 = create(:item, name: "Ray of Sunshine")
    item3 = create(:item, name: "Nope")
    value = "ray"
    attribute = 'name'

    get "/api/v1/items/find_all?#{attribute}=#{value}"

    expect(response).to be_successful

    item_response = JSON.parse(response.body)

    expect(item_response["data"].first['attributes']['name']).to eq(item.name)
    expect(item_response["data"].last['attributes']['name']).to eq(item2.name)
  end
end
