def consolidate_cart(cart)
  consolidate = {}
  cart.each do |item_hash|
    item_hash.each do |food, details|
      consolidate[food] = details
      consolidate[food][:count] ||= 0 
      consolidate[food][:count] +=1
      end
    end
  consolidate
 end
 
 def apply_coupons(cart, coupons)

  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart.include?("#{name} W/COUPON")
        cart["#{name} W/COUPON"][:count] += 1
      else 
        cart["#{name} W/COUPON"] = {:price => coupon[:cost], :clearance => cart[name][:clearance], :count => 1}
      end
      rest = cart[name][:count] - coupon[:num]
      cart[name][:count] = rest
    end
  end
  cart
end
 
def apply_clearance(cart)

  cart.each do |item, traits| 
    if cart[item][:clearance] == true 
      discount = cart[item][:price] * 0.80
      cart[item][:price] = discount.round(2)
    end
  end
  cart 
end
 
def checkout(cart, coupons)

total = 0
  consolidated_cart = consolidate_cart(cart)
  applied_coupons_cart = apply_coupons(consolidated_cart, coupons)
  applied_clearance_cart = apply_clearance(applied_coupons_cart)
  
  applied_clearance_cart.each do |item, traits|
  total += traits[:price] * traits[:count]
  end
  if total > 100
    total = total * 0.90
  end
  total
end
