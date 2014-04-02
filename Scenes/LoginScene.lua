local widget = require( "widget" )
local native = require( "native" )
local CTextField = require( "Views.TextFields.CTextField" )
local CLabel = require( "Views.Labels.CLabel" )
local CButton = require( "Views.Buttons.CButton" )



local BaseScene   = require "Scenes.BaseScene"
local scene = BaseScene.new()

local storyboard = require( "storyboard" )
--local scene = storyboard.newScene()
--local baseScene = BaseScene.new()
local centerX = display.contentCenterX
local centerY = display.contentCenterY

local displayGroup
local loginBackground
local loginBox

local userNameTextField
local passwordTextField

local inputField

local headerLabel
local userNameLabel
local passwordLabel
local errorLabel
local loginButton

function onButtonTouch( event )
	if( event.phase == "ended") then
		print( userNameTextField:getText() )
		print( passwordTextField:getText() )
		storyboard.gotoScene( "Scenes.MenuScene", "slideLeft", 800 )

		return true
	end
end

function onTextInput ( event )
    print( "Testing Fake input" ) 
end

function onTextFieldTouch ( event )
   activateInputField(centerX-120, centerY-15 )
   -- activateInputField(xPos, yPos, textObject)
end
function activateInputField ( xPos, yPos )
    inputField = native.newTextField(xPos+5, yPos+10, 220, 20, onTextInput)
    displayGroup:insert( inputField )
    native.setKeyboardFocus(ininputField)
end

-------------------------------------------------------------------------------
--Scene Evenet Handlers
-------------------------------------------------------------------------------
function scene:createScene( event )
	displayGroup = self.view
	loginBackground = display.newImageRect( "Assets/LoginBackground.png", 1280, 800 )
        
        
	loginBox = display.newImageRect( "Assets/LoginBox.png", 378, 498 )--640-189, 400-249, true )
        loginBox.x = 1280/2- 378/2
        loginBox.y = 800/2 -498/2
	userNameTextField = CTextField.new( centerX-120, centerY-15 )
        userNameTextField:setListener( onTextFieldTouch )
	passwordTextField = CTextField.new( centerX-120, centerY+55 ) 

        --inputField = native.newTextField(1280, 0, 220, 20, onTextInput )

	headerLabel = CLabel.new( "Bayi Girişi", centerX-120, centerY-70, 20)
	userNameLabel = CLabel.new( "Kullanıcı Kodu", centerX-120, centerY-35, 15)
	passwordLabel = CLabel.new( "Şifre", centerX-120, centerY+35, 15)

	loginButton = CButton.new( "GİRİŞ YAP", "loginButton", onButtonTouch, centerX-90, centerY+110, 0 )

	displayGroup:insert( loginBackground )
	displayGroup:insert( loginBox )
	displayGroup:insert( headerLabel )
	displayGroup:insert( userNameTextField )
	displayGroup:insert( passwordTextField )
	displayGroup:insert( userNameLabel )
	displayGroup:insert( passwordLabel )
	displayGroup:insert( loginButton )
	displayGroup.x = centerX
	displayGroup.y = centerY 

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