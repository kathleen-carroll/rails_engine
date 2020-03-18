class Transaction < ApplicationRecord
  validates_presence_of :credit_card_number, :result
  # validate_presence_of :credit_card_expiration_date, :optional
  belongs_to :invoice
end
