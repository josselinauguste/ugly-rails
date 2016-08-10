class CreateProductCarts < ActiveRecord::Migration
  def change
    create_table :product_carts do |t|
      t.references :product, null: false
      t.references :user, null: false
      t.integer :quantity, default: 0

      t.timestamps null: false
    end
  end
end
