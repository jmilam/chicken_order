require 'rails_helper'

RSpec.describe 'OrderShowPage', js: true do
  let!(:order) { create(:order) }
  before do
    visit order_show_path
  end

  context 'fill order' do
    it 'successfully' do
      find('.filled').click

      visit order_show_path
      expect(find('.filled[checked=checked]'))
    end
  end

  context 'deliver order' do
    it 'successfully' do
      find('.delivered').click

      visit order_show_path
      expect(find('.delivered[checked=checked]'))
    end
  end
end
