local CTextField = {}

local display = require( "display" )
local native = require( "native" )




function CTextField.new( xPos, yPos, width, height )
        
        local defaultXPos
        
	local textFieldWrapper = display.newGroup( )
	--local background = display.newImage( "Assets/InputInfo.png", 0, 0 )
        local background = display.newRoundedRect( 0, 0, width, height, 5 )
        background:setFillColor( 0.5, 0.5, 0.5 )
	local textField = native.newTextField(3, 3, width-6, height-6 )
        --display.newText( "Test", 5, 10, 220, 20, native.systemFont, 15 )
	--[[
		{
		text = "Test",
		x = xPos,
		y = yPos,
		width = 220,
		height = 20,
		font = native.systemFont,
		fontSize = 15
		}  
	--]]
	textField:setTextColor( 0, 0, 0 )
	local textContent
	--native.newTextField( 0, 0, 220, 20 )

	--Default Settings
	--textField:setFillCollor( 165/255, 161/255, 155/255 )
	--textField.size = 1
	--textField.font = native.newFont( "PTSans-Regular", 15 )
	--textField.font = native.newFont( "MyriadPro-Bold.otf", 15 )
	--textField.align = "left"
	--textField.hasBackground = false

	textFieldWrapper:insert( background )
	textFieldWrapper:insert( textField )
        
        defaultXPos = xPos
        
	textFieldWrapper.x = xPos
	textFieldWrapper.y = yPos
        function textFieldWrapper:setSize ( width, height )
            --This is for inheritance check with Barış
            textFieldWrapper = display.newGroup()
            background = display.newRoundedRect( 0, 0, width, height, 5 )
            background:setFillColor( 0.5, 0.5, 0.5 )
            textField = native.newTextField(2, 2, width-4, height-4 )
            textFieldWrapper:insert( background )
            textFieldWrapper:insert( textField )
        end
        
	function textFieldWrapper:setListener( listener )
            textField:addEventListener("touch", listener)
		--textField:addEventListener( "userInput", listener )
	end

	function textFieldWrapper:getText()
		return textField.text
	end
        function textFieldWrapper:hide( isHidden )
            if( isHidden ) then
                textFieldWrapper.x = display.pixelWidth + 5000
            else
                textFieldWrapper.x = defaultXPos
            end
        end
	return textFieldWrapper
end

return CTextField
