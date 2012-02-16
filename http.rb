class HTTP

 class Request
  #But de la classe : reconstituer status, headers, body

  def initialize(sock)
    @socket=sock
  end

  def valid?
   not @socket.nil?
  end

 end

 class Response
#Constituer status, headers, body




 end
 
end
