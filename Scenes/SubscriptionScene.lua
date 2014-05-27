local storyboard = require( "storyboard" )

local BaseScene   = require "Scenes.BaseScene"
local scene = BaseScene.new()

local display = require( "display" )
local widget = require( "widget" )
local native = require( "native" )

local DataService = require( "Network.DataService" )
local ParameterConfig = require( "ParameterConfig" )

local ProgressBar = require( "libs.ProgressBar.ProgressBar" )
local CButton = require( "Views.Buttons.CButton" )
local ControlBar = require( "Views.ControlBar" )
local SubscriberTypeView = require( "Views.SubscriberTypeView" )
local PersonalInformationView = require( "Views.PersonalInformationView" )
local EnterpriseInformationView = require( "Views.EnterpriseInformationView")
local CounterInformationView = require( "Views.CounterInformationView" )
local Utils = require("libs.Util.Utils")
local Logger = require "libs.Log.Logger"
----------------------------------------------------------------------------------
-- 
--      NOTE:
--      
--      Code outside of listener functions (below) will only be executed once,
--      unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------


-- local forward references should go here --


---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
local centerX = display.contentCenterX
local centerY = display.contentCenterY

local isCorporate = 0

local phase
local step
local isStepAnimationRunning

local logo
local progressBar
local controlBar
local progressBar

local subscriberTypeGroup

local personalInformationGroup
local enterpriseInformationGroup
local counterInformationGroup


local buttomWhiteMask
local nextButton
local backButton

local callCenterLogo
local fibaLogo

-- METHODS
local function setFocus ( yPos )
    transition.to(scene.view, {time=400, y= yPos, transition = easing.outExpo})
end 

local function onSceneTouch( event )
    if( "began" == event.phase )then
        if( event.target.isKeyboard )then
        
        else 
            setFocus(0)
            native.setKeyboardFocus(nil)
        end
            
    end
end
-- Network Error handler, check type 2
function scene:isErrorCheckOk(responseData)
    if responseData.ErrorCode == "00" and responseData.ErrorDetail == nil then
        return true
    end
    
    return false
end

function scene:saveContent ( appStep, callback ) 
    local contentData 
    if( step == kStepPersonel ) then
        if( isCorporate == 0 )then
            contentData = personalInformationGroup:getContent()
        else
            contentData = enterpriseInformationGroup:getContent() -- TODO: enterpriseGroup:getContent()
        end
        --Add a check for corporate later
        contentData["step"] = appStep
        contentData["IsCorporate"] = isCorporate--Add value to hold
        contentData["VerificationCode"] = DataService.verificationCode
        --DataService.verificationCode
        
        if( DataService.customerId ~= "" ) then
            contentData["CustomerId"] = DataService.customerId
            contentData["CustomerNumber"] = DataService.customerNumber
        end
        
        DataService:saveContent( contentData, 
                                 function (responseData) -- Success callback
                                     
                                     if scene:isErrorCheckOk(responseData) then
                                         Logger:debug(scene, "scene:saveContent", "Step 1 is success!")
                                         DataService.customerId = responseData.CustomerId
                                         DataService.customerNumber = responseData.CustomerNumber
                                         callback(true, nil )
                                         scene:shiftUp()
                                     else
                                         scene:alert( "Kayıt Başarısız", "Lütfen tekrar deneyiniz." )
                                         Logger:debug(scene, "scene:saveContent", "Step 1 is failure!")
                                         callback(false, responseData.ErrorMessage)
                                     end
                                     
                                     --scene:shiftUp()
                                     
                                 end, 
                                 
                                 function (errorData) -- Failure callback
                                    Logger:debug(scene, "scene:saveContent", "Step 1 is failure!")
                                    callback(false, errorData.ErrorDetail)
                                    --Shift Up Should Be Removed 
                                    --scene:shiftUp()
                                 end
            )
    elseif( step == kStepRegistry ) then
        -- Cache the meterSerialNumber
        --TODO: Bahadir - DataDataService.meterSerialNumber = _registryView.activeRegisterySerialNoText.text
        -- Yukardakine benzer bi atama olacak, farklı isimler verdiğin için ben atamayı yapamadım. Bu atamayı yapmayı unutma.
        
        --BAHADIR'dan:altta content data'dan aldım o bilgileri
        --Deneyip silicem
        local contentData = counterInformationGroup:getContent()
        --DataService.meterId = contentData["MeterId"]
        contentData["step"] = appStep
        
        if( DataService.phase == Phase.RegistryPhase ) then
            contentData["CustomerId"] = DataService.customer.CustomerId
        else
            contentData["CustomerId"] = DataService.customerId
        end
        
        --Below code for back from forward views
        if( DataService.meterId ~= "" ) then
            if( DataService.phase == Phase.RegistryPhase ) then  
                contentData["VerificationCode"] = DataService.verificationCode
                contentData["CustomerId"] = DataService.customer.customerId
            else
                --contentData["CustomerId"] = DataService.customerId
                --contentData["CustomerNumber"] = DataService.customerNumber
                contentData["MeterId"] = DataService.meterId
           end
        end
        
        DataService:saveContent( contentData, 
                                 function( responseData ) -- Success callback
                                     
                                     if scene:isErrorCheckOk(responseData) then
                                         Logger:debug(scene, "scene:saveContent", "Step 2 is success.")
                                         DataService.customerId     = responseData.CustomerId
                                         DataService.customerNumber = responseData.CustomerNumber
                                         DataService.meterId        = responseData.MeterId
                                         callback(true, nil)
                                         scene:shiftUp()
                                     else
                                         Logger:debug(scene, "Step 2 is failure.", message)
                                         callback(false, responseData.ErrorMessage)
                                     end
                                     
                                     
                                 end,
                                 function (errorData) -- Failure callback
                                     Logger:debug(scene, "Step 2 is failure.", message)
                                     callback(false, errorData.ErrorDetail)
                                     --scene:shiftUp()
                                 end
                                 )
        
        
        end
    
end

function scene:onComplete ()
        print( "Done animation" )
end

--onComplete
local function doneStepAnimationNext ()
        if( step == 0 )then
            if( isCorporate == 0 )then
                personalInformationGroup:hideGroup(false)
                enterpriseInformationGroup:hideGroup(true)
            else 
                personalInformationGroup:hideGroup(true)
                enterpriseInformationGroup:hideGroup(false)
            end
        elseif( step == 1 )then
            counterInformationGroup:hideGroup(false)
        end
            
        step = step  + 1 
        isStepAnimationRunning = false
        print( step )
end

local function doneStepAnimationBack()
        if( step == 2 )then
            if( isCorporate == 0 )then
                personalInformationGroup:hideGroup(false)
                enterpriseInformationGroup:hideGroup(true)
            else 
                personalInformationGroup:hideGroup(true)
                enterpriseInformationGroup:hideGroup(false)
            end
            
        elseif( step == 1 )then
            
        end
        step = step - 1
        isStepAnimationRunning = false
        print( step )
end

--TextField DELEGATE
function scene:onInputBegan( event )
    setFocus( -330 )
end
--Button DELEGATE  
function scene:onButtonTouchEnded( event )
    
    if( event.target.id == "backButton" )then
        print("BACK BUTTON PRESSED")
        scene:shiftDown()
    elseif( event.target.id == "nextButton" )then
        print("NEXT BUTTON PRESSED")
        if( step == 0 )then
                --Show AlertView or Disable next button as an alternative
        elseif( step == 1 )then
            --Checking for personal/corporate
            if( isCorporate == 0 )then
                
            end
            scene:saveContent(kStepPersonel, function( isSuccess, errorDetail )
                if( isSuccess )then 
                    print( "SUCCEDED" )
                    if( Phase.CallPhase == DataService.phase )then
                        storyboard.gotoScene("Scenes.AppointmentScene", "slideLeft", 800)
                    end
                    
                else
                    print( errorDetail )
                end
                
                if( DataService.phase == Phase.ApplicationPhase  )then
                    --local company = DataService:findCompanyForCity(DataService.selectedCity.id)
                    print( "Test")
                    if( DataService.selectedCity ~= null )then
                        counterInformationGroup:setCompany()
                        --Set City
                    end
                else 
                    
                end
            end)
        else 
            --counter
            --check Data
            scene:saveContent(kStepRegistry, function( isSuccess, errorDetail )
                if( isSuccess )then 
                    print( "SUCCEDED" )
                    DataService:getProduct(function(responseData)
                                        if( responseData )then
                                            DataService.products = responseData
                                            Utils:printTable(responseData)
                                            storyboard.gotoScene("Scenes.PackageScene", "slideLeft", 800)
                                        else 
                                            scene:alert("Servis Hatası", "Paket listesi boş geldi.")
                                        end
                                         --scene:shiftUp()
                                     end, function(errorData) 
                                        Utils:printTable(errorData)
                                     end)
                        print( "Next Scene" )
                else
                    --Pop Alert
                    print( errorDetail )
                end
            end)
        end
        --scene:shiftUp()
    end
    
end
 
 
function scene:setFocus ( yPos )
    
    transition.to(scene.view, {time=400, y= yPos, transition = easing.outExpo})
    --scene.view.y = yPos
end 

function scene:onInputBegan( event )
        
    scene:setFocus(-330)
        
end
        
function scene:onInputEdit( event )

end

function scene:onInputEnd( event )
    scene:setFocus(0)
end


function scene:individualButtonPressed () 
    isCorporate = 0
    personalInformationGroup.isVisible = true
    enterpriseInformationGroup.isVisible = false
    progressBar:setProgress(98)
    transition.to( personalInformationGroup, {time=400, y= -235,onComplete= doneStepAnimationNext , transition = easing.outExpo } )
    subscriberTypeGroup:disableButtons()
end

function scene:enterpriseButtonPressed ()
    isCorporate = 1
    personalInformationGroup.isVisible = false
    enterpriseInformationGroup.isVisible = true
    progressBar:setProgress(98)
    transition.to( enterpriseInformationGroup, {time=400, y= -235,onComplete = doneStepAnimationNext , transition = easing.outExpo} )
    subscriberTypeGroup:disableButtons()
end
--[[]
function scene:handleIndividualButtonEvent( event )
	-- body
	if ( event.phase == "ended") then
            isCorporate = false
            print( "Ind" )
            transition.to( personalInformationGroup, {time=400, y= -235,onComplete= doneStepAnimationNext , transition = easing.outExpo } )
            subscriberTypeGroup:disableButtons()
	end
end

function scene:handleCorporateButtonEvent( event )
	-- body
	if( event.phase == "ended") then
            isCorporate = true
            print( "Corp" )
	end
end
--]]
function scene:shiftUp()
        if( isStepAnimationRunning == false ) then
                isStepAnimationRunning = true
                if( step == 0 ) then
                    scene:alert("Uyarı", "Herhangi bir abonelik tipi seçmediniz!" )
                        --personalInformationGroup:hideGroup(true)
                        --Do Nothing
                        --transition.to( personalInformationGroup, {time=400, y= -235, transition = easing.outExpo } )
                elseif( step == 1 ) then
                        isStepAnimationRunning = true
                        personalInformationGroup:hideGroup(true)
                        progressBar:setProgress(150)
                        transition.to( counterInformationGroup, {time=400, y= -190,onComplete=doneStepAnimationNext,  transition = easing.outExpo } )
                        
                else 
                        
                        
                end
        end
end

function scene:shiftDown()

        if( isStepAnimationRunning == false ) then
                isStepAnimationRunning = true
                if( step == 0 ) then
                        --Pop previous scene
                        local previousScene = storyboard.getPrevious()
                        --TODO: if coming back from package view change this
                        storyboard.gotoScene(previousScene, "slideRight", 800 )
                elseif ( step == 1 ) then
                    if( DataService.phase == Phase.RegistryPhase)then
                        --back to previous scene
                        storyboard.gotoScene("Scenes.SearchUserScene", "slideRight", 800 )
                    else 
                        if( isCorporate == 0 )then
                            personalInformationGroup:hideGroup(true)
                            enterpriseInformationGroup:hideGroup(false)
                            transition.to( personalInformationGroup, {time=400, y= 185,onComplete=doneStepAnimationBack,  transition = easing.outExpo } )
                        else
                            personalInformationGroup:hideGroup(false)
                            enterpriseInformationGroup:hideGroup(true)
                            transition.to( enterpriseInformationGroup, {time=400, y= 185,onComplete=doneStepAnimationBack,  transition = easing.outExpo } )
                        end
                        subscriberTypeGroup:enableButtons()
                    end
                else 
                        counterInformationGroup:hideGroup(true)
                        transition.to( counterInformationGroup, {time=400, y= 230,onComplete=doneStepAnimationBack,  transition = easing.outExpo } )
                end
        end
end

function scene:logout()
    storyboard.removeAll()
    DataService:resetCachedData()
    storyboard.gotoScene("Scenes.LoginScene", "slideRight", 800)
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
        local group = self.view

        step = 0
        isStepAnimationRunning = false

        logo = display.newImage( "Assets/Logo.png", 50, 55, true )
        controlBar = ControlBar.new( self )
        buttomWhiteMask = display.newRect( 40, 690, 1200, 700 )
        --buttomWhiteMask:setFillColor( 1,0,0 )
        backButton = CButton.new( "GERİ", "backButton", self, 40, 700, 0 )
        nextButton = CButton.new( "DEVAM", "nextButton", self, 1100, 700, 0 )

        callCenterLogo = display.newImage( "Assets/CallCenter.png", 50, 750 )
        fibaLogo = display.newImage( "Assets/FibaGroup.png", 1030, 760 )
        --controlBar
        --progressBar
        progressBar = ProgressBar.new({x=323,y=60}, "Assets/ProgressBar.png", "Assets/ProgressBarMask.png")
        progressBar:setProgress(46)
--------------------------------------------

        counterInformationGroup = CounterInformationView.new(self)

--------------------------------------------
        personalInformationGroup = PersonalInformationView.new( scene )
        enterpriseInformationGroup = EnterpriseInformationView.new( scene )
        personalInformationGroup:hideGroup(true)
        enterpriseInformationGroup:hideGroup(true)

--------------------------------------------
        subscriberTypeGroup = SubscriberTypeView.new(self)
        --subscriberTypeGroup:addButtonEventListeners( scene.handleIndividualButtonEvent, scene.handleCorporateButtonEvent)
		group:insert( logo )
                group:insert( progressBar )
                group:insert( controlBar )
		group:insert( subscriberTypeGroup )
                
                group:insert( enterpriseInformationGroup )
		group:insert( personalInformationGroup )
                
                group:insert( counterInformationGroup )
                group:insert( buttomWhiteMask )
                group:insert( backButton )
                group:insert( nextButton )
                group:insert( callCenterLogo )
                group:insert( fibaLogo )
        -----------------------------------------------------------------------------

        --      CREATE display objects and add them to 'group' here.
        --      Example use-case: Restore 'group' from previously saved state.

        -----------------------------------------------------------------------------


end


-- Called BEFORE scene has moved onscreen:
function scene:willEnterScene( event )
        local group = self.view
        print( "willEnterScene" )
        step = 0
        isStepAnimationRunning = false

        -----------------------------------------------------------------------------

        --      This event requires build 2012.782 or later.

        -----------------------------------------------------------------------------

end

local superEnterScene = scene.enterScene
-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
        superEnterScene(self, event)
        local group = self.view
        if( DataService.meterId ~= "" )then
            step = 2
        end
        personalInformationGroup:onViewInit()
        counterInformationGroup:onViewInit()
        scene.view:addEventListener("touch", onSceneTouch)
        
        if( Phase.RegistryPhase == DataService.phase)then
            if( step == 0 )then
                step = 2
                transition.to( personalInformationGroup, {time=400, y= -190,  transition = easing.outExpo } )
                transition.to( enterpriseInformationGroup, {time=400, y= -190,  transition = easing.outExpo } )
                transition.to( counterInformationGroup, {time=400, y= -235,  transition = easing.outExpo } )
            end
        end
        -----------------------------------------------------------------------------

        --      INSERT code here (e.g. start timers, load audio, start listeners, etc.)

        -----------------------------------------------------------------------------

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
    native.setKeyboardFocus(nil)
        local group = self.view
        personalInformationGroup:onViewDelete()
        counterInformationGroup:onViewDelete()
        scene.view:removeEventListener("touch", onSceneTouch)
        -----------------------------------------------------------------------------

        --      INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)

        -----------------------------------------------------------------------------

end


-- Called AFTER scene has finished moving offscreen:
function scene:didExitScene( event )
        local group = self.view

        -----------------------------------------------------------------------------

        --      This event requires build 2012.782 or later.

        -----------------------------------------------------------------------------

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
        local group = self.view

        -----------------------------------------------------------------------------

        --      INSERT code here (e.g. remove listeners, widgets, save state, etc.)

        -----------------------------------------------------------------------------

end


-- Called if/when overlay scene is displayed via storyboard.showOverlay()
function scene:overlayBegan( event )
        local group = self.view
        local overlay_name = event.sceneName  -- name of the overlay scene
        
        -----------------------------------------------------------------------------

        --      This event requires build 2012.797 or later.

        -----------------------------------------------------------------------------

end


-- Called if/when overlay scene is hidden/removed via storyboard.hideOverlay()
function scene:overlayEnded( event )
        local group = self.view
        local overlay_name = event.sceneName  -- name of the overlay scene

        -----------------------------------------------------------------------------

        --      This event requires build 2012.797 or later.

        -----------------------------------------------------------------------------

end



---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "willEnterScene" event is dispatched before scene transition begins
scene:addEventListener( "willEnterScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "didExitScene" event is dispatched after scene has finished transitioning out
scene:addEventListener( "didExitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

-- "overlayBegan" event is dispatched when an overlay scene is shown
scene:addEventListener( "overlayBegan", scene )

-- "overlayEnded" event is dispatched when an overlay scene is hidden/removed
scene:addEventListener( "overlayEnded", scene )

---------------------------------------------------------------------------------

-- TODO: Bahadir - isCorporate datasının değeri SubscriptionView de yapılan seçime göre belirleniyor.
-- Delegate sistemi ile yapılan çözümü incele burda da benzer bi yapı kullan.
-- Aşağıda SubscriptionViewController içerisinde isCorporate'yi değiştiren kodu ekledim.'
--[[
#pragma mark SubscriptionDelegate
- (void)subscription:(SubscriptionView *)view didSelectSubscriptionType:(enum SubscriptionType)type
{
    switch (type) {
        case SubscriptionTypePerson:
            _personalView.hidden = NO;
            _enterpriseView.hidden = YES;
            self.IsCorporate = NO;
            break;
        case SubscriptionTypeEnterprise:
            _personalView.hidden = YES;
            _enterpriseView.hidden = NO;
            self.IsCorporate = YES;
            break;
            
        default:
            break;
    }
    
    [self shiftUp];
}

--]]

return scene
