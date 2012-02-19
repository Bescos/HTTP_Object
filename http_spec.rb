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
    socket.stub(:gets).and_return("Host: localhost:8080", "User-Agent: Mozilla", "Accept: text.html", "\r\n")
    headers = req.lireHeaders
    req.headers["User-Agent"].should == "Mozilla"
    headers.length.should == 3
 end
 
 it "should read the body of the request" do
    socket = double (Socket)
    req = HTTP::Request.new(socket)  
    socket.stub(:gets).and_return("Host: localhost:8080", "User-Agent: Mozilla", "Accept: text.html", "Content-Length: 26", "\r\n")
    headers = req.lireHeaders
    socket.stub(:read).and_return("Ici le corps de ma requete")
    body = req.lireBody
    body.should == "Ici le corps de ma requete"
 end
 
end
end

describe HTTP::Response do





end
