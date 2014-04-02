require "CiderDebugger";-- First first
local display     = require "display"
local widget      = require "widget"
local mime        = require "mime"
local json        = require "json"
local string      = require "string"
local storyboard = require "storyboard"

local DataService  = require "Network.DataService"
local Logger       = require "libs.Log.Logger" 
local Utils        = require "libs.Util.Utils"
--local PackageScene = require "PackageScene"

-- Set default anchor point of project top-left
display.setDefault( "anchorX", 0 )
display.setDefault( "anchorY", 0 )
display.setDefault( "background", 255, 255, 255, 1 )

Logger:setLevel("DEBUG")
Logger:debug("main", "general", "PixelWidth: " .. display.pixelWidth .. " PixelHeight: " .. display.pixelHeight )
Logger:debug("main", "general", "ContentWidth: " .. display.contentWidth .. " ContentHeight: " .. display.contentHeight)
Logger:debug("main", "general", "ContentWidth: " .. display.contentWidth .. " ContentHeight: " .. display.contentHeight)




-- Set default anchor point of project top-left
--[[
display.setDefault( "anchorX", 0 )
display.setDefault( "anchorY", 0 )
--]]

-- Login test
--[[
DataService:login("Crmuser", "CaCu2013!", function ( responseData ) 
	local memoryConsuming = collectgarbage( "count" )
	print( "memory consuming is " .. memoryConsuming .. " Kbyte")
end)
--]]


display.setDefault("background", 1, 1, 1, 1)

storyboard.gotoScene( "Scenes.LoginScene", "slideLeft", 400 )

