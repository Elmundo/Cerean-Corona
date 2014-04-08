local native       = require "native"
local display      = require "display"
local widget       = require "widget"
local mime         = require "mime"
local json         = require "json"
local string       = require "string"
local storyboard   = require "storyboard"
local DataService  = require "Network.DataService"
local Logger       = require "libs.Log.Logger"
local native       = require "native"

require "ParameterConfig"

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

storyboard.gotoScene( "Scenes.LoginScene", "slideLeft", 400)

native.showAlert("Alert Test", "This is a alert message", {"OK", "CANCEL"}, function(event)
    
end)
