class AddFarmToOrder < ActiveRecord::Migration[5.1]
  def change
  	add_column :orders, :farm_id, :integer
  end
end
