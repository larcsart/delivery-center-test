require 'rails_helper'

RSpec.describe Store, type: :model do

  let(:params) {{
    name: 'Test Store',
    social_name: 'Test Store Lmtd',
    text_address: 'Rua do Manifesto 2470, Ipiranga São Paulo - SP'
  }}

  context 'relationships' do
    it { is_expected.to have_many :stock_items }
    it { is_expected.to have_many :products }
  end

  context 'validations:' do
    it 'valid store' do
      save = Store.new(params).save
      expect(save).to eq(true)
    end
    it 'ensures name presence' do
      save = Store.new(params.without(:name)).save
      expect(save).to eq(false)
    end
    it 'ensures social_name presence' do
      save = Store.new(params.without(:social_name)).save
      expect(save).to eq(false)
    end
    it 'ensures text_address presence' do
      save = Store.new(params.without(:text_address)).save
      expect(save).to eq(false)
    end
  end

end
