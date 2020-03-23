class Api::V1::Merchants::FindController < ApplicationController
  def show
    attribute = params.keys.first.downcase
    value = params[attribute]

    if attribute == 'name'
      # require "pry"; binding.pry
      matches = Merchant.where("upper(#{attribute}) like ?", "%#{value.upcase}%")
      render json: MerchantSerializer.new(matches.first)
    else
      # require "pry"; binding.pry
      DateTime.parse(value)
      matches = Merchant.where("#{attribute} like ?", "%#{DateTime.parse(value)}%")
      render json: MerchantSerializer.new(matches)
    end
  end

  def show_all
    attribute = params.keys.first.downcase
    value = params[attribute]

    if attribute == 'name'
      matches = Merchant.where("upper(#{attribute}) like ?", "%#{value.upcase}%")
      render json: MerchantSerializer.new(matches)
    else
      # require "pry"; binding.pry
      DateTime.parse(value)
      matches = Merchant.where("#{attribute} like ?", "%#{DateTime.parse(value)}%")
      render json: MerchantSerializer.new(matches)
    end
  end
end
