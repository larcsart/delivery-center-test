module Api
  module V1
    class OrdersController < Api::ApplicationController

      api :POST, '/v1/orders/create', 'Create Order'

      def create
        export = OrderExporter.process(create_params)
        render json: export.parsed_json, status: :ok
      end

      private

      def create_params
        params.permit!
      end
    end
  end
end
