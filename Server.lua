-- Server Class - BaseClass
local network = require("network")
local json    = require("json")
local mime    = require("mime")
local Utils   = require("Utils") 

-- Parameters for network config
local params = {
	headers = {
		["Content-Type"]    = "application/x-www-form-urlencoded",
		["Accept-Language"] = "tr-TR",
		["Accept-Charset"]  = "utf-8",
		["Accept"]          = "application/json", 
	},
	body = nil,
	bodyType = "text",
	handleRedirects = true,
}
-- Server Module
local Server = {
	baseURL = "http://cerean.ogoodigital.com/Services/MobileService.ashx/",
	params  = params,
}

function Server:login( username, password)
	local baseRequest =   {
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
	
	self:request(self:completeRequest(baseRequest), "POST")

end

function Server:completeRequest( params )
	local jsonFormat = json.encode( params )
	local completedData = "d=" .. jsonFormat
	return completedData
end

local function onRequestSuccess( event )
	print( "[[ -- RESPONSE DATAS -- ]]" )
	print( "Name: ".. event.name )
	print( "Phase: ".. event.phase )
	print( event.requestId )
	print( "Status: ".. event.status )
	print( "URL: ".. event.url )

	print( event.response )
	local responseData = json.decode( event.response )
	responseData = responseData.results[1].res

	print( "ResponseType: ".. event.responseType )
	if (event.isError) then
		print( "Response: ".. event.response )

	end

	if (event.phase == "began") then
	
	elseif (event.phase == "progress") then
		
	elseif (event.phase == "ended") then
	
	else
		error( "Invalid Messages")
	end
end

function Server:request( params, requestType )

	self.params.body = params
	requestType = requestType or "POST"

	network.request( self.baseURL, requestType, onRequestSuccess, self.params)
end

return Server


