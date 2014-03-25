local display = require( "display" )
local native = require( "native" )

module( ... )

function new( xPos, yPos )

	local textFieldWrapper = display.newGroup( )
	local background = display.newImage( "Assets/InputInfo.png", 0, 0 )
	local textField = native.newTextField( 0, 0, 220, 20 )

	--Default Settings
	textField:setTextColor( 165, 161, 155 )
	textField.size = 1
	textField.font = native.newFont( "PTSans-Regular", 15 )
	--textField.font = native.newFont( "MyriadPro-Bold.otf", 15 )
	textField.align = "left"
	textField.hasBackground = false

	textFieldWrapper:insert( background )
	textFieldWrapper:insert( textField )

	textFieldWrapper.x = xPos
	textFieldWrapper.y = yPos



	function textFieldWrapper:setListener( listener )
		textField:addEventListener( "userInput", listener )
	end

	function textFieldWrapper:getText()
		return textField.text
	end

	return textFieldWrapper
end
