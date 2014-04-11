local widget = require( "widget" )
local native = require( "native" )

local CTextField = require( "Views.TextFields.CTextField" )
local CLabel = require( "Views.Labels.CLabel" )
local CButton = require( "Views.Buttons.CButton" )
local parameterConfig = require( "ParameterConfig" )

local DataService = require( "Network.DataService" )

local ControlBar = require( "Views.ControlBar" )

local AppointmentPlanningView = require( "Views.AppointmentPlanningView" )
local AddresInformationView = require( "Views.AddressInformationView" )

local BaseScene   = require "Scenes.BaseScene"
local scene = BaseScene.new()

local storyboard = require( "storyboard" )

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

local phase
local step
local isStepAnimationRunning

local logo
local progressBar
local controlBar

local appointmentPlanningView
local addressInformationView


local buttomWhiteMask
local nextButton
local backButton

local callCenterLogo
local fibaLogo


--onComplete
local function doneStepAnimationNext ()
        if( step == 0 )then
            addressInformationView:hideGroup(false)
        end
        step = step  + 1 
        isStepAnimationRunning = false
        print( step )
end

local function doneStepAnimationBack()

        step = step - 1
        isStepAnimationRunning = false
        print( step )
end

local function saveContent(appStep, callback)
    local contentData
    if( step == 0 ) then
        contentData = appointmentPlanningView:getContent(appStep)
        
        if( DataService.appointmentId ~= null ) then
            --Back from next scene
            contentData["AppointmentId"] = DataService.appointmentId
        end
        
        contentData["step"] = kStepAppointment
        contentData["CustomerId"] = DataService.customerId
        
        if( DataService.phase == Phase.CallPhase ) then
            contentData["MeterId"] = ""
            contentData["QuoteId"] = ""
        else if( DataService.phase == Phase.RegistryPhase ) then

        else 
            contentData["MeterId"] = DataService.meterId
            contentData["QuoteId"] = DataService.quoteId
        end
        end
        DataService:saveContent(contentData, function (responseData)
            --check Error
                                    DataService.appointmentId = responseData.appointmentData
                                    callback(responseData)
                                end )
    else 
        --Check for back
        contentData = addressInformationView:getContent()
        if( DataService.addressIdVisiting ~= null ) then
            contentData["AdressIdVisiting"] = DataService.addressIdVisiting
        end
        contentData["step"] = appStep
        contentData["CustomerId"] = DataService.CustomerId
        contentData["AppointmentId"] = DataService.AppointmentId
        
        if( DataService.phase == Phase.CallPhase )then
            contentData["MeterId"] = ""
            contentData["QuoteId"] = ""
        elseif( DataService.phase == Phase.RegistryPhase )then
            contentData["MeterId"] = DataService.MeterId
            contentData["QuoteId"] = DataService.QuoteId
        else
            contentData["MeterId"] = DataService.MeterId
            contentData["QuoteId"] = DataService.QuoteId
        end
        end
        
        DataService:saveContent(contentData, function (responseData)
            --check Error
                                    DataService.appointmentId = responseData.appointmentData
                                    callback(responseData)
                                end )
end

local function shiftUp()
    
        if( isStepAnimationRunning == false ) then
            isStepAnimationRunning = true
            
            if( step == 0 )then
                transition.to( addressInformationView, {time=400, y= -220,onComplete=doneStepAnimationNext,  transition = easing.outExpo } )
            end
        end
end

local function shiftDown()

        if( isStepAnimationRunning == false ) then
                isStepAnimationRunning = true
                if( step == 0 ) then
                        --Pop previous scene
                    local previousScene = storyboard.getPrevious()
                    storyboard.gotoScene(previousScene, "slideRight", 800 )
                elseif ( step == 1 ) then
                    addressInformationView:hideGroup(true)
                    transition.to( addressInformationView, {time=400, y= 220,onComplete=doneStepAnimationBack,  transition = easing.outExpo } )
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
        buttomWhiteMask:setFillColor( 1,0,0 )
        backButton = CButton.new( "GERİ", "backButton", self, 40, 700, 0 )
        nextButton = CButton.new( "DEVAM", "nextButton", self, 1100, 700, 0 )

        callCenterLogo = display.newImage( "Assets/CallCenter.png", 50, 750 )
        fibaLogo = display.newImage( "Assets/FibaGroup.png", 1030, 760 )
        --controlBar
        --progressBar
--------------------------------------------
        appointmentPlanningView = AppointmentPlanningView.new()
        --Test
        

--------------------------------------------
    
        addressInformationView = AddresInformationView.new()
        addressInformationView:hideGroup(true)

--------------------------------------------

		group:insert( logo )
                group:insert( controlBar )
                group:insert( appointmentPlanningView )
                group:insert( addressInformationView )
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

function scene:onButtonTouchEnded( event )
    if( event.target.id == "backButton" )then
        print("BACK BUTTON PRESSED")
        shiftDown()
    elseif( event.target.id == "nextButton" )then
        print("NEXT BUTTON PRESSED")
        if( step == 0 )then
            saveContent( kStepAppointment, function ( isSuccess, errorDetail )
                if( isSuccess ) then
                    shiftUp()
                else 
                    --Log error message
                end
            end)
        elseif( step == 1 )then
            --Add check for enterprise
            saveContent(kStepAddress, function( isSuccess, errrorDetail )
                if( isSuccess )then
                    shiftUp()
                else 

                end
            end)
        
        end
    end
    
end

function scene:isErrorCheckOk(responseData)
    if responseData.ErrorCode == "00" and responseData.ErrorDetail == nil then
        return true
    end
    
    return false
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

