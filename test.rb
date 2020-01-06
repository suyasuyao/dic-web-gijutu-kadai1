require 'webrick'

server = WEBrick::HTTPServer.new({
  :DocumentRoot => '.',
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  :Port => '3000',
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}

# この一行を追記
server.mount('/', WEBrick::HTTPServlet::ERBHandler, 'show.html.erb')
server.mount('/indicate.cgi', WEBrick::HTTPServlet::CGIHandler, 'indicate.rb')
server.mount('/test', WEBrick::HTTPServlet::ERBHandler, 'test.html.erb')
server.mount('/goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')
# server.mount('/othergoya.cgi', WEBrick::HTTPServlet::CGIHandler, 'othergoya.rb')
# server.mount('/falsegoya.cgi', WEBrick::HTTPServlet::CGIHandler, 'falsegoya.rb')
server.start