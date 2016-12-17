require 'socket'

server = TCPServer.open(80)
loop{
  client = server.accept
  
  client.puts(Time.now.ctime)
  client.puts body
  client.close
  }