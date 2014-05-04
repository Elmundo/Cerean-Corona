-- Server Class - BaseClass
local network = require("network")
local json    = require("json")
local mime    = require("mime")
local Utils   = require("libs.Util.Utils") 
local Logger  = require "libs.Log.Logger"
local native  = require "native"
local storyboard = require "storyboard"

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
	requestID = 0,
}

-- Base Class
-- Static function
function Server.new()
	local newServer = {

		baseURL   = Server.baseURL, 
		params    = Server.params,
		requestID = Server.requestID,

		setProperties    = Server.setProperties,
		request          = Server.request,
		logRequest       = Server.logRequest,
		logResponse      = Server.logResponse,
	}
	return newServer
end

-- Override this method
function Server:setProperties( _params )
	self.baseURL = _params.baseURL or self.baseURL
	self.params  = _params.params or self.params
end

function Server:logRequest( params, requestID )

	print( "------------------------------------------------------------------------------------------------------------------------------------------------------------" )
	print( "----------------- REQUEST ID: " .. self.requestID)
	print( "--                                                																										  --" )
	print( "--												  																										  --" )
	print("request.body= " .. params)
	print( "--                                                																										  --" )
	print( "--												  																										  --" )
	print( "------------------------------------------------------------------------------------------------------------------------------------------------------------" )
	print( "------------------------------------------------------------------------------------------------------------------------------------------------------------" )
end

function Server:logResponse( params, responseID )
	print( "----------------------------------------------------" )
	print( "----------------- RESPONSE ID: " .. self.requestID)
	print( "--                                                																										  --" )
	print( "--												  																										  --" )
	print("response.body= ")
        if( type(params) == "string" )then
            native.showAlert("Server Response Message", params, {"TAMAM"}, function(event)
                if "clicked" == event.action then
                    local i = event.index
                    if 1 == i then
                        storyboard.purgeAll()
                        storyboard.gotoScene( "Scenes.LoginScene", "slideRight", 400)
                        local DataService = require "Network.DataService"
                        DataService:resetCachedData()
                    end
                end
            end)
            
            print(params)
        else 
            Utils:printTable(params)
        end
	
	print( "--                                                																										  --" )
	print( "--												  																										  --" )
	print( "------------------------------------------------------------------------------------------------------------------------------------------------------------" )
	print( "------------------------------------------------------------------------------------------------------------------------------------------------------------" )
end

function Server:request( params, callback, failure, requestType )

	self.requestID = self.requestID + 1
	self.params.body = params
	requestType = requestType or "POST"

	self:logRequest(params, self.requestID)
	network.request( self.baseURL, requestType, 
					
					function ( event )
                                            if (event.phase == "ended") then

                                                if event.isError then
                                                    
                                                    local errorData = json.decode( event.response )
                                                    Logger:error(self, "Server:request", "Connection Error! " .. errorData)
                                                    native.showAlert("Server Response Message", params, {"TAMAM"}, function(event)
                                                        if "clicked" == event.action then
                                                            local i = event.index
                                                            if 1 == i then
                                                                storyboard.purgeAll()
                                                                storyboard.gotoScene( "Scenes.LoginScene", "slideRight", 400)
                                                                local DataService = require "Network.DataService"
                                                                DataService:resetCachedData()
                                                            end
                                                        end
                                                    end)
                                                    failure(errorData) -- Call the related error callback function
                                                    
                                                else
                                                    local responseData = json.decode( event.response )
                                                    if responseData == nil then
                                                        responseData = event.response
                                                    else
                                                        responseData = responseData.results[1].res
                                                    end
                                                    
                                                    self:logResponse(responseData, self.requestID)

                                                    callback(responseData) -- Call the related callback function
                                                end
                                                
                                            end
					end, 
	
					self.params)
end

return Server


