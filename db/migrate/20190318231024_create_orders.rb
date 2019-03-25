class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
    	t.integer :user_id
      t.integer :pickup_location_id
    	t.integer :qty
    	t.boolean :filled, default: false
    	t.boolean :delivered, default: false
      t.timestamps
    end
  end
end
