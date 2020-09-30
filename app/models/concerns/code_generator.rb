module CodeGenerator
  extend ActiveSupport::Concern

  CODE_LENGTH  = 9
  CODE_LETTERS = true
  CODE_PREFIX  = 'N'

  included do
    before_validation :generate_code, on: :create
    validates :code, presence: true, uniqueness: true
  end

  def self.by_code(code)
    where(code: code)
  end

  def generate_code(options = {})
    options[:length]  = (self.code_length rescue CODE_LENGTH)
    options[:letters] = (self.code_letters rescue CODE_LETTERS)
    options[:prefix]  = (self.code_prefix rescue CODE_PREFIX)
    possible = (0..9).to_a
    possible += ('A'..'Z').to_a if options[:letters]
    self.code ||= loop do
      random = "#{options[:prefix]}#{(0...options[:length]).map { possible.shuffle.first }.join}"
      if self.class.exists?(code: random)
        options[:length] += 1 if self.class.count > (10 ** options[:length] / 2)
      else
        break random
      end
    end
  end

end