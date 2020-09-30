class OrderExporter
  attr_accessor :params, :form, :order, :parsed_json, :response

  def self.process(params)
    instance = new(params)
    instance.process
    instance
  end

  def initialize(params)
    @params = params
  end

  def process
    set_form
    set_order
    set_parsed_json
    export
  end

  private

  def set_form
    @form = MercadoLivre::OrderForm.new(params)
    raise bad_request_error(form.errors.messages.to_json) unless form.valid?
  end

  def set_order
    @order = Order.new(form.serialize)
    raise bad_request_error(order.errors.messages.to_json) unless order.valid?
  end

  def set_parsed_json
    @parsed_json = order.as_json(
      except: [:id, :created_at, :updated_at],
      include: {
        customer: { except: [:id, :order_id, :created_at, :updated_at] },
        items:    { except: [:id, :order_id, :created_at, :updated_at] },
        payments: { except: [:id, :order_id, :created_at, :updated_at] },
      }
    )
  end

  def bad_request_error(message)
    ActionController::BadRequest.new(message)
  end


  # Essa parte do código deveria ser implementada em um Driver.
  # Os métodos abaixo estão bem improvisados pois o tempo não foi suficiente.
  # Vale lembrar que a url só responde not found
  def response_body_to_json
    response.body.try(:to_json)
  end

  def export
    @response = HTTParty.post(
      'https://delivery-center-recruitment-ap.herokuapp.com/', {
        headers: { 'X-Sent' => DateTime.now.strftime('%Hh%M - %d/%m/%y') },
        body: parsed_json
      }
    )
    raise RuntimeError, response_body_to_json unless response.code == 200
  end

end

