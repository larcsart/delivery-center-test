require 'rails_helper'

RSpec.describe MercadoLivre::OrderForm, type: :model do
  let(:payload)    { JSON.parse(file_fixture('payload.json').read) }
  let(:serialized) { JSON.parse(file_fixture('serialized_payload.json').read) }

  let(:flatten_payload)    { hash_deep_flatten(payload) }
  let(:flatten_serialized) { hash_deep_flatten(serialized) }

  subject { described_class.new(payload) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:id) }
    it { is_expected.to validate_presence_of(:store_id) }
    it { is_expected.to validate_presence_of(:total_amount) }
    it { is_expected.to validate_presence_of(:total_shipping) }
    it { is_expected.to validate_presence_of(:total_amount_with_shipping) }
    it { is_expected.to validate_presence_of(:shipping) }
    it { expect(subject).to be_valid }
    it { expect(described_class.new(payload.without('order_items'))).to be_invalid }
    it { expect(described_class.new(payload.without('payments'))).to be_invalid }
    it { expect(described_class.new(payload.without('shipping'))).to be_invalid }
    it { expect(described_class.new(payload.without('buyer'))).to be_invalid }
  end

  describe '.new' do
    it 'setups form' do
      form = subject
      json = subject.as_json

      expect(json).to include('order_items')
      expect(json).to include('payments')
      expect(json).to include('shipping')
      expect(json).to include('buyer')

      flatten_json = hash_deep_flatten(form.as_json)

      expect(flatten_payload).to include(flatten_json)
    end
  end

  describe '#serialize' do
    it 'returns hash like database schema' do
      serialized_json = subject.serialize.as_json
      flatten_serialized_json = hash_deep_flatten(serialized_json)

      expect(flatten_serialized_json).to eq(
        {
          'externalCode'                     => '9987071',
          'storeId'                          => '282',
          'subTotal'                         => '49.9',
          'deliveryFee'                      => '5.14',
          'total'                            => '55.04',
          'dtOrderCreate'                    => '2019-06-24T16:45:32.000-04:00',
          'country'                          => 'BR',
          'state'                            => 'São Paulo',
          'city'                             => 'Cidade de Testes',
          'district'                         => 'Vila de Testes',
          'street'                           => 'Rua Fake de Testes',
          'number'                           => '3454',
          'complement'                       => 'teste',
          'postalCode'                       => '85045020',
          'latitude'                         => '-23.629037',
          'longitude'                        => '-46.712689',
          'customer_attributes.externalCode' => '136226073',
          'customer_attributes.name'         => 'JOHN DOE',
          'customer_attributes.email'        => 'john@doe.com',
          'customer_attributes.contact'      => '41999999999',
          'items_attributes.0.externalCode'  => 'IT4801901403',
          'items_attributes.0.name'          => 'Produto de Testes',
          'items_attributes.0.price'         => '49.9',
          'items_attributes.0.quantity'      => '1',
          'items_attributes.0.total'         => '49.9',
          'payments_attributes.0.type'       => 'credit_card',
          'payments_attributes.0.value'      => '55.04'
        }
      )
    end
  end
end
