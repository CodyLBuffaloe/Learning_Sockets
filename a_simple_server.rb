require 'socket'
require 'json'

server = TCPServer.open(80)
loop{
  socket = server.accept
  full_request = ""
  while (request = socket.gets) && request.chomp != ''
    full_request << request
  end
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
      body_length = 0
      params = ""
      sub = ""

       split_request.each do |line|
         if(line =~ /Length/)
           body_length = line.delete('^0-9')
         end
       end
       split_request.each do |line|
         if(line.bytesize >= body_length.to_i)
           params = JSON.parse(line)
         end
       end
       params.each_value do |value|
         value.each do |key, value|
           sub << "<li>#{key.to_s}, #{value}</li>"

         end
       end

       post_response = File.readlines("thanks.html")
       post_response.each do |line|
         line.strip!.chomp
         if(line =~ /<%= yield %>/)
           line.gsub!('<%= yield %>', sub)
         end
       end
       socket.print post_response

    else
      socket.print error_page
    end
  end
  socket.close
}
