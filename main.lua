local display     = require "display"
local widget      = require "widget"; 
local widget_textField = require "widget+textField"
local mime        = require "mime"
local json        = require "json"
local string      = require "string"
local storyboard  = require "storyboard"

local DataService  = require "Network.DataService"
local Logger       = require "libs.Log.Logger" 

-- Set default anchor point of project top-left
display.setDefault( "anchorX", 0 )
display.setDefault( "anchorY", 0 )
display.setDefault("background", 1, 1, 1, 1)

-- Extend native libs
string.trim = function (str)
                    return (str:gsub("+%s*(.-)%s*$", "%1") )
                end

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

--storyboard.gotoScene( "Scenes.PackageScene", "slideLeft", 400)

local function textFieldHandler( event )
    --
    -- event.text only exists during the editing phase to show what's being edited.  
    -- It is **NOT** the field's .text attribute.  That is event.target.text
    --
    if event.phase == "began" then

        -- user begins editing textField
        print( "Begin editing", event.target.text )

    elseif event.phase == "ended" or event.phase == "submitted" then

        -- do something with defaulField's text
        print( "Final Text: ", event.target.text)
        native.setKeyboardFocus( nil )

    elseif event.phase == "editing" then

        print( event.newCharacters )
        print( event.oldText )
        print( event.startPosition )
        print( event.text )

    end
end

local textField = widget.newTextField({
    width = 250,
    height = 30,
    x = display.contentCenterX,
    y = display.contentCenterY,
    text = "Hello World",
    fontSize = 18,
    font = "HelveticaNeue-Light",
    listener = textFieldHandler,
})
