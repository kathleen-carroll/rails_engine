class Api::V1::Items::FindController < ApplicationController
  def show
    attribute = params.keys.first.downcase
    value = params[attribute]

    if attribute == 'name'
      # require "pry"; binding.pry
      matches = Item.where("upper(#{attribute}) like ?", "%#{value.upcase}%")
      render json: ItemSerializer.new(matches.first)
    else
      # require "pry"; binding.pry
      DateTime.parse(value)
      matches = Item.where("#{attribute} like ?", "%#{DateTime.parse(value)}%")
      render json: ItemSerializer.new(matches)
    end
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
end
