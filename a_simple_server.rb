require 'socket'

server = TCPServer.open(80)
loop{
  socket = server.accept
  request = ""
  while(request_line = socket.gets and request_line != "\r\n")
    request += request_line
  end
  if(request =~ /GET/)
    socket.print "Inside first IF statement"
      if(request =~ /index/)
        puts "HTTP/1.1 200 OK\r\n" +
             "Content-Type: text/html\r\n" +
             "Content-Length: an amount\r\n" +
             "Connection: close \r\n"
        response = "/index.html"
        socket.print response
      else
        puts "ERROR 404: THE RESOURCE YOU HAVE REQUESTED DOES NOT EXIST"
      end
  end
    puts request.chop
  socket.close
}
