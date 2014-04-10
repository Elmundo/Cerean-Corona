local CButton = {}

local display = require( "display" )
local native = require( "native" )
local widget = require( "widget" )

local button

function CButton.new( buttonLabel, buttonID, delegate, xPos, yPos, fontSize )
	local buttonWrapper = display.newGroup( )
        local function onButtonTouch( event )
            if( event.phase == "ended" )then
                if( buttonWrapper.delegate ~= nil )then
                    buttonWrapper.delegate:onButtonTouchEnded( event )
                end
            end
        end
        
	button = widget.newButton( 
	{
		left = 0,
		top = 0,
		id = buttonID,
		width = 140,
		height = 40,
		cornerRadius = 5,
		label = buttonLabel,
		onEvent = onButtonTouch,
		textOnly = false,
		labelYOffset = -4,
		labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } }
			
	} )
        buttonWrapper.delegate = delegate
        
	local background = display.newRoundedRect( 0, 0, 140, 40, 5 )
	background:setFillColor( 113/255, 27/255, 69/255 )
	
	buttonWrapper:insert( background )
	buttonWrapper:insert( button )

	buttonWrapper.x = xPos
	buttonWrapper.y = yPos

	return buttonWrapper
end

return CButton
