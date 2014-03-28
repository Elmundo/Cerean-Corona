-- First first
local display     = require "display"
local widget      = require "widget"
local mime        = require "mime"
local DataService = require "DataService"
local Logger  = require "Logger" 
local Utils   = require "Utils"
local json    = require "json"


Logger:setLevel("DEBUG")
Logger:debug("main", "general", "This is main scope.")

-- Login test
DataService:login("Crmuser", "CaCu2013!", function ( responseData ) 
	local loginResponse = responseData
	Utils:printTable(loginResponse)
end)

