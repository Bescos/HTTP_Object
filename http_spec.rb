#Fichier de test de la classe classy_http_debug_server
$: << File.dirname(__FILE__)

require 'http'


describe HTTP::Request do

context "creation of the Request Object" do
  it "should create req.sock" do
    socket = double (Socket)
    req = HTTP::Request.new(socket)    
    req.valid?.should be_true
  end

 it "should read the status of the request" do
    socket = double (Socket)
    req = HTTP::Request.new(socket) 
    socket.stub(:gets){"GET / HTTP1.1"}
    socket.should_receive(:gets).with().and_return("GET / HTTP1.1")
    status = req.lireStatus
 end

 it "should read the headers of the request" do
    socket = double (Socket)
    req = HTTP::Request.new(socket) 
    #Y-a-t'il une méthode pour rendre le stub dynamique ?
    #Afin que je puisse simuler le comportement d'un socket avec plusieurs lignes 
    socket.stub(:gets){"Content-Length: 230"}
    headers = req.lireHeaders
    headers["Content-Length"].should == "230"
 end
 
end
end

describe HTTP::Response do





end
