require_relative 'heart_api'
def time_method(method, *args)
  beginning_time = Time.now
  self.send(method, args)
  end_time = Time.now
  puts "Time elapsed #{(end_time - beginning_time)*1000} milliseconds"
end
 
def binary_search(*args)

   @party = HeartApi.new
   
   100000.times{@party.get_cards_by_cost_optimized(20)}

end

def linear_search(*args)

   @party = HeartApi.new
   
   100000.times{@party.get_cards_by_cost(0,20)}

end
 
time_method(:binary_search)
time_method(:linear_search)