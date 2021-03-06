local native       = require "native"
local display      = require "display"
local widget       = require "widget"
local mime         = require "mime"
local json         = require "json"
local string       = require "string"
local timer        = require "timer"
local storyboard   = require "storyboard"
local Logger       = require "libs.Log.Logger"
local native       = require "native"
local DropDownMenu = require "libs.DDM.DropDownMenu"
local Utils        = require "libs.Util.Utils"
local DataService = require "Network.DataService"

require "ParameterConfig"

-- Set default anchor point of project top-left
display.setDefault( "anchorX", 0 )
display.setDefault( "anchorY", 0 )
display.setDefault( "background", 1, 1, 1, 1)

-- Extend native libs
string.trim = function (str)
                    return (str:gsub("+%s*(.-)%s*$", "%1") )
                end

Logger:setLevel("DEBUG")
Logger:debug("main", "general", "PixelWidth: " .. display.pixelWidth .. " PixelHeight: " .. display.pixelHeight )
Logger:debug("main", "general", "ContentWidth: " .. display.contentWidth .. " ContentHeight: " .. display.contentHeight)
Logger:debug("main", "general", "ContentWidth: " .. display.contentWidth .. " ContentHeight: " .. display.contentHeight)

storyboard.gotoScene( "Scenes.LoginScene", "slideLeft", 400)
