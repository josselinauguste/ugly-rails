class AddProductStock < ActiveRecord::Migration
  def change
    add_column :products, :stock, :integer, default: 0
  end
end
