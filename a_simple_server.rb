require 'socket'

server = TCPServer.open(80)
loop{
  socket = server.accept
  while line = socket.gets
    if(line =~ /GET/)
      if(line =~ /index/)
        response = "/index.html"
        socket.print response

        puts "HTTP/1.1 200 OK\r\n" +
             "Content-Type: text/plain\r\n" +
             "Content-Length: an amount\r\n" +
             "Connection: close\r\n"


      else
        puts "ERROR 404: THE RESOURCE YOU HAVE REQUESTED DOES NOT EXIST"
      end
    end
    puts line.chop
  end
  socket.close
}
