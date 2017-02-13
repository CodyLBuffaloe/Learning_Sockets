#Making a web fetching client using socket instead of Net::HTTP

require 'socket'
require 'json'

host = 'localhost'
port = 80
request = nil

puts "Would you like to get a page or post something? Type 'g' to GET a page " +
     "and 'p' to POST something."
user_request = gets.chomp
if(user_request == "g")
  path = "/index.html"
  request = "GET #{path} HTTP/1.0\r\n\r\n"
elsif(user_request == "p")
  path = "/thanks.html"
  vikings = {:viking => {:Name => "",
                         :Email => ""}
            }
  puts "You're signing up for a Viking raid! Please provide your name:"
  vikings[:viking][:Name] = gets.chomp
  puts "And your e-mail address:"
  vikings[:viking][:Email] = gets.chomp
  request = "POST #{path} HTTP/1.0\r\n" +
            "From: #{vikings[:viking][:Email]}\r\n" +
            "User-Agent: \r\n" +
            "Content-Type: application/x-www-form-urlencoded\r\n" +
            "Content-Length: #{vikings.to_json.bytesize}\r\n" +
             "#{vikings.to_json}\r\n"+
            "\r\n"
end


socket = TCPSocket.open(host, port)
socket.print(request)
response = socket.read
body = response.split("\r\n", 2)
print body