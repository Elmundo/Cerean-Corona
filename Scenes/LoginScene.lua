local widget       = require( "widget" )
local native       = require( "native" )
local CTextField   = require( "Views.TextFields.CTextField" )
local CLabel       = require( "Views.Labels.CLabel" )
local CButton      = require( "Views.Buttons.CButton" )
local DataServer   = require "Network.DataService"
local Utils        = require "libs.Util.Utils"
local LoadingMask  = require "Views.LoadingMask"
local BaseScene    = require "Scenes.BaseScene"
local Logger       = require "libs.Log.Logger"

local scene = BaseScene.new()

local storyboard = require( "storyboard" )
--local scene = storyboard.newScene()
--local baseScene = BaseScene.new()
local kCachedDataCount = 6

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

local cachedDataIndex = 0

-- Network Error handler, check type 2
local function isErrorCheckOk(responseData)
    if responseData.ErrorCode == "00" and responseData.ErrorDetail == nil then
        return true
    end
    
    return false
end

local function nextViewController()
    
end

local function checkCachedDatas()
        
    if cachedDataIndex >= kCachedDataCount then
        storyboard.gotoScene( "Scenes.MenuScene", "slideLeft", 800 )
        return true
    end

    return false
end

local function cacheContents()
    
    DataServer:getParameters(kParameterCities, nil, function (responseData)
        
        -- Cache Cities list data
        DataServer.cities = responseData
        Logger:debug(scene, "DataServer:getParameters", "City list are cached!")
        
        cachedDataIndex = cachedDataIndex + 1
        checkCachedDatas()   
    end, function( errorData )
        
        Logger:debug(scene, "DataServer:getParameters", "City list could no be cached cached!")
        scene:alert("Login Operation", "City list could not be cached")
    end)
   
    DataServer:getParameters(kParameterCompanies, nil, function (responseData)
        
        -- Cache Companies list data
        DataServer.companies = responseData
        Logger:debug(scene, "DataServer:getParameters", "Company list are cached!")
        
        cachedDataIndex = cachedDataIndex + 1
        checkCachedDatas()   
    end, function( errorData )
        
        Logger:debug(scene, "DataServer:getParameters", "Company list could no be cached cached!")
        scene:alert("Login Operation", "Company list could not be cached")

    end)
    DataServer:getParameters(kParameterSuppliers, nil, function (responseData)
        
        -- Cache Suppliers list data
        DataServer.suppliers = responseData
        Logger:debug(scene, "DataServer:getParameters", "Supplier list are cached!")
        
        cachedDataIndex = cachedDataIndex + 1
        checkCachedDatas()   
    end, function( errorData )
        
        Logger:debug(scene, "DataServer:getParameters", "Supplier list could no be cached cached!")
        scene:alert("Login Operation", "Supplier list could not be cached")

    end)
    
    DataServer:getParameters(kParameterMembershipGroups, nil, function (responseData)
        
        -- Cache Membership Groups data
        DataServer.membershipgroups = responseData
        Logger:debug(scene, "DataServer:getParameters", "MembershipGroup list are cached!")
        
        cachedDataIndex = cachedDataIndex + 1
        checkCachedDatas()   
    end, function( errorData )
        
        Logger:debug(scene, "DataServer:getParameters", "MembershipGroup list could no be cached cached!")
        scene:alert("Login Operation", "MembershipGroup list could not be cached")

    end)
    
    DataServer:getParameters(kParameterMeterTypes, nil, function (responseData)
        
        -- Cache MeterTypes list data
        DataServer.meterList = responseData
        Logger:debug(scene, "DataServer:getParameters", "MeterType list are cached!")
        
        cachedDataIndex = cachedDataIndex + 1
        checkCachedDatas()   
    end, function( errorData )
        
        Logger:debug(scene, "DataServer:getParameters", "MeterType list could no be cached cached!")
        scene:alert("Login Operation", "MeterType list could not be cached")

    end)
    
    DataServer:getParameters(kParameterInterval, nil, function (responseData)
        
        -- Cache Interval list data
        DataServer.timeIntervals = responseData
        Logger:debug(scene, "DataServer:getParameters", "Interval list are cached!")
        
        cachedDataIndex = cachedDataIndex + 1
        checkCachedDatas()   
    end, function( errorData )
        
        Logger:debug(scene, "DataServer:getParameters", "Interval list could no be cached cached!")
        scene:alert("Login Operation", "Interval list could not be cached")

    end)

end

function onButtonTouch( event )
    if( event.phase == "ended") then
        print( userNameTextField:getText() )
        print( passwordTextField:getText() )

        scene:showMask()
        -- TODO: Hard-Coded Data Insert
        DataServer:login("Crmuser", "CaCu2013!", 
                                            function (responseData)

                                                if isErrorCheckOk(responseData) then
                                                    DataServer.userBusinessUnitName = responseData.UserBusinessUnitName
                                                    DataServer.userId               = responseData.UserId
                                                    DataServer.userName             = responseData.UserName

                                                    cacheContents()
                                                else
                                                    scene:hideMask()
                                                    -- TODO: Bahadir - burda errorMessage image'ını göstereceksin sanırım
                                                end

                                            end,

                                            function ( errorData )
                                                scene:alert("Login Operations","Login request is failed!",{"OK"})
                                                scene:hideMask()
                                            end)



        return true
    end
end

function onTextInput ( event )
    print( "Testing Fake input" ) 
end

function onTextFieldTouch ( event )
   --activateInputField(centerX-120, centerY-15 )
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
	userNameTextField = CTextField.new( centerX-120, centerY-15, 240, 40 )
        --userNameTextField:setListener( onTextFieldTouch )
	passwordTextField = CTextField.new( centerX-120, centerY+55, 240, 40 ) 

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

local superEnterScene = scene.enterScene
function  scene:enterScene( event )
    superEnterScene(self, event)
end

function scene:exitScene( event )
	
end

function scene:destroyScene( event )
	
end

-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
--Scene Evenet Listeners
-------------------------------------------------------------------------------
scene:addEventListener( "createScene" )
scene:addEventListener( "enterScene" )
scene:addEventListener( "exitScene" )
scene:addEventListener( "destroyScene" )
scene:addEventListener( "createScene" )
-------------------------------------------------------------------------------
return scene
