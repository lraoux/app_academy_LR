require 'webrick'

# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPRequest.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPResponse.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/Cookie.html

server = WEBrick::HTTPServer.new(:Port => 3000)
#how to type in i/love/app/academy without the ?=
server.mount_proc("/") do |request, response|
  response.content_type = "text/text"
  a = request.query["name"]
  response.body = "#{a}"
end

trap('INT') do
  server.shutdown
end

server.start
