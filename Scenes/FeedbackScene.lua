local widget      = require "widget"
local display     = require "display"
local storyboard  = require "storyboard"
local BaseScene   = require "Scenes.BaseScene"
local ProgressBar = require "libs.ProgressBar.ProgressBar"
local CTextField  = require "Views.TextFields.CTextField"
local DataService = require( "Network.DataService" )
local CButton = require "Views.Buttons.CButton"

-- FeedbackScene Module
local FeedbackScene = BaseScene.new()

function FeedbackScene:createScene( event )

    -- View of scene
    local group = self.view
    
    -- HEADER BAR
    local headerBar = display.newRect( 0, 0, 1280, 50 )
    headerBar:setFillColor( 74/255, 74/255, 74/255 )

    -- CEREAN LOGO
    local logo = display.newImage( "Assets/Logo.png" )
    logo.x, logo.y = 40, 70

    -- EPIC PROGRESS BAR 
    local progressBar = ProgressBar.new({x=290,y=66}, "Assets/ProgressBar.png", "Assets/ProgressBarMask.png")
    progressBar:setProgressWithPercentage(100)
    
    -- HEADER TEXT
    local bgHeaderText = display.newRoundedRect( 40, 170, 1200, 40, 5 )
    bgHeaderText:setFillColor( cColorM(157, 20, 97, 1) )
    local headerText     = display.newText( "E-Posta Onaylama", 0, 0, native.systemFontBold, 18 )
    headerText:setFillColor( 1, 1, 1 )
    headerText.x, headerText.y = 50,180
    
    -- CONG IMAGE
    local congImage = display.newImage("Assets/Congrats.png", display.contentCenterX, display.contentCenterY + 40)
    congImage.anchorX = 0.5
    congImage.anchorY = 0.5
    
    -- SCENE BUTTONS
    local backButton = CButton.new( "GERİ", "backButton", self, 40, 630, 0 )
    local nextButton = CButton.new( "DEVAM", "nextButton", self, 1100, 630, 0 )
    
    group:insert(headerBar)
    group:insert(logo)
    group:insert(progressBar)
    group:insert(bgHeaderText)
    group:insert(headerText)
    group:insert(congImage)
    
    --group:insert(backButtonBg)
    group:insert(backButton)
    --group:insert(nextButtonBg)
    group:insert(nextButton)
    
end
FeedbackScene:addEventListener("createScene")

function FeedbackScene:onButtonTouchEnded( event )
    
    if( event.target.id == "backButton" )then
        
    elseif( event.target.id == "nextButton" )then
        
    end
end

function FeedbackScene:enterScene(event)
    
    timer.performWithDelay(1000, 
                            function (event)
                                DataService:resetCachedData()
                                storyboard.purgeAll()
                                storyboard.gotoScene("Scenes.MenuScene", "slideRight", 400)
                            end, 
                            1)
end
FeedbackScene:addEventListener("enterScene")

function FeedbackScene:didExitScene(event)
    native.setKeyboardFocus(nil)
end
FeedbackScene:addEventListener("didExitScene")

function FeedbackScene:destroyScene(event)
    
end
FeedbackScene:addEventListener("destroyScene")

return FeedbackScene

