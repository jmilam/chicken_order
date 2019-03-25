class CreatePickupLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :pickup_locations do |t|
      t.string :name

      t.timestamps
    end
  end
end
