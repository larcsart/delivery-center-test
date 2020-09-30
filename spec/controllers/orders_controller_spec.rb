require 'rails_helper'

RSpec.describe Api::V1::OrdersController, type: :controller do
  let(:payload)    { JSON.parse(file_fixture('payload.json').read) }
  let(:serialized) { JSON.parse(file_fixture('serialized_payload.json').read) }
  let(:parsed)     { JSON.parse(file_fixture('parsed.json').read) }

  context 'POST /api/v1/orders/create' do
    it 'prepare order data' do
      allow_any_instance_of(OrderExporter).to receive(:export).and_return(true)
      response = post(:create, params: payload)

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq(parsed)
    end
  end

end
