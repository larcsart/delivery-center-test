require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:serialized) { JSON.parse(file_fixture('serialized_payload.json').read) }
  let(:flatten_serialized) { hash_deep_flatten(serialized) }

  subject { described_class.new(serialized) }

  context 'relationships' do
    it { is_expected.to have_one :customer }
    it { is_expected.to have_many :items }
    it { is_expected.to have_many :payments }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:externalCode) }
    it { is_expected.to validate_presence_of(:storeId) }
    it { is_expected.to validate_presence_of(:subTotal) }
    it { is_expected.to validate_presence_of(:deliveryFee) }
    it { is_expected.to validate_presence_of(:dtOrderCreate) }
    it { is_expected.to validate_presence_of(:total) }
    it { is_expected.to validate_presence_of(:country) }
    it { is_expected.to validate_presence_of(:state) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:district) }
    it { is_expected.to validate_presence_of(:street) }
    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_presence_of(:complement) }
    it { is_expected.to validate_presence_of(:postalCode) }
    it { is_expected.to validate_presence_of(:latitude) }
    it { is_expected.to validate_presence_of(:longitude) }
  end

  context '.new' do
    it 'valid order' do
      expect(subject).to be_valid
      a = subject
      a.save
      a.reload
      pp a.as_json
      pp a.dtOrderCreate.iso8601(3)
    end
  end
end
