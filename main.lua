-- First first
local display     = require "display"
local widget      = require "widget"
local mime        = require "mime"
local json        = require "json"
local string      = require "string"


local DataService = require "DataService"
local Logger      = require "Logger" 
local Utils       = require "Utils"

local storyboard = require "storyboard"
local widget = require "widget"

Logger:setLevel("DEBUG")
Logger:debug("main", "general", "This is main scope.")

-- Login test
---[[
DataService:login("Crmuser", "CaCu2013!", function ( responseData ) 
	local memoryConsuming = collectgarbage( "count" )
	print( "memory consuming is " .. memoryConsuming .. " Kbyte")
end)
--]]

display.setDefault("background", 1, 1, 1, 1)

storyboard.gotoScene( "LoginScene", "slideLeft", 400 )
