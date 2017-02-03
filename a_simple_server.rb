require 'socket'
require 'json'

server = TCPServer.open(80)
loop{
  socket = server.accept
  full_request = ""
  puts "Before while loop"
  while (request = socket.gets) && request.chomp != ''
    full_request << request
  end
  puts "After while loop"
  if(full_request =~ /GET/)
      if(full_request =~ /index/)

        webpage = File.readlines("index.html")
        characters = webpage.join.length
        puts "HTTP/1.1 200 OK\r\n" +
             "Content-Type: text/html\r\n" +
             "Content-Length: #{characters}\r\n" +
             "Connection: close \r\n"
        webpage.each do |line|
          socket.print line
        end
      else
        error_page = "404 ERROR \r\n" +
                     "The file you are looking for doesn't exist! :("
        puts "HTTP/1.1 404 Not Found\r\n" +
             "Content-Type: text/html\r\n" +
             "Content-Length: #{error_page.length}\r\n"+
             "Connection: close \r\n"
        socket.print  error_page
      end
  elsif(full_request =~ /POST/)
    if(full_request =~ /thanks/)
      split_request = full_request.split("\r\n")
       split_request.each do |line|
         if(line =~ /Length/)
           body_length = line.delete('^0-9')
           puts body_length
         end
       end
    else
      socket.print error_page
    end
  end
  socket.close
}
