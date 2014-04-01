local display   = require "display"
local BaseScene = require "BaseScene"
local widget = require "widget"
local ProgressBar = require "libs.ProgressBar.ProgressBar"

local PackageScene = {}

function PackageScene.new()

    local packageScene = BaseScene.new()

    function packageScene:init( )
        local group = display.newGroup( )

        local headerBar = display.newRect( 0, 0, 1024, 50 )
        headerBar:setFillColor( 74/255, 74/255, 74/255 )

        local logo = display.newImage( "Assets/Logo.png" )
        logo.x, logo.y = 30, 70

        local progressBar = ProgressBar.new({x=280,y=55}, "Assets/ProgressBar.png", "Assets/ProgressBarMask.png")

        local bgHeaderText = display.newRoundedRect( 30, 220, 960, 40, 5 )
        bgHeaderText:setFillColor( 1,0,0 )
        local headerText     = display.newText( "Size Özel Paketler", 0, 0, native.systemFontBold, 18 )
        headerText:setFillColor( 1, 1, 1 )
        headerText.x, headerText.y = 40,230

        local promotionText  = display.newText( "PROMOSYON KODU", 0, 50, native.systemFont, 24 )
        promotionText:setFillColor( 0,0,0 )
        promotionText.x, promotionText.y = 30,290

        local promotionImage = display.newImage("Assets/VisualSelectTariff.png")
        promotionImage.x = 700
        promotionImage.y = 265

        local promotionScrollerBg = display.newRect( 30, 330, 640, 284 )
        promotionScrollerBg:setFillColor(1,0,0)

        local backButtonBg = display.newRoundedRect( 30, 630, 105, 29, 0.5 )
        backButtonBg:setFillColor( 165/255, 161/255, 155/255 )

        local nextButtonBg = display.newRoundedRect( 885, 630, 105, 30, 0.5 )
        nextButtonBg:setFillColor( 165/255, 161/255, 155/255 )

    end

    return packageScene
end

return PackageScene