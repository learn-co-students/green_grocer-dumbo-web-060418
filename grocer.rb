require "pry"
def consolidate_cart(cart)
  #Translate it into a hash that includes the counts for each item

  #creates new hash where items, clearance and price will be displayed
  new_cart = {}

  #counts number of items in the cart & adds count to cart data
  cart.each do |item|
   item.each do |name, data|
     data[:count] = cart.count(item)
     new_cart[name] = data
    end
  end
   new_cart
end #ends method

def apply_coupons(cart, coupons)

  coupon_hash = {}
  cart.each do |key, value|
    coupon_hash[key] = value.clone
    coupons.each do |coupon|
      if coupon[:item] == key
        coupon_hash[key][:count] = value[:count]%coupon[:num]
        coupon_hash[key + " W/COUPON"] = value.clone
        coupon_hash[key + " W/COUPON"][:count] = value[:count] / coupon[:num]
        coupon_hash[key + " W/COUPON"][:price] = coupon[:cost]
      end
    end
  end
  coupon_hash
end #ends method

def apply_clearance(cart)
  cart.each do |item, info|
      if info[:clearance] == true
        info[:price] = (info[:price] * 0.8).round(1)
      end #ends if
  end #ends cart
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = 0
  cart.each {|item, info| total += (cart[item][:price] * cart[item][:count]) if cart[item][:count] > 0}
    if total > 100
      total = (total*0.9).round(2)
    else
      total
    end #ends if
  total
end #ends method
