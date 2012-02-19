#Fichier de test de la classe classy_http_debug_server
$: << File.dirname(__FILE__)

require 'http'


describe HTTP::Request do

  
context "creation of the Request Object" do
  it "should read the request" do
    socket = double (Socket)
    socket.stub(:gets).and_return("GET / HTTP1.1", "Host: localhost:8080", "Content-Length: 26", "User-Agent: Mozilla", "Accept: text.html", "\r\n")
    socket.stub(:read).and_return("Ici le corps de ma requete")
    req = HTTP::Request.new(socket)  
    req.status.should == "GET / HTTP1.1"


    req.headers["User-Agent"].should == "Mozilla"
    req.headers.length.should == 4

    
    req.body.should == "Ici le corps de ma requete"
 end
 
end
end

describe HTTP::Response do




end
