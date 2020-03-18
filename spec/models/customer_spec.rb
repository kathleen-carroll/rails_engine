require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'validations' do
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :first_name }
  end

  describe 'relationships' do
    it {should have_many(:invoices)}
    # it {should have_many(:invoice_items)}
    # it {should have_many(:items).through(:invoice_items)}
  end
end
