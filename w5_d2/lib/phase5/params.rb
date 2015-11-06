require 'uri'
require 'byebug'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      @params = {}
      parse_www_encoded_form(req.query_string) unless req.query_string.nil?
      parse_www_encoded_form(req.body) unless req.body.nil?
    end

    def [](key)
      @params[key.to_s]
    end

    # this will be useful if we want to `puts params` in the server log
    # def to_s
    #   @params.to_s
    # end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      current = @params
      str = URI::decode_www_form(www_encoded_form)
      str.each_with_index do |arr, i|
        arr.map!.with_index do |el, j|
          if j.even?
            parse_key(el)
          else
            parse_key(el)
          end
        end
      end
      # final.each_with_index do |arr, i|
      #   arr[0...-1].each_with_index do |element, j|
      #     current[element] ||= {}
      #     current = current[element]
      #   end
      #   if i.even?
      #     current[arr.last] = final[i+1].first
      #   end
      # end
      # current
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end
  end
end
