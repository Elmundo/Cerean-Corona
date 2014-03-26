-- Server Class - BaseClass
local network = require("network")
local json = require("json")

-- Server Module
local Server = {
	baseURL                  = "http://cerean.ogoodigital.com/Services/MobileService.ashx/?",
	requestSerializationType = "URLEncoded",
	acceptHeaderType         = "json",
	requestType              = "POST",
}

function Server:login( username, password)
	local baseRequest = {
		bsqn = "5",
		reqs = {
				    {
					sqn = "1",
					svc = "clientsvc",
					params = {username, password},
					method = "login",
	                },	
				},

	}

	print( "BaseRequest = ")
	for k,v in pairs(baseRequest) do
		print(k,v)
	end

	local completedRequest = self:completeRequest(baseRequest)

	print( "CompletedRequest = " )
	print( "BaseRequest = ")

end

function Server:completeRequest( params )
	
	local completedRequest = { d = params}

	return completeRequest
end

function Server:request( dictionary )		
	--request( self.baseURL, "POST", listener [, params] )
end

--[[
function Server:onCallback( event )
	if (event.phase == "began") then
	
	else if (event.phase == "progress") then
		
	else if (event.phase == "ended") then
		
	end
end
--]]
return Server


