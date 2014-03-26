-- First first

local display = require "display"
local widget = require "widget"
local Server = require "Data.Server"

Server:login("Crmuser", "CaCu2013!")
--[[
local contentGroup = display.newGroup( )
contentGroup.x = 200
contentGroup.y = 200
contentGroup.anchorX = 0
contentGroup.anchorY = 0
contentGroup.anchorChildren = true

local paper = display.newRect( 0, 0, 100, 100 )
paper:setFillColor( 1,1,1 )
contentGroup:insert( paper )

local redBox = display.newRect( 0, -30, 50, 50 )
redBox:setFillColor( 1,0,0 )

local blueBox = display.newRect( 0, 0, 30, 30 )
blueBox:setFillColor( 0,0,1 )

local function handleButtonEvent( event )
	print( "Entered the button event" )
end
local changeSceneButton = widget.newButton {
	left = 10,
	top = 20,
	id = "button1",
	label = "Default",
	onEvent = handleButtonEvent,
}

--contentGroup:insert(redBox )
--contentGroup:insert(blueBox )
contentGroup:insert( changeSceneButton )
--]]

-- Methods

