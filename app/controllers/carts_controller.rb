class CartsController < ApplicationController
  def show
    @products = User.current.product_carts
  end
  
  def update
    product = Product.find(params['product'])
    if User.current.product_carts.exists?(product_id: product.id)
      product = User.current.product_carts.where(product_id: product.id).first
      product.quantity = product.quantity + 1
      product.save!
    else
      product = User.current.product_carts.build(product_id: product.id, quantity: 1)
      product.save!
    end
    product.product.update_attribute(:stock, product.product.stock - 1)
    if product.product.stock < 10
      Notification.create!(message: "Le stock du produit #{product.product.name} est passé sous le seuil")
    end
    redirect_to :cart
  end
  
  def destroy
    product = Product.find(params['product'])
    if User.current.product_carts.exists?(product_id: product.id)
      product = User.current.product_carts.where(product_id: product.id).first
      if product.quantity > 0
        product.quantity = product.quantity - 1
        if product.quantity == 0
          product.delete
        else
          product.save!
        end
        product.product.update_attribute(:stock, product.product.stock + 1)
      end
    end
    redirect_to :cart
  end
end