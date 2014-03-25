-- Server Class - BaseClass
local network = require("network")
local json = require("json")

local Server = {
	baseURL = "http://cerean.ogoodigital.com/Services/MobileService.ashx/?",
	requestSerializationType = "URLEncoded",
	acceptHeaderType = "json",
	requestType="POST",
}

function Server:request( dictionary )		
	request( self.baseURL, "POST", listener [, params] )
end

function Server:onCallback( event )
	-- body
end


