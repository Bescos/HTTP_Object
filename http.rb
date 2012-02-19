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
    line = @socket.gets
    #boucle de lecture jusqu'à la ligne vide
    while line!="\r\n" do
     #analyse des en-tete avec split. Renvoie tableau à deux éléments.
     splitted=line.split(': ')
     @body_length=splitted[1] if splitted[0] == "Content-Length"
     headers[splitted[0]]=splitted[1]
     line = @socket.gets
    end
    headers
  end

  def lireBody
    @socket.read(Integer(@body_length))
  end
end

 class Response
#Constituer status, headers, body




 end
 
end
