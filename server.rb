$: << File.dirname(__FILE__)

require 'socket'
require 'http.rb'

port = 8080
server = TCPServer.open(port)
process_number = 1

class String
  def self.random(size=20)
    set = [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten
    (1..size).map{ set[rand(set.length)] }.join
  end
end

def generate_cookie
  require 'digest/md5'
    Digest::MD5.hexdigest("cooooookiiiie"+String.random)
end

trap('EXIT'){ server.close }
process_number.times do
  fork do
    trap('INT'){ exit }
    request_number = 0
    sessions = {}
    loop do
      socket = server.accept

      puts "request No #{request_number += 1}"

      req = HTTP::Request.new(socket)
      res = HTTP::Response.new

      #Check if cookie exists
      if sessions.keys.include?(req.headers["Cookie"])
        puts("Il y a deja un cookie")
        userCookie = req.headers["Cookie"]
        #incrémentation du nombre de visites du client
        sessions[userCookie]["nb_visits"]=sessions[userCookie]["nb_visits"]+1
        puts("Nombre de visites : #{sessions[userCookie]["nb_visits"]}")

      else
        puts("pas de cookie")
        userCookie = generate_cookie()
        sessions[userCookie]= {}
        sessions[userCookie]["nb_visits"]=1
      end
      
      # response
      res.code = "200"
      res.code_message = "ok"
      res.headers["Set-Cookie"] =  userCookie
      response_body = [req.status, req.headers.inspect, req.body].join("\n")
      res.body = response_body 
      res.headers["Content-Length"] = res.body.length
      socket.write res.to_s
      
      socket.close
    end
  end
end

trap('INT') { puts "\nexiting" ; exit }

# Sit back and wait for all child processes to exit.
Process.waitall

