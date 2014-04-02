local display     = require "display"
local storyboard  = require "storyboard"

local DataService  = require "Network.DataService"
local Logger       = require "libs.Log.Logger" 

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

storyboard.gotoScene("Scenes.PackageScene", { effect = "slideLeft", time=800})

-- ERROR HANDLING SECTION --
function myUnhandledErrorListener( event )

    local iHandledTheError = true

    if ( iHandledTheError ) then
        print( "Handling the unhandled error", event.errorMessage )
    else
        print( "Not handling the unhandled error", event.errorMessage )
    end

    return iHandledTheError
end

Runtime:addEventListener( "unhandledError", myUnhandledErrorListener )

