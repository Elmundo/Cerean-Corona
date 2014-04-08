local widget      = require "widget"
local display     = require "display"
local storyboard  = require "storyboard"
local BaseScene   = require "Scenes.BaseScene"
local ProgressBar = require "libs.ProgressBar.ProgressBar"
local CTextField  = require "Views.TextFields.CTextField"

-- FeedbackScene Module
local FeedbackScene = BaseScene.new()

function FeedbackScene:createScene( event )

    -- View of scene
    local group = self.view
    
    -- HEADER BAR
    local headerBar = display.newRect( 0, 0, 1024, 50 )
    headerBar:setFillColor( 74/255, 74/255, 74/255 )

    -- CEREAN LOGO
    local logo = display.newImage( "Assets/Logo.png" )
    logo.x, logo.y = 30, 70

    -- EPIC PROGRESS BAR 
    local progressBar = ProgressBar.new({x=280,y=66}, "Assets/ProgressBar.png", "Assets/ProgressBarMask.png")
    progressBar:setProgressWithPercentage(100)
    
    -- HEADER TEXT
    local bgHeaderText = display.newRoundedRect( 30, 170, 960, 40, 5 )
    bgHeaderText:setFillColor( cColorM(157, 20, 97, 1) )
    local headerText     = display.newText( "E-Posta Onaylama", 0, 0, native.systemFontBold, 18 )
    headerText:setFillColor( 1, 1, 1 )
    headerText.x, headerText.y = 40,180
    
    -- CONG IMAGE
    local congImage = display.newImage("Assets/Congrats.png", display.contentCenterX - 120, display.contentCenterY + 40)
    congImage.anchorX = 0.5
    congImage.anchorY = 0.5
    
    -- SCENE BUTTONS
    local backButtonBg = display.newRoundedRect( 30, 630, 105, 29, 0.5 )
    backButtonBg:setFillColor( 165/255, 161/255, 155/255 )
    local backButton = widget.newButton({
        left    = 30,
        top     = 630,
        width   = 105, 
        height  = 29,
        label   = "GERİ",
        labelAlign = "center",
        labelColor = { default={ 1, 1, 1 }, over={ 1, 0, 0, 0.5 } },
        emboss = true,
        onEvent = function (event)
                        if event.phase == "ended" then
                            local prevScene = storyboard.getPrevious()
                            --storyboard.gotoScene(prevScene, "slideRight", 400)
                            storyboard.gotoScene("Scenes.ConfirmationScene", "slideRight", 400)
                        end  
                  end,
    })
    
    local nextButtonBg = display.newRoundedRect( 885, 630, 105, 30, 0.5 )
    nextButtonBg:setFillColor( 165/255, 161/255, 155/255 )
    local nextButton = widget.newButton({
        left    = 885,
        top     = 630,
        width   = 105,
        height  = 29,
        label   = "DEVAM",
        labelAlign = "center",
        labelColor = { default={ 1, 1, 1 }, over={ 1, 0, 0, 0.5 } },
        emboss = true,
        onEvent = function (event)
                        if event.phase == "ended" then
                            -- Nowhere to go
                        end 
                  end,
    })
    
    group:insert(headerBar)
    group:insert(logo)
    group:insert(progressBar)
    group:insert(bgHeaderText)
    group:insert(headerText)
    group:insert(congImage)
    
    group:insert(backButtonBg)
    group:insert(backButton)
    group:insert(nextButtonBg)
    group:insert(nextButton)
    
end
FeedbackScene:addEventListener("createScene")

function FeedbackScene:enterScene(event)
    timer.performWithDelay(1000, 
                            function (event)
                                storyboard.gotoScene("Scenes.PackageScene", "slideRight", 400)
                            end, 
                            1)
end
FeedbackScene:addEventListener("enterScene")

function FeedbackScene:didExitScene(event)
    
end
FeedbackScene:addEventListener("didExitScene")

function FeedbackScene:destroyScene(event)
    
end
FeedbackScene:addEventListener("destroyScene")

return FeedbackScene

