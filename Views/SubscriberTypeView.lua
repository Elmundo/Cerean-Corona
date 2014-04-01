local display = require( "display" )
local native = require( "native" )
local widget = require( "widget" )

module( ... )

function new()


	local subscriberTypeGroup
	local subscriberTypeHeaderText
	local subscriberTypeHeaderBackground
	local contentGroup
	local personalButton
	local corporateButton

	local centerX = display.contentCenterX
	local centerY = display.contentCenterY

	

	 subscriberTypeGroup = display.newGroup( )

	 function subscriberTypeGroup:addButtonEventListeners ( personal, corporate )
		personalButton:addEventListener( "touch", personal )
		corporateButton:addEventListener( "touch", corporate )
	end
	 
	 contentGroup = display.newGroup( )

	        subscriberTypeHeaderText = display.newText(  "Abonelik Tipi", 100, 160, native.systemFontBold, 15 )
			subscriberTypeHeaderText:setFillColor( 1, 1, 1 )

			subscriberTypeHeaderBackground = display.newRoundedRect( 640, 160, 1200, 40, 5 )
			subscriberTypeHeaderBackground:setFillColor( 255/255, 107/255, 0 )

			personalButton = widget.newButton{ width = 219, 
												height =219, 
												defaultFile ="Assets/ButtonIndividual.png", 
												overFile = "Assets/ButtonIndividualPressed.png", 
												label = "", 
												onEvent = handleIndividualButtonEvent }
			personalButton.x = centerX - 120
			personalButton.y = centerY 

			corporateButton = widget.newButton{ width = 219, 
												height =219, 
												defaultFile ="Assets/ButtonCorporate.png", 
												overFile = "Assets/ButtonCorporatePressed.png", 
												label = "", 
												onEvent = handleCorporateButtonEvent }
			corporateButton.x = centerX + 120
			corporateButton.y = centerY 

	        subscriberTypeGroup:insert( subscriberTypeHeaderBackground )
			subscriberTypeGroup:insert( subscriberTypeHeaderText )

			contentGroup:insert( personalButton)
			contentGroup:insert( corporateButton)

			subscriberTypeGroup:insert( contentGroup )

	return subscriberTypeGroup
end