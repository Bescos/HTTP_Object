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


end
end

describe HTTP::Response do





end
