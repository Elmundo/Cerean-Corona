local display     = require "display"
local BaseScene   = require "Scenes.BaseScene"
local widget      = require "widget"
local ProgressBar = require "libs.ProgressBar.ProgressBar"

local PackageScene = BaseScene.new()

function PackageScene:createScene( event )

    -- View of scene
    local group = self.view

    -- HEADER BAR
    local headerBar = display.newRect( 0, 0, 1024, 50 )
    headerBar:setFillColor( 74/255, 74/255, 74/255 )

    -- CEREAN LOGO
    local logo = display.newImage( "Assets/Logo.png" )
    logo.x, logo.y = 30, 70

    -- EPIC PROGRESS BAR 
    local progressBar = ProgressBar.new({x=280,y=55}, "Assets/ProgressBar.png", "Assets/ProgressBarMask.png")

    -- HEADER TEXT
    local bgHeaderText = display.newRoundedRect( 30, 220, 960, 40, 5 )
    bgHeaderText:setFillColor( 1,0,0 )
    local headerText     = display.newText( "Size Özel Paketler", 0, 0, native.systemFontBold, 18 )
    headerText:setFillColor( 1, 1, 1 )
    headerText.x, headerText.y = 40,230

    -- PROMOTION TEXT
    local promotionText  = display.newText( "PROMOSYON KODU", 0, 50, native.systemFont, 24 )
    promotionText:setFillColor( 0,0,0 )
    promotionText.x, promotionText.y = 30,290
        
    -- PROMOTION IMAGE
    local promotionImage = display.newImage("Assets/VisualSelectTariff.png")
    promotionImage.x = 700
    promotionImage.y = 265

    -- PROMOTION TABLE - SCROLLER
    local promotionScrollerBg = display.newRect( 30, 330, 640, 284 )
    promotionScrollerBg:setFillColor(1,0,0)

    -- SCENE BUTTONS
    local backButtonBg = display.newRoundedRect( 30, 630, 105, 29, 0.5 )
    backButtonBg:setFillColor( 165/255, 161/255, 155/255 )
    local nextButtonBg = display.newRoundedRect( 885, 630, 105, 30, 0.5 )
    nextButtonBg:setFillColor( 165/255, 161/255, 155/255 )
    
    group:insert(headerBar)
    group:insert(logo)
    group:insert(progressBar)
    group:insert(bgHeaderText)
    group:insert(headerText)
    group:insert(promotionText)
    group:insert(promotionImage)
    group:insert(promotionScrollerBg)
    group:insert(backButtonBg)
    group:insert(nextButtonBg)
end
PackageScene:addEventListener("createScene")

function PackageScene:enterScene(event)
    
end
PackageScene:addEventListener("enterScene")
function PackageScene:didExitScene(event)
    
end

function PackageScene:destroyScene(event)
    
end

return PackageScene