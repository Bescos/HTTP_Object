require 'socket'

class HTTP

 class Request
  #But de la classe : reconstituer status, headers, body
  attr_reader :status
  attr_reader :headers
  attr_reader :body


  def initialize(sock)
    @socket=sock
    lireStatus
    lireHeaders
    lireBody if @body_length
  end

  def valid?
   not @socket.nil?
  end

  def lireStatus
   @status = @socket.gets
  end

  def lireHeaders
    @headers = {}
    line = @socket.gets
    #boucle de lecture jusqu'à la ligne vide
    while line!="\r\n" do
     #analyse des en-tete avec split. Renvoie tableau à deux éléments.
     splitted=line.split(': ')
     @body_length=splitted[1] if splitted[0] == "Content-Length"
     @headers[splitted[0]]=splitted[1]
     line = @socket.gets
    end
  end

  def lireBody
   @body = @socket.read(Integer(@body_length))
  end
end

 class Response
  #Constituer status, headers, body
  



 end
 
end
