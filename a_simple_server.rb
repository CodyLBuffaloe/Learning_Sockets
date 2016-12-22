require 'socket'

server = TCPServer.open(80)
loop{
  client = server.accept
  puts "Contact!"
  if(/([\w]+)/ =~ "GET")
    puts "It worked!"
  end
  while line = client.gets
    puts line.chop
  end
  client.close
}