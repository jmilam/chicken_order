class CreateFarms < ActiveRecord::Migration[5.1]
  def change
    create_table :farms do |t|
    	t.string :name
    	t.string :address
    	t.string :city
    	t.string :state
    	t.string :zipcode
    	t.string :unique_key
    	t.integer :total_eggs, default: 0
      t.timestamps
    end
  end
end
