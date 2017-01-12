require 'socket'

server = TCPServer.open(80)
loop{
  socket = server.accept
  request = ""
  while(request_line = socket.gets and request_line != "\r\n")
    request += request_line
  end
  if(request =~ /GET/)
      if(request =~ /index/)
        webpage = File.readlines("index.html")
        puts "HTTP/1.1 200 OK\r\n" +
             "Content-Type: text/html\r\n" +
             "Content-Length: some size\r\n" +
             "Connection: close \r\n"
        webpage.each do |line|
          socket.print line
        end
      else
        puts "ERROR 404: THE RESOURCE YOU HAVE REQUESTED DOES NOT EXIST"
        socket.print "404 ERROR \r\n" +
                     "The file you are looking for doesn't exist! :("
      end
  end
    puts request.chop
  socket.close
}
