local display = require( "display" )
local native = require( "native" )
local widget = require( "widget" )

module( ... )

function new( buttonLabel, buttonID, buttonListener, xPos, yPos, fontSize )
	
	local button = widget.newButton( 
	{
		left = xPos,
			top = yPos,
			id = buttonID,
			width = 100,
			height = 40,
			cornerRadius = 5,
			label = buttonLabel,
			onEvent = buttonListener
			
	} )
	return button
end