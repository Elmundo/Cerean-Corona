-- First first
local display     = require "display"
local widget      = require "widget"
local mime        = require "mime"
local json        = require "json"
local string      = require "string"

local DataService  = require "DataService"
local Logger       = require "Logger" 
local Utils        = require "Utils"
local PackageScene = require "PackageScene"

-- Set default anchor point of project top-left
display.setDefault( "anchorX", 0 )
display.setDefault( "anchorY", 0 )
display.setDefault( "background", 255, 255, 255, 1 )

Logger:setLevel("DEBUG")
Logger:debug("main", "general", "PixelWidth: " .. display.pixelWidth .. " PixelHeight: " .. display.pixelHeight )
Logger:debug("main", "general", "ContentWidth: " .. display.contentWidth .. " ContentHeight: " .. display.contentHeight)
-- Login test
--[[
DataService:login("Crmuser", "CaCu2013!", function ( responseData ) 
	local memoryConsuming = collectgarbage( "count" )
	print( "memory consuming is " .. memoryConsuming .. " Kbyte")
end)
--]]

local packageScene = PackageScene.new()

packageScene.init()