class AddCancelToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :cancelled, :boolean, default: false
  end
end
