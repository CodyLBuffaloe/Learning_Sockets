#Making a web fetching client using socket instead of Net::HTTP

require 'socket'

puts "Would you like to get a page or post something? Type 'g' to GET a page " +
     "and 'p' to POST something."
user_request = gets.chomp
if(user_request = "g")
  host = 'localhost'
  port = 80
  path = "/index.html"

  request = "GET #{path} HTTP/1.0\r\n\r\n"

  socket = TCPSocket.open(host, port)
  socket.print(request)
  response = socket.read
  body = response.split("\r\n", 2)
  print body
elsif(user_request = "p")
  puts "You're signing up for a Viking raid! Please provide your name:"
  name = gets.chomp
  puts "And your e-mail address:"
  e-mail = gets.chomp
  

end