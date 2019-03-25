require 'rails_helper'

# rubocop:disable Metrics/LineLength
def order_successful_string
  "#{farm.name} currently has #{farm.total_eggs} dozen available for purchase. Cost per dozen: $#{farm.egg_cost.to_i} * You can order more then is avaialble. We will fill it first come first serve."
end
# rubocop:enable Metrics/LineLength

RSpec.describe 'OrderPage', js: true do
  before do
    visit order_index_path
  end

  context 'Order Page Details' do
    let!(:farm) { create(:farm) }
    let!(:pickup_location) { create(:pickup_location) }

    it 'displays order form' do
      expect(page).to have_content('Enter A New Order')
    end

    context 'submit order' do
      before do
        visit order_index_path
        select farm.name, from: 'order_farm_id'
        sleep 3
        expect(find('#farm_order_availability').text).to eq order_successful_string
        select pickup_location.name, from: 'order_pickup_location_id'
        fill_in 'order_first_name', with: 'Chip'
        fill_in 'order_last_name', with: 'Rooster'
      end

      it 'successfully' do
        fill_in 'order_phone_number', with: '0000000000'
        fill_in 'order_qty', with: '1'
        click_on 'Place Order'

        expect(page).to have_content('Your order has been placed. You will hear from us soon.')
      end

      context 'fails validation' do
        it 'is missing phone number' do
          click_on 'Place Order'

          expect(page).to have_content('phone_number can\'t be blank')
        end

        it 'is missing order qty' do
          fill_in 'order_phone_number', with: '0000000000'
          click_on 'Place Order'

          expect(page).to have_content('orders is invalid')
        end
      end
    end
  end

  context 'View Previous Orders' do
    context 'user enters phone number' do
      let(:order) { create(:order) }
      it 'does not have any orders' do
        fill_in 'past_orders_phone_number', with: '1234567890'
        click_on 'Find Orders'
        expect(all('tbody tr').count).to eq(1)
      end

      context 'has orders' do
        before do
          fill_in 'past_orders_phone_number', with: order.user.phone_number
          click_on 'Find Orders'
          expect(all('tbody tr').count).to eq(2)
        end

        after do
          total_data = find('tbody tr.table-success').all('td')
          expect(total_data[1].text).to eq(order.qty.to_s)
          expect(total_data[2].text).to eq("$#{order.cost}")
        end

        it 'has user info' do
          columns = first('tbody tr').all('td')
          expect(first('tbody tr').find('th').text).to eq(order.id.to_s)
          expect(columns[0].text).to eq("#{order.user.first_name} #{order.user.last_name}")
          expect(columns[1].text).to eq(order.user.phone_number)
          expect(columns[2].text).to eq(order.qty.to_s)
          expect(columns[3].text).to eq("$#{order.cost}")
        end
      end

      context 'cancel order' do
        before do
          fill_in 'past_orders_phone_number', with: order.user.phone_number
          click_on 'Find Orders'
          expect(all('tbody tr').count).to eq(2)
        end

        it 'successfully' do
          click_link 'Cancel'
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content('Your order has been cancelled.')
        end
      end

      context 'view order' do
      end
    end
  end
end
