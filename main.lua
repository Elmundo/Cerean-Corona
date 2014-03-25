	display.setStatusBar( display.HiddenStatusBar )

local storyboard = require "storyboard"
local widget = require "widget"

-------------------------------------------------------------------------------
--Error Handle
-------------------------------------------------------------------------------
local function myUnhandledErrorListener( event )

    local iHandledTheError = true

    if iHandledTheError then
        print( "Handling the unhandled error", event.errorMessage )
    else
        print( "Not handling the unhandled error", event.errorMessage )
    end
    
    return iHandledTheError
end

Runtime:addEventListener("unhandledError", myUnhandledErrorListener)
-------------------------------------------------------------------------------



storyboard.gotoScene( "Scenes.LoginScene", "slideLeft", 400 )