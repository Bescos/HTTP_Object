#Fichier de test de la classe classy_http_debug_server
$: << File.dirname(__FILE__)

require 'http'

describe HTTP::Request do

context "creation of the request Object with a body" do
  before(:each) do
   socket = double (Socket)
   socket.stub(:gets).and_return("GET /mon_path HTTP/1.1", "Host: localhost:8080", "Content-Length: 26", "User-Agent: Mozilla", "Accept: text.html", "\r\n")
   socket.stub(:read).and_return("Ici le corps de ma requete")
   @req = HTTP::Request.new(socket)  
  end
  it "should read the status of the request" do
    @req.cmd.should == "GET"
    @req.path.should == "/mon_path"
    @req.http_version.should == "HTTP/1.1"
  end
  it "should read the headers of the request" do
    @req.headers["User-Agent"].should == "Mozilla"
    @req.headers.length.should == 4
  end
  it "should read the body of the request" do
    @req.body.should == "Ici le corps de ma requete"
  end
end

context "Creation of the request object without a body"
  before(:each) do
   socket = double (Socket)
   socket.stub(:gets).and_return("GET /mon_path HTTP/1.1", "Host: localhost:8080", "User-Agent: Mozilla", "Accept: text.html", "\r\n")
   @req = HTTP::Request.new(socket)  
  end
  it "should read the status of the request" do
    @req.cmd.should == "GET"
    @req.path.should == "/mon_path"
    @req.http_version.should == "HTTP/1.1"
  end
  it "should read the headers of the request" do
    @req.headers["User-Agent"].should == "Mozilla"
    @req.headers.length.should == 3
  end
  it "should not read the body of the request" do
    @req.body.should be_nil
  end
end


describe HTTP::Response do
context "creation of the Response Object" do
 it "should write the string of a response"
   res = HTTP::Response.new
   res.code = "200"
   res.http_version = "HTTP/1.1"
   res.code_message = "ok"
   res.headers["Content-Length"] = "26"
   res.headers["Content-Type"] = "text/plain"
   res.body = "Ici le corps de ma reponse"
   res.to_s.should == "200 HTTP/1.1 ok\n{\"Content-Length\"=>\"26\", \"Content-Type\"=>\"text/plain\"}\n\r\nIci le corps de ma reponse"

end
end
