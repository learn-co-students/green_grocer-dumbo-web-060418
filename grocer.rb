require "pry"

def consolidate_cart(cart)
consolidatedCart = {}
checkKeys = []
cart.each do |array|
checkKeys << array.keys.join("")
  array.each do |name, hash|
    hash[:count] = 0
    consolidatedCart[name] ||= hash
    number = checkKeys.count(name)
    consolidatedCart[name][:count] = number
    end
end
consolidatedCart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
        cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
      end
      cart[name][:count] -= coupon[:num]
    end
  end
  cart
end


def apply_clearance(cart)
cart.each do |item, hash|
if hash[:clearance]
total = hash[:count] * hash[:price]
discountedPrice = total * 0.8
hash[:price] = discountedPrice.round(3)
end
end
end

def checkout(cart, coupons)
total = 0
coupons_applied_cart = apply_coupons(consolidate_cart(cart), coupons)
clearanced_items = apply_clearance(coupons_applied_cart)
clearanced_items.each do |item, hash|
total += hash[:price] * hash[:count]
end
if total > 100
total = total * 0.90
end
total
end
