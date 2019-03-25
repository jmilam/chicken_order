class AddPhoneNumberToFarm < ActiveRecord::Migration[5.1]
  def change
    add_column :farms, :phone_number, :string
  end
end
