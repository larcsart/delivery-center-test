require 'rails_helper'

RSpec.describe Item, type: :model do
  context 'relationships' do
    it { is_expected.to belong_to :order }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:externalCode) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_presence_of(:total) }
  end
end
