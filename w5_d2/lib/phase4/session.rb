require 'json'
require 'webrick'
require 'byebug'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      @req = req
      @cook = {}
      @req.cookies.each do |cookie|
        if cookie.name == "_rails_lite_app"
          @cook = JSON.parse(cookie.value)
        end
      end
    end

    def [](key)
      @cook[key]
    end

    def []=(key, val)
      @cook[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      cookie = WEBrick::Cookie.new('_rails_lite_app', @cook.to_json)
      res.cookies << cookie
    end
  end
end

# JSON.generate(@cook)
