require 'addressable/uri'
require 'rest-client'

url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/users/2/contacts'
).to_s

begin
puts RestClient.get(url)
rescue RestClient::Exception
  "Invalid fields"
end
