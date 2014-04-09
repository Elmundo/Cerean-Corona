local storyboard = require( "storyboard" )

local BaseScene   = require "Scenes.BaseScene"
local scene = BaseScene.new()

local display = require( "display" )
local widget = require( "widget" )
local native = require( "native" )

local DataService = require( "Network.DataService" )

local CButton = require( "Views.Buttons.CButton" )
local ControlBar = require( "Views.ControlBar" )
local SubscriberTypeView = require( "Views.SubscriberTypeView" )
local PersonalInformationView = require( "Views.PersonalInformationView" )
local CounterInformationView = require( "Views.CounterInformationView" )
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

local isCorporate

local phase
local step
local isStepAnimationRunning

local logo
local progressBar
local controlBar

local subscriberTypeGroup

local personalInformationGroup

local counterInformationGroup


local buttomWhiteMask
local nextButton
local backButton

local callCenterLogo
local fibaLogo



function saveContent ( appStep, callback ) 
    if( step == 1 ) then
        local contentData = personalInformationGroup:getContent()
        --Add a check for corporate later
        contentData["step"] = appStep
        contentData["IsCorporate"] = 0 --Add value to hold
        
        contentData["VerificationCode"] = DataService.verificationCode
        
        if( DataService.customerId ) then
            contentData["CustomerId"] = DataService.customerId
            contentData["CustomerNumber"] = DataService.customerNumber
        end
        
        DataService.saveContent( contentData, 
                                 function (status) 
                                     --Code Here
                                     --Check Error?
                                      DataService.customerId = status.customerId
                                      DataService.customerNumber = status.customerNumber
                                      callback( responseData )
                                 end
            )
    else if( step == 2 ) then
        --DataDataService.meterSerialNumber = 
        --DataService.meterId = 
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
                                 function( responseData )
                                     --Add status response check
                                     DataService.customerId = responseData.customerId
                                     DataService.customerNumber = responseData.customerNumber
                                     DataService.meterId = responseData.meterId
                                 end )
        
        
        end
    end
end

function onComplete ()
        print( "Done animation" )
end

--onComplete
function doneStepAnimationNext ()
        if( step == 0 )then
            personalInformationGroup:hideGroup(false)
        end
            
        step = step  + 1 
        isStepAnimationRunning = false
        print( step )
end

function doneStepAnimationBack()
        if( step == 2 )then
            personalInformationGroup:hideGroup(false)
        end
        step = step - 1
        isStepAnimationRunning = false
        print( step )
end

function onBackButtonTouch( event )
        if( event.phase == "ended" ) then
                print( "Back" )
                shiftDown()
        end
end

function onNextButtonTouch( event )
        if( event.phase == "ended" ) then
                print( "Next" )
                shiftUp()
        end
end



--local corporateInformationGroup

function handleIndividualButtonEvent( event )
	-- body
	if ( event.phase == "ended") then
            isCorporate = false
            print( "Ind" )
            transition.to( personalInformationGroup, {time=400, y= -235,onComplete=doneStepAnimationNext , transition = easing.outExpo } )
	end
end

function handleCorporateButtonEvent( event )
	-- body
	if( event.phase == "ended") then
            isCorporate = true
            print( "Corp" )
	end
end

function shiftUp()
        if( isStepAnimationRunning == false ) then
                isStepAnimationRunning = true
                if( step == 0 ) then
                        --personalInformationGroup:hideGroup(true)
                        --Do Nothing
                        --transition.to( personalInformationGroup, {time=400, y= -235, transition = easing.outExpo } )
                elseif( step == 1 ) then
                        isStepAnimationRunning = true
                        personalInformationGroup:hideGroup(true)
                        --saveContent(appStep)
                        --[[
                        saveContent(kStepPersonel, function (responseData)
                                                                transition.to( counterInformationGroup, {time=400, y= -190,onComplete=doneStepAnimationNext,  transition = easing.outExpo } )
                                                            end )
                                                            --]]
                        transition.to( counterInformationGroup, {time=400, y= -190,onComplete=doneStepAnimationNext,  transition = easing.outExpo } )
                else 
                        --NextScenePackageScene
                        storyboard.gotoScene("Scenes.PackageScene", "slideLeft", 800)
                        print( "Next Scene" )
                end
        end
end

function shiftDown()

        if( isStepAnimationRunning == false ) then
                isStepAnimationRunning = true
                if( step == 0 ) then
                        --Pop previous scene
                        local previousScene = storyboard.getPrevious()
                        storyboard.gotoScene(previousScene, "slideRight", 800 )
                elseif ( step == 1 ) then
                        personalInformationGroup:hideGroup(true)
                        transition.to( personalInformationGroup, {time=400, y= 185,onComplete=doneStepAnimationBack,  transition = easing.outExpo } )
                else 
                        transition.to( counterInformationGroup, {time=400, y= 230,onComplete=doneStepAnimationBack,  transition = easing.outExpo } )
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
        backButton = CButton.new( "GERİ", "backButton", onBackButtonTouch, 40, 700, 0 )
        nextButton = CButton.new( "DEVAM", "nextButton", onNextButtonTouch, 1100, 700, 0 )

        callCenterLogo = display.newImage( "Assets/CallCenter.png", 50, 750 )
        fibaLogo = display.newImage( "Assets/FibaGroup.png", 1030, 760 )
        --controlBar
        --progressBar
--------------------------------------------

        counterInformationGroup = CounterInformationView.new()

--------------------------------------------
        personalInformationGroup = PersonalInformationView.new()
        personalInformationGroup:hideGroup(true)

--------------------------------------------
        subscriberTypeGroup = SubscriberTypeView.new()
        subscriberTypeGroup:addButtonEventListeners( handleIndividualButtonEvent, handleCorporateButtonEvent)
		group:insert( logo )
                group:insert( controlBar )
		group:insert( subscriberTypeGroup )
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

return scene