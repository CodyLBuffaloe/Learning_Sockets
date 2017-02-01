require 'socket'
require 'json'

server = TCPServer.open(80)
loop{
  socket = server.accept
  http_request = []
  puts "Heading into while loop"
  while (request = socket.gets) && request.chomp != ''
    http_request << request
  end
  puts http_request
  puts "Out of while loop, transmission of request over"
  if(request =~ /GET/)
      if(request =~ /index/)
      puts request
        webpage = File.readlines("index.html")
        characters = webpage.join.length
        puts "HTTP/1.1 200 OK\r\n" +
             "Content-Type: text/html\r\n" +
             "Content-Length: #{characters}\r\n" +
             "Connection: close \r\n"
        webpage.each do |line|
          socket.print line
        end
      else
        error_page = "404 ERROR \r\n" +
                     "The file you are looking for doesn't exist! :("
        puts "HTTP/1.1 404 Not Found\r\n" +
             "Content-Type: text/html\r\n" +
             "Content-Length: #{error_page.length}\r\n"+
             "Connection: close \r\n"
        socket.print  error_page
      end
  elsif(request =~ /POST/)
    if(request =~ /thanks/)
      puts request
    else
      socket.print error_page
    end

  end
  socket.close
}
