local widget = require( "widget" )
local CLabel = require( "Views.Labels.CLabel" )
local CButton = require( "Views.Buttons.CButton" )

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local centerX = display.contentCenterX
local centerY = display.contentCenterY


local displayGroup
local controlBar
local logo

local stage1Group
local bg1

local stage2Group
local bg2

local stage3Group
local bg3

-------------------------------------------------------------------------------
--Scene Evenet Handlers
-------------------------------------------------------------------------------
function scene:createScene( event )
	--storyboard.purgeScene( "Scenes.LoginScene" )

	displayGroup = self.view

	logo = display.newImage( "Assets/Logo.png" 20, 100 )
	stage1Group = display.newGroup( )
	bg1 = display.newRoundedRect( 100, 100, 500, 500, 5 )
	bg1:setFillColor( 1,0,0 )
	stage2Group = display.newGroup( )
	bg2 = display.newRoundedRect( 100, 100, 500, 500, 5 )
	bg2:setFillColor( 0,1,0 )
	stage3Group = display.newGroup( )
	bg3 = display.newRoundedRect( 100, 100, 500, 500, 5 )
	bg3:setFillColor( 0
		,0,1 )

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