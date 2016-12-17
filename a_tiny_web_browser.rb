#Making a web fetching client using socket instead of Net::HTTP

require 'socket'

host = 'www.neopets.com'
port = 80
path = "/index.phtml"

request = "GET #{path} HTTP/1.0\r\n\r\n"

socket = TCPSocket.open(host, port)
socket.print(request)
response = socket.read
headers, body = response.split("\r\n\r\n", 2)
print body