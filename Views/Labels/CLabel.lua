local display = require( "display" )
local native = require( "native" )

module( ... )



function new( text, xPos, yPos, fontSize )
	local labelWrapper = display.newGroup( )
	local background
	local text = display.newText( text, 0, 0, "PTSans-Bold", fontSize )

	text:setFillColor( 113/255, 27/255, 69/255 )
	text.align = "left"

	labelWrapper:insert( text )

	labelWrapper.x = xPos
	labelWrapper.y = yPos

	function labelWrapper:setTextColor( red, green, blue )
		text:setFillColor( red, green, blue )
	end

	--Add background function will be added
	function labelWrapper:addBackgroundColor( width, height, indentation, red, green, blue )
		 
	end

	return labelWrapper
end

