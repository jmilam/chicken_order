class AddChickenCountToFarm < ActiveRecord::Migration[5.1]
  def change
  	add_column :farms, :chicken_count, :integer, default: 0
  end
end
