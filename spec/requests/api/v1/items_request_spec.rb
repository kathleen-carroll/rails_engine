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
end
