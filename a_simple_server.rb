require 'socket'

server = TCPServer.open(80)
loop{
  client = server.accept
  while line = client.gets
    if(line =~ /GET/)
      if(line =~ /index/)
        puts "HTTP/1.1 200 OK"

      else
        puts "ERROR 404: THE RESOURCE YOU HAVE REQUESTED DOES NOT EXIST"
      end
    end
    puts line.chop
  end
  client.close
}