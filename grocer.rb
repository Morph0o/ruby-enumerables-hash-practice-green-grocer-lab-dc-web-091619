require "pry"
def consolidate_cart(cart)
 final_hash = {}
 cart.each do |e|
     element_name = e.keys[0]
   if final_hash.has_key? (element_name)
     final_hash[element_name] [:count]+= 1
   else
     final_hash[element_name] = {
       count: 1,
       price: e[element_name] [:price],
       clearance: e[element_name] [:clearance]
       } 
   end
 end
 final_hash
 end

def apply_coupons(cart, coupons)
 coupons.each do |coupon|
   item = coupon[:item]
   if cart.has_key?(item) 
     if cart[item][:count] >= coupon[:num]
        cart["#{item} W/COUPON"] = 
        {price: coupon[:cost] / coupon[:num], 
        clearance: cart[item][:clearance],
        count: coupon[:num]}
        cart[item][:count] -= coupon[:num]
   elsif cart[item][:count] >= coupon[:num] && cart.has_key?("#{item} W/COUPON")
   cart["#{item} W/COUPON"][:count] += coupon[:num]
       cart[item][:count] -= coupon[:num]
    end
    end
     #cart[item][:count] -= coupon[:num]
  end 
cart
end

def apply_clearance(cart)
 cart.each do |product_name, stats|
   stats[:price] -= stats[:price] * 0.2  if stats[:clearance]
 end
 cart
end

def checkout(array, coupons)
  hash_cart = consolidate_cart(array)
  applied_coupons = apply_coupons(hash_cart, coupons)
  discounts = apply_clearance(applied_coupons)
  total = discounts.reduce(0) { |acc| (key,value)| acc += value[:price] * value[:count] }
  total > 100 ? total * 0.9 : total
#binding.pry
end
  
 
end