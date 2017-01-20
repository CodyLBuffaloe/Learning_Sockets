#Making a web fetching client using socket instead of Net::HTTP

require 'socket'
require 'json'

puts "Would you like to get a page or post something? Type 'g' to GET a page " +
     "and 'p' to POST something."
user_request = gets.chomp
if(user_request == "g")
  host = 'localhost'
  port = 80
  path = "/index.html"

  request = "GET #{path} HTTP/1.0\r\n\r\n"

  socket = TCPSocket.open(host, port)
  socket.print(request)
  response = socket.read
  body = response.split("\r\n", 2)
  print body
elsif(user_request == "p")
  host = 'localhost'
  port = 80
  path = "/thanks.html"
  vikings = {:viking => {:name => "",
                         :email => ""}
            }
  puts "You're signing up for a Viking raid! Please provide your name:"
  vikings[:viking][:name] = gets.chomp
  puts "And your e-mail address:"
  vikings[:viking][:email] = gets.chomp
  request = "POST /#{path} HTTP/1.0\r\n\r\n" +
            "From: #{vikings[:viking][:email]}\r\n\r\n" +
            "User-Agent: \r\n\r\n" +
            "Content-Type: JSON\r\n\r\n" +
            "Content_Length: #{vikings.to_json.bytesize}\r\n\r\n"
  puts request
end