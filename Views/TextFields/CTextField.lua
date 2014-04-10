local CTextField = {}

local display = require( "display" )
local native = require( "native" )

function CTextField.new( xPos, yPos, width, height )
        
        local defaultXPos
        
	local textFieldWrapper = display.newGroup( )
        
        local function onInput( event )
            if( event.phase == "began")then
                --TODO Need to add a button id
                if( textFieldWrapper.delegate ~= nil ) then
                    textFieldWrapper.delegate:onInputBegan( event )
                end
            end
        end

        local background = display.newRoundedRect( 0, 0, width, height, 5 )
        background:setFillColor( 0.5, 0.5, 0.5 )
        
	local textField = native.newTextField(3, 3, width-6, height-6 )
        textField:setTextColor( 0, 0, 0 )
        textField:addEventListener("userInput", onInput )

	textFieldWrapper:insert( background )
	textFieldWrapper:insert( textField )
        
        defaultXPos = xPos
        
	textFieldWrapper.x = xPos
	textFieldWrapper.y = yPos
        
	function textFieldWrapper:setDelegate( delegate )
            textFieldWrapper.delegate = delegate
	end

	function textFieldWrapper:getText()
		return textField.text
	end
        
        function textFieldWrapper:hide(isHidden)
            if( isHidden ) then
                textFieldWrapper.x = display.pixelWidth + 5000
            else
                textFieldWrapper.x = defaultXPos
            end
        end
	return textFieldWrapper
end

return CTextField
