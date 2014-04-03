local display         = require "display"
local BaseScene       = require "Scenes.BaseScene"
local widget          = require "widget"
local storyboard      = require "storyboard"
local ProgressBar     = require "libs.ProgressBar.ProgressBar"
local PackageScroller = require "Views.PackageScroller"
local PackageView     = require "Views.PackageDetail"
local Utils           = require "libs.Util.Utils"

-- PackageScene Module
local PackageScene    = BaseScene.new()

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
    local progressBar = ProgressBar.new({x=280,y=66}, "Assets/ProgressBar.png", "Assets/ProgressBarMask.png")
    progressBar:setProgress(242)
    
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
        
    -- PACKAGE DETAIL
    local packageDetail = PackageView.new()
    packageDetail.x = 700
    packageDetail.y = 265
    PackageScene.packageDetail = packageDetail
   
    -- PROMOTION TABLE - SCROLLER
    local packageScroller  = PackageScroller.new({}, {  x               = 30,
                                                        y               = 330,
                                                        width           = 640,
                                                        height          = 284,
                                                        scrollWidth     = 640,
                                                        scrollHeight    = 284,
                                                        backgroundColor = cColor(255, 255, 255, 1),
                                                        horizontalScrollDisabled = true,
                                                        delegate = self,
                                                        })
    -- TODO: Set dummy data for scroller                                                    
    packageScroller:setMyScroller({1,2,3,4,5,6,7,8,9,10})

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
                        print "Pressed back button"
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
                            storyboard.gotoScene("Scenes.ConfirmationScene", "slideLeft", 400 )
                        end 
                  end,
    })
    
    group:insert(headerBar)
    group:insert(logo)
    group:insert(progressBar)
    group:insert(bgHeaderText)
    group:insert(headerText)
    group:insert(promotionText)
    group:insert(packageDetail)
    group:insert(packageScroller)
    group:insert(backButtonBg)
    group:insert(backButton)
    group:insert(nextButtonBg)
    group:insert(nextButton)
    
end
PackageScene:addEventListener("createScene")

function PackageScene:enterScene(event)
    
end
PackageScene:addEventListener("enterScene")

function PackageScene:didExitScene(event)
    
end
PackageScene:addEventListener("didExitScene")

function PackageScene:destroyScene(event)
    
end
PackageScene:addEventListener("destroyScene")

-- Package Delegate
function PackageScene:didPackageSelect( package )
    print "We are here now!"
    self.packageDetail:hideMask()
end

return PackageScene