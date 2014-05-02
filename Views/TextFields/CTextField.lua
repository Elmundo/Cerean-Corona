local CTextField = {}

local display = require( "display" )
local native = require( "native" )

function CTextField.new( xPos, yPos, width, height )
        
        local defaultXPos
        
	local textFieldWrapper = display.newGroup( )
        textFieldWrapper.isKeyboard = true

        local textField = native.newTextField(-5, 0, width+10, height+10 )
        textField.font = native.newFont( native.systemFont, 12)
        textField.hasBackground = false
        
        
        local function onInput( event )
            if( event.phase == "began")then
                --TODO Need to add a button id
                if( textFieldWrapper.delegate ~= nil ) then
                    textFieldWrapper.delegate:onInputBegan( event )
                end
            elseif( event.phase == "editing" )then
                if( textFieldWrapper.delegate ~= nil ) then
                    textFieldWrapper.delegate:onInputEdit( event )
                end
            elseif( event.phase == "ended" )then
                if( textFieldWrapper.delegate ~= nil ) then
                    textFieldWrapper.delegate:onInputEnd( event )
                end
            end
            
            
            -- For DDM to handle userInput event
            -- Normally, Runtime global object is not receiving "userInput event
            -- so we do it menually
            Runtime:dispatchEvent{name="userInput", target=textField}
        end
        
        local function onTouchScreen( event )
            if( "began" == event.phase )then 
                if( event.target)then
                    print( "Touched to" .. event.target.iD )
                else 
                    --native.setKeyboardFocus(nil)
                    textFieldWrapper.delegate.onInputEnd()

                end
            end
        end
        
        local background = display.newRoundedRect( 0, 0, width, height, 5 )
        background:setFillColor( 0.5, 0.5, 0.5 )
        local whiteBackground = display.newRoundedRect( 4, 4, width-8, height-8, 5 )
        whiteBackground:setFillColor(1, 1, 1 )
	
        textField:addEventListener("userInput", onInput )
        
        

	textFieldWrapper:insert( background )
        textFieldWrapper:insert( whiteBackground )
	textFieldWrapper:insert( textField )
        
        defaultXPos = xPos
        
	textFieldWrapper.x = xPos
	textFieldWrapper.y = yPos
        
        --KeyboardHide
        function textFieldWrapper:removeRuntimeEventListener()
            Runtime:removeEventListener("touch", onTouchScreen)
        end
        
        function textFieldWrapper:addRuntimeEventListener()
            Runtime:addEventListener("touch", onTouchScreen )
        end
        --KeyboardHide
        
        function textFieldWrapper:setFont( font, size)
            textField.font = native.newFont( font, size)
        end
        
	function textFieldWrapper:setDelegate( delegate, iD )
            textFieldWrapper.delegate = delegate
            textField.iD = iD
	end
        
        function textFieldWrapper:setKeyboardType( keyboardType )
            textField.inputType = keyboardType
        end
        
        function textFieldWrapper:setKeyboardSecure( isSecure )
            textField.isSecure = isSecure
        end
        
        function textFieldWrapper:setText(text)
            textField.text = text
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
