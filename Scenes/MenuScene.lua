local widget = require( "widget" )
local CLabel = require( "Views.Labels.CLabel" )
local CButton = require( "Views.Buttons.CButton" )
local ControlBar = require( "Views.ControlBar")
local storyboard = require( "storyboard" )
local BaseScene   = require "Scenes.BaseScene"
local DataService = require( "Network.DataService" )
local scene = BaseScene.new()
--[[
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
--]]
local centerX = display.contentCenterX
local centerY = display.contentCenterY


local displayGroup
local controlBar
local menuHeader

local applicationPhaseButton
local callPhaseButton
local registryPhaseButton
local editPhaseButton



local function onApplicationPhaseButtonTouched( event )
        --TODO: Delete Later - Baris
        if event.phase == "ended" then
            DataService.phase = Phase.ApplicationPhase
            DataService.webFormPage = "bayibasvuru"
            storyboard.removeAll()
            storyboard.gotoScene("Scenes.SubscriptionScene", "slideLeft", 800)
        end
        --storyboard.gotoScene( "Scenes.SubscriptionScene", "slideLeft", 800 )
        
        return true
end

local function onCallPhaseButtonTouched( event )
        --TODO: Delete Later - Baris
        if event.phase == "ended" then
            DataService.phase = Phase.CallPhase
            DataService.webFormPage = "bayibeniara"
            storyboard.removeAll()
            storyboard.gotoScene("Scenes.SubscriptionScene", "slideLeft", 800)
        end
        
        --storyboard.gotoScene( "Scenes.SubscriptionScene", "slideLeft", 800 )
        
        return true
end

local function onRegistryPhaseButtonTouched( event )
        --TODO: Delete Later - Baris
        if event.phase == "ended" then
            DataService.phase = Phase.RegistryPhase
            DataService.webFormPage = "sayac"
            storyboard.removeAll()
            storyboard.gotoScene("Scenes.SearchUserScene", "slideLeft", 800)
        end
        --storyboard.gotoScene( "Scenes.SubscriptionScene", "slideLeft", 800 )
        
        return true
end

local function onEditPhaseButtonTouched( event )
    if( event.phase == "ended" )then
        DataService.phase = Phase.EditPhase
        DataService.webFormPage = "sayacyenile"
        storyboard.removeAll()
        storyboard.gotoScene("Scenes.SearchUserScene", "slideLeft", 800)
    end
    
    return true
end

function scene:logout()
    storyboard.removeAll()
    DataService:resetCachedData()
    storyboard.gotoScene("Scenes.LoginScene", "slideRight", 800)
end
-------------------------------------------------------------------------------
--Scene Evenet Handlers
-------------------------------------------------------------------------------
function scene:createScene( event )
	--storyboard.purgeScene( "Scenes.LoginScene" )

	displayGroup = self.view
        controlBar = ControlBar.new( self )
	--testImage  = display.newImage( "avengerMinions.jpg", centerX, centerY, true )
	menuHeader = display.newImageRect( "Assets/MenuHeader.png", 1280, 100 )
        menuHeader.x = 0
        menuHeader.y = 50
	applicationPhaseButton = widget.newButton{
   		width = 219,
                height = 219,
                defaultFile = "Assets/MenuButton01.png",
                overFile = "Assets/MenuButton01Pressed.png",
                label = "",
                onEvent = onApplicationPhaseButtonTouched
	}
	applicationPhaseButton.x = centerX-2*219-15
	applicationPhaseButton.y = centerY-219/2

	callPhaseButton = widget.newButton{
   		width = 219,
    	height = 219,
    	defaultFile = "Assets/MenuButton02.png",
    	overFile = "Assets/MenuButton02Pressed.png",
    	label = "",
    	onEvent = onCallPhaseButtonTouched
	}
	callPhaseButton.x = centerX-219-5
	callPhaseButton.y = centerY-219/2

	registryPhaseButton = widget.newButton{
   		width = 219,
    	height = 219,
    	defaultFile = "Assets/MenuButton03.png",
    	overFile = "Assets/MenuButton03Pressed.png",
    	label = "",
    	onEvent = onRegistryPhaseButtonTouched
	}
	registryPhaseButton.x = centerX+5
	registryPhaseButton.y = centerY-219/2
        
        editPhaseButton = widget.newButton{
            width = 219,
            height = 219,
            defaultFile = "Assets/MenuButton04.png",
            overFile = "Assets/MenuButton04Pressed.png",
            label = "",
            onEvent = onEditPhaseButtonTouched
        }
        editPhaseButton.x = centerX+219+15
        editPhaseButton.y = centerY-219/2
        
        displayGroup:insert( controlBar )
	displayGroup:insert( menuHeader )
	displayGroup:insert( applicationPhaseButton )
	displayGroup:insert( callPhaseButton )
	displayGroup:insert( registryPhaseButton )
        displayGroup:insert( editPhaseButton)
	--[[
	displayGroup.x = centerX
	displayGroup.y = centerY
	--]]
end

function  scene:enterScene( event )
	
end

function scene:exitScene( event )
    native.setKeyboardFocus(nil)
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
