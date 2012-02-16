require 'socket'

class HTTP

 class Request
  #But de la classe : reconstituer status, headers, body

  def initialize(sock)
    @socket=sock
  end

  def valid?
   not @socket.nil?
  end

  def lireStatus
   @socket.gets
  end

  def lireHeaders
    headers = {}
    #Boucle de lecture jusqu'à socket.gets=="\r\n" -- PROBLEME
    splitted=@socket.gets.split(': ')
    headers[splitted[0]]=splitted[1]
    headers
  end

 end

 class Response
#Constituer status, headers, body




 end
 
end
