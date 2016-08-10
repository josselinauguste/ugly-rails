class User < ActiveRecord::Base
  has_many :product_carts
  
  def self.current
    User.first
  end
end
