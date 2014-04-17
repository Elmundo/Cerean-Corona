local storyboard = require( "storyboard" )

local BaseScene   = require "Scenes.BaseScene"
local scene = BaseScene.new()

local display = require( "display" )
local widget = require( "widget" )
local native = require( "native" )

local DataService = require( "Network.DataService" )
local ParameterConfig = require( "ParameterConfig" )

local CButton = require( "Views.Buttons.CButton" )
local ControlBar = require( "Views.ControlBar" )
local SubscriberTypeView = require( "Views.SubscriberTypeView" )
local PersonalInformationView = require( "Views.PersonalInformationView" )
local EnterpriseInformationView = require( "Views.EnterpriseInformationView")
local CounterInformationView = require( "Views.CounterInformationView" )
local Utils = require("libs.Util.Utils")
local Logger = require "libs.Log.Logger"

local DropDownMenu = require( "libs.DDM.DropDownMenu" )
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
        
        local test = DataService
        --[[]
        if( DataService.customerId == not nil ) then
            contentData["CustomerId"] = DataService.customerId
            contentData["CustomerNumber"] = DataService.customerNumber
        end
        --]]
        DataService:saveContent( contentData, 
                                 function (responseData) -- Success callback
                                     
                                     if scene:isErrorCheckOk(responseData) then
                                         Logger:debug(scene, "scene:saveContent", "Step 1 is success!")
                                         DataService.customerId = responseData.CustomerId
                                         DataService.customerNumber = responseData.UstomerNumber
                                         callback(true, nil )
                                         scene:shiftUp()
                                     else
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
        DataService.meterId = contentData["MeterId"]
        contentData["step"] = appStep
        
        if( DataService.phase == Phase.RegistryPhase ) then
            contentData["CustomerId"] = DataService.customer.customerId
        else
            contentData["CustomerId"] = DataService.customerId
        end
        
        --Below code for back from forward views
        if( DataService.meterId == null ) then
           if( DataService.phase == Phase.RegistryPhase ) then  
                contentData["VerificationCode"] = DataService.verificationCode
                contentData["CustomerId"] = DataService.customer.customerId
           else
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
function scene:doneStepAnimationNext ()
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

function scene:doneStepAnimationBack()
        if( step == 2 )then
            if( isCorporate == 0 )then
                personalInformationGroup:hideGroup(false)
                
            else 
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
                    
                else
                    print( errorDetail )
                end
                if( DataService.phase == Phase.ApplicationPhase  )then
                    local company = DataService:findCompanyForCity(DataService.selectedCity.ID)
                    if( company ~= null )then
                        
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
                                         DataService.products = responseData
                                         Utils:printTable(responseData)
                                         storyboard.gotoScene("Scenes.PackageScene", "slideLeft", 800)
                                         --scene:shiftUp()
                                     end, function(errorData) 
                                        Utils:printTable(errorData)
                                     end)
                    --storyboard.gotoScene("Scenes.PackageScene", "slideLeft", 800)
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

--local corporateInformationGroup

function scene:individualButtonPressed () 
    isCorporate = 0
    enterpriseInformationGroup.isVisible = false
    transition.to( personalInformationGroup, {time=400, y= -235,onComplete= scene.doneStepAnimationNext , transition = easing.outExpo } )
end

function scene:enterpriseButtonPressed ()
    isCorporate = 1
    personalInformationGroup.isVisible = false
    transition.to( enterpriseInformationGroup, {time=400, y= -235,onComplete = scene.doneStepAnimationNext , transition = easing.outExpo} )
end

function scene:handleIndividualButtonEvent( event )
	-- body
	if ( event.phase == "ended") then
            isCorporate = false
            print( "Ind" )
            transition.to( personalInformationGroup, {time=400, y= -235,onComplete=scene.doneStepAnimationNext , transition = easing.outExpo } )
	end
end

function scene:handleCorporateButtonEvent( event )
	-- body
	if( event.phase == "ended") then
            isCorporate = true
            print( "Corp" )
	end
end

function scene:shiftUp()
        if( isStepAnimationRunning == false ) then
                isStepAnimationRunning = true
                if( step == 0 ) then
                        --personalInformationGroup:hideGroup(true)
                        --Do Nothing
                        --transition.to( personalInformationGroup, {time=400, y= -235, transition = easing.outExpo } )
                elseif( step == 1 ) then
                        isStepAnimationRunning = true
                        personalInformationGroup:hideGroup(true)
                        transition.to( counterInformationGroup, {time=400, y= -190,onComplete=scene.doneStepAnimationNext,  transition = easing.outExpo } )
                                    
                        --saveContent(appStep)
                        --[[
                        saveContent(kStepPersonel, function (responseData)
                                                                transition.to( counterInformationGroup, {time=400, y= -190,onComplete=doneStepAnimationNext,  transition = easing.outExpo } )
                                                            end )
                                                            --]]
                        
                else 
                        --NextScenePackageScene
                        
                end
        end
end

function scene:shiftDown()

        if( isStepAnimationRunning == false ) then
                isStepAnimationRunning = true
                if( step == 0 ) then
                        --Pop previous scene
                        local previousScene = storyboard.getPrevious()
                        storyboard.gotoScene(previousScene, "slideRight", 800 )
                elseif ( step == 1 ) then
                        personalInformationGroup:hideGroup(true)
                        transition.to( personalInformationGroup, {time=400, y= 185,onComplete=scene.doneStepAnimationBack,  transition = easing.outExpo } )
                else 
                        counterInformationGroup:hideGroup(true)
                        transition.to( counterInformationGroup, {time=400, y= 230,onComplete=scene.doneStepAnimationBack,  transition = easing.outExpo } )
                end
        end
end


-- Called when the scene's view does not exist:
function scene:createScene( event )
        local group = self.view

        step = 0
        isStepAnimationRunning = false

        logo = display.newImage( "Assets/Logo.png", 50, 55, true )
        controlBar = ControlBar.new()
        buttomWhiteMask = display.newRect( 40, 690, 1200, 110 )
        --buttomWhiteMask:setFillColor( 1,0,0 )
        backButton = CButton.new( "GERİ", "backButton", self, 40, 700, 0 )
        nextButton = CButton.new( "DEVAM", "nextButton", self, 1100, 700, 0 )

        callCenterLogo = display.newImage( "Assets/CallCenter.png", 50, 750 )
        fibaLogo = display.newImage( "Assets/FibaGroup.png", 1030, 760 )
        --controlBar
        --progressBar
--------------------------------------------

        counterInformationGroup = CounterInformationView.new()

--------------------------------------------
        personalInformationGroup = PersonalInformationView.new()
        enterpriseInformationGroup = EnterpriseInformationView.new()
        personalInformationGroup:hideGroup(true)
        enterpriseInformationGroup:hideGroup(true)

--------------------------------------------
        subscriberTypeGroup = SubscriberTypeView.new(self)
        --subscriberTypeGroup:addButtonEventListeners( scene.handleIndividualButtonEvent, scene.handleCorporateButtonEvent)
		group:insert( logo )
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
        DropDownMenu.addListener()
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


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
        local group = self.view
        
        -----------------------------------------------------------------------------

        --      INSERT code here (e.g. start timers, load audio, start listeners, etc.)

        -----------------------------------------------------------------------------

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
        local group = self.view
        
        DropDownMenu.destroy()
        
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
