class Api::V1::Items::FindController < ApplicationController
  def show
    # attribute = params.keys.first.downcase
    # value = params[attribute]

    match = search_params.to_hash.reduce({}) do |match, (attribute, value)|
        matches = Item.where("upper(#{attribute}) like ?", "%#{value.upcase}%")
        match[attribute] = matches
        match
    end

    if match.values.length > 1
      filtered = match.values[0].find_all {|item| match.values[1].include?(item)}
      render json: ItemSerializer.new(filtered.first)
    else
      render json: ItemSerializer.new(match.values.flatten.first)
    end

    # if attribute == 'name'
    #   # require "pry"; binding.pry
    #   matches = Item.where("upper(#{attribute}) like ?", "%#{value.upcase}%")
    #   render json: ItemSerializer.new(matches.first)
    # else
    #   # require "pry"; binding.pry
    #   DateTime.parse(value)
    #   matches = Item.where("#{attribute} like ?", "%#{DateTime.parse(value)}%")
    #   render json: ItemSerializer.new(matches)
    # end
  end

  def show_all
    attribute = params.keys.first.downcase
    value = params[attribute]

    if attribute == 'name'
      matches = Item.where("upper(#{attribute}) like ?", "%#{value.upcase}%")
      render json: ItemSerializer.new(matches)
    else
      # require "pry"; binding.pry
      DateTime.parse(value)
      matches = Item.where("#{attribute} like ?", "%#{DateTime.parse(value)}%")
      render json: ItemSerializer.new(matches)
    end
  end

  private

  def search_params
    params.permit(:name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
