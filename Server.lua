-- Server Class - BaseClass
local network = require("network")
local json    = require("json")
local mime    = require("mime")
local Utils   = require("Utils") 
local Logger  = require "Logger"

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

-- Property List
	baseURL = "http://cerean.ogoodigital.com/Services/MobileService.ashx/",
	params  = params,
}

-- Base Class
-- Static function
function Server.new()
	local newServer = {

		baseURL = Server.baseURL, 
		params  = Server.params,

		setProperties    = Server.setProperties,
		request          = Server.request,
	}
	return newServer
end

-- Override this method
function Server:setProperties( _params )
	self.baseURL = _params.baseURL or self.baseURL
	self.params  = _params.params or self.params
end

function Server:request( params, callback, requestType )

	self.params.body = params
	requestType = requestType or "POST"

	network.request( self.baseURL, requestType, 
					
					function ( event )
						if (event.phase == "ended") then

							local responseData = json.decode( event.response )
							responseData = responseData.results[1].res

							callback(responseData) -- Call the related callback function
						end
					end, 
	
					self.params
					)
end

return Server


