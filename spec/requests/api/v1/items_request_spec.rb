require 'rails_helper'

RSpec.describe 'Items Api' do
  it 'sends a list of items' do
    num = 3
    create_list(:item, num)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(num)
  end

  it 'can see one item' do
    item = create(:item)

    get "/api/v1/items/#{item.id}"

    item_response = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item_response["data"]["id"].to_i).to eq(item.id)
  end

  it 'can create a new item' do
    new_item = create(:item)
    item_params = { name: new_item.name,
                    description: new_item.description,
                    unit_price: new_item.unit_price,
                    merchant_id: new_item.merchant.id}

    post '/api/v1/items', params: {item: item_params}
    item = Item.last

    expect(response).to be_successful
    expect(item.name).to eq(item_params[:name])
  end

  it 'can update a item' do
    item = create(:item)
    og_name = item.name
    new_name = create(:item).name
    item_params = {name: new_name}

    patch "/api/v1/items/#{item.id}", params: {item: item_params}
    updated_item = Item.find(item.id)

    expect(response).to be_successful
    expect(updated_item.name).to eq(new_name)
    expect(updated_item.name).to_not eq(og_name)
  end

  it 'can destroy a item' do
    item = create(:item)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{(Item.find(item.id))}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
