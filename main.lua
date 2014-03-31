-- First first
local display     = require "display"
local widget      = require "widget"
local mime        = require "mime"
local json        = require "json"
local string      = require "string"

local DataService = require "DataService"
local Logger      = require "Logger" 
local Utils       = require "Utils"

Logger:setLevel("DEBUG")
Logger:debug("main", "general", "This is main scope.")

local list = "istanbul,ankara,izmir,gotham"

Utils:componentSeperatedByStringNew(list, "%w+")
-- Login test
--[[
DataService:login("Crmuser", "CaCu2013!", function ( responseData ) 
	local loginResponse = responseData
	Utils:printTable(loginResponse)
	local memoryConsuming = collectgarbage( "count" )
	print( "memory consuming is " .. memoryConsuming .. " Kbyte")
end)
--]]
