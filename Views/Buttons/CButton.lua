local CButton = {}

local display = require( "display" )
local native = require( "native" )
local widget = require( "widget" )

local button

function CButton.new( buttonLabel, buttonID, delegate, xPos, yPos, fontSize )
	local buttonWrapper = display.newGroup( )
        local label
        local background = display.newRoundedRect( 0, 0, 140, 40, 5 )
	background:setFillColor( 113/255, 27/255, 69/255 )
        
        local function onButtonTouch( event )
            
            if( event.phase == "began" )then
                background:setFillColor( 113/255, 27/255, 69/255, 0.95 )
               label:setFillColor( 0.5, 0.5 ) 
            elseif( event.phase == "moved" )then
                label:setFillColor( 1, 1 )
                background:setFillColor( 113/255, 27/255, 69/255, 1 )
            elseif( event.phase == "ended" )then
                background:setFillColor( 113/255, 27/255, 69/255, 1 )
                label:setFillColor( 1, 1 )
                if( buttonWrapper.delegate ~= nil )then
                    buttonWrapper.delegate:onButtonTouchEnded( event )
                end
            end
            
            return false
        end
        
        --button = display.newRoundedRect(0, 0, 140, 40, 5)
        --button:setFillColor(0, 1)
        
        label = display.newText( {
            text = buttonLabel,
            x = 70,
            y = 20,
            font = native.systemFont,
            fontSize = 18,
            align = "center",
            })
        --label:setTextColor(1, 1)
        label:setFillColor( 1, 1 )
        label.anchorX = 0.5
        label.anchorY = 0.5
        --button:addEventListener("touch", onButtonTouch )
        --[[]
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
        --]]
        buttonWrapper.delegate = delegate
        
	background:addEventListener("touch", onButtonTouch )
        background.id = buttonID
	buttonWrapper:insert( background )
        buttonWrapper:insert( label )
	--buttonWrapper:insert( button )

	buttonWrapper.x = xPos
	buttonWrapper.y = yPos

	return buttonWrapper
end

return CButton
