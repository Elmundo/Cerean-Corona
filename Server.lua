-- Server Class - BaseClass
local network = require("network")
local json    = require("json")
local mime    = require("mime")

-- Parameters for network config

local params = {
	headers = {
		["Content-Type"]    = "application/x-www-form-urlencoded",
		["Accept-Language"] = "us-EN",
		["Accept-Charset"]  = "utf-8",
		["Accept"]          = "application/json", 
	},
	body = nil,
	bodyType = "text",
	handleRedirects = true,
}
-- Server Module
local Server = {
	baseURL = "http://cerean.ogoodigital.com/Services/MobileService.ashx/?",
	params  = params,
}

function printTableRecursive( t )
	for k,v in pairs(t) do
		if (type(v) == "table") then
			print(k .. " = {")
			printTableRecursive(v)
			print( "}" )
		else
			print(k,v)	
		end
		
	end
end

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
	

	self:completeRequest(baseRequest)

	self:request()

end

function Server:completeRequest( params )
	local jsonFormat = json.encode( params )
	local completedData = "d=" .. jsonFormat
	self.params.body = completedData
end

local function myCallback( event )
	
	print( "[[ -- RESPONSE DATAS -- ]]" )
	print( "Name: ".. event.name )
	print( "Phase: ".. event.phase )
	print( event.requestId )
	print( "Status: ".. event.status )
	print( "URL: ".. event.url )

	

	local responseData = json.decode( event.response )
	responseData = responseData.results[1].res
	printTableRecursive(responseData )


	print( "ResponseType: ".. event.responseType )
	if (event.isError) then
		print( "Response: ".. event.response )
	end

	print( event.response )
	if (event.phase == "began") then
	
	elseif (event.phase == "progress") then
		
	elseif (event.phase == "ended") then
	
	else
		error( "Invalid Messages")
	end
end

function Server:request(  )		

	printTableRecursive(self.params)

	network.request( "http://cerean.ogoodigital.com/Services/MobileService.ashx/", "POST", myCallback, self.params)
end

return Server


