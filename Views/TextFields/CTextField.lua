

local display = require( "display" )
local native = require( "native" )

module( ... )

function new( xPos, yPos )

	local textFieldWrapper = display.newGroup( )
	local background = display.newImage( "Assets/InputInfo.png", 0, 0 )
	local textField = display.newText( "Test", 5, 10, 220, 20, native.systemFont, 15 )
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
	textField:setFillColor( 0, 0, 0 )
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

	textFieldWrapper.x = xPos
	textFieldWrapper.y = yPos



	function textFieldWrapper:setListener( listener )
            background:addEventListener("touch", listener)
		--textField:addEventListener( "userInput", listener )
	end

	function textFieldWrapper:getText()
		return textField.text
	end

	return textFieldWrapper
end


