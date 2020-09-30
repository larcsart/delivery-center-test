module Api
  class ApplicationController < ActionController::API

    rescue_from RuntimeError, with: :runtime_error
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActionController::ParameterMissing, with: :bad_request
    rescue_from ActionController::BadRequest, with: :bad_request

    private

    def error_to_json(_e)
      JSON.parse(_e.message) rescue nil
    end

    def runtime_error(_e)
      render json: error_to_json(_e), status: :internal_server_error
    end

    def record_not_found(_e)
      render json: error_to_json(_e), status: :not_found
    end

    def bad_request(_e)
      render json: error_to_json(_e), status: :not_found
    end

  end
end
