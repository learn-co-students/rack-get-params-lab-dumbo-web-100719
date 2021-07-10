class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
       if @@cart.length == 0
          resp.write "Your cart is empty"
        else 
          @@cart.each do |cart|
          resp.write "#{cart}\n"
        end
      end
    elsif req.path.match(/add/)
      cart_search = req.params["item"]
        if @@items.include? cart_search
            @@cart << cart_search
            resp.write "added #{cart_search}"
        else
          resp.write "We don't have that item"
          # resp.write "Path Not Found"
        end
      else
        resp.write "Path Not Found"
    end
      resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  # get "/cart" do
  #   if @@cart.length == 0
  #     resp.write "Your cart is empty"
  #   end
  #   resp.finish
  # end



end
