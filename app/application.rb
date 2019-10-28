require 'pry'
class Application
  @@cart = []
  @@items = ["Apples","Carrots","Pears"]

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
    elsif req.path.match(/add/)
      searcher = req.params["item"]
      # binding.pry
      if (@@items.include?(searcher))
        @@cart << searcher
        resp.write "added #{searcher}"
      else
        resp.write "We don't have that item"
      end
    elsif req.path.match(/cart/)
      if @@cart.length >= 1
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      else
        resp.write "Your cart is empty"
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
end
