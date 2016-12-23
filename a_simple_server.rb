require 'socket'

server = TCPServer.open(80)
loop{
  client = server.accept
  puts "Contact!"
  while line = client.gets
    if(line =~ /GET/)
      puts "It worked!"
    end
    puts line.chop
  end
  client.close
}