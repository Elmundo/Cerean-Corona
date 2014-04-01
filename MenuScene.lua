local widget = require( "widget" )
local CLabel = require( "Views.Labels.CLabel" )
local CButton = require( "Views.Buttons.CButton" )

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local centerX = display.contentCenterX
local centerY = display.contentCenterY


local displayGroup
local controlBar
local menuHeader
local applicationPhaseButton
local callPhaseButton
local registryPhaseButton




function onExitButtonTouched( event )

end

function onPhaseButtonTouched( event )
	storyboard.gotoScene( "SubscriptionScene", "slideLeft", 800 )
	return true
end

-------------------------------------------------------------------------------
--Scene Evenet Handlers
-------------------------------------------------------------------------------
function scene:createScene( event )
	--storyboard.purgeScene( "Scenes.LoginScene" )

	displayGroup = self.view

	--testImage  = display.newImage( "avengerMinions.jpg", centerX, centerY, true )
	menuHeader = display.newImage( "Assets/MenuHeader.png", centerX, 100, true )
	applicationPhaseButton = widget.newButton{
   		width = 219,
    	height = 219,
    	defaultFile = "Assets/MenuButton01.png",
    	overFile = "Assets/MenuButton01Pressed.png",
    	label = "",
    	onEvent = onPhaseButtonTouched
	}
	applicationPhaseButton.x = centerX-229
	applicationPhaseButton.y = centerY+50

	callPhaseButton = widget.newButton{
   		width = 219,
    	height = 219,
    	defaultFile = "Assets/MenuButton02.png",
    	overFile = "Assets/MenuButton02Pressed.png",
    	label = "",
    	onEvent = onPhaseButtonTouched
	}
	callPhaseButton.x = centerX
	callPhaseButton.y = centerY+50

	registryPhaseButton = widget.newButton{
   		width = 219,
    	height = 219,
    	defaultFile = "Assets/MenuButton03.png",
    	overFile = "Assets/MenuButton03Pressed.png",
    	label = "",
    	onEvent = onPhaseButtonTouched
	}
	registryPhaseButton.x = centerX+229
	registryPhaseButton.y = centerY+50

	displayGroup:insert( menuHeader )
	displayGroup:insert( applicationPhaseButton )
	displayGroup:insert( callPhaseButton )
	displayGroup:insert( registryPhaseButton )
	--[[
	displayGroup.x = centerX
	displayGroup.y = centerY
	--]]
end

function  scene:enterScene( event )
	
end

function scene:exitScene( event )
	
end

function scene:destroyScene( event )
	
end

-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
--Scene Evenet Listeners
-------------------------------------------------------------------------------
scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
-------------------------------------------------------------------------------
return scene
