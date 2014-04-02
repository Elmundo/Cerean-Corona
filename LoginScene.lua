local widget = require( "widget" )
local CTextField = require( "Views.TextFields.CTextField" )
local CLabel = require( "Views.Labels.CLabel" )
local CButton = require( "Views.Buttons.CButton" )

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local centerX = display.contentCenterX
local centerY = display.contentCenterY

local displayGroup
local loginBackground
local loginBox

local userNameTextField
local passwordTextField

local headerLabel
local userNameLabel
local passwordLabel
local errorLabel
local loginButton

function onButtonTouch( event )
	if( event.phase == "ended") then
		print( userNameTextField:getText() )
		print( passwordTextField:getText() )
		storyboard.gotoScene( "MenuScene", "slideLeft", 800 )

		return true
	end
end

-------------------------------------------------------------------------------
--Scene Evenet Handlers
-------------------------------------------------------------------------------
function scene:createScene( event )
	displayGroup = self.view
	loginBackground = display.newImage( "Assets/LoginBackground.png", 0, 0, true )
	loginBox = display.newImage( "Assets/LoginBox.png", 640-189, 400-249, true )

	userNameTextField = CTextField.new( centerX-120, centerY-15 )
	passwordTextField = CTextField.new( centerX-120, centerY+55 ) 

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