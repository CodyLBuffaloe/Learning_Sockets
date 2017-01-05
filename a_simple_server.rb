require 'socket'

server = TCPServer.open(80)
loop{
  client = server.accept
  puts "Contact!"
  while line = client.gets
    if(line =~ /GET/)
      if(line =~ /index/)
        puts "It worked!"
      else
        puts "ERROR 404: THE RESOURCE YOU HAVE REQUESTED DOES NOT EXIST"
      end
    end
    puts line.chop
  end
  client.close
}