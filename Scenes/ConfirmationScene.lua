local widget      = require "widget"
local display     = require "display"
local storyboard  = require "storyboard"
local BaseScene   = require "Scenes.BaseScene"
local ProgressBar = require "libs.ProgressBar.ProgressBar"
local CTextField  = require "Views.TextFields.CTextField"

-- GLOBAL MailType Enum
MailType = {
    MailTypeVerification = 1,
    MailTypeCustomerNumber = 4,
}

-- ConfirmationScene Module
local ConfirmationScene = BaseScene.new()

function ConfirmationScene:createScene( event )

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
    progressBar:setProgress(438)
    
    -- HEADER TEXT
    local bgHeaderText = display.newRoundedRect( 30, 170, 960, 40, 5 )
    bgHeaderText:setFillColor( cColorM(157, 20, 97, 1) )
    local headerText     = display.newText( "E-Posta Onaylama", 0, 0, native.systemFontBold, 18 )
    headerText:setFillColor( 1, 1, 1 )
    headerText.x, headerText.y = 40,180
    
    -- INFORMATION TEXT
    local informationText = display.newText("Mail ve SMS olarak gönderilen onay kodunu girerek başvurunuzu tamamlayınız", 
                                            display.contentWidth*0.5, 
                                            display.contentHeight*0.5 - 30, 
                                            1000, 
                                            100, 
                                            native.systemFont, 
                                            19)
    informationText.anchorX = 0.5
    informationText.anchorY = 0.5
    informationText:setFillColor(cColorM(165, 161, 155))
    
    -- CONFIRMATIN CODE TEXT
    local confirmationCodeText = display.newText("ONAY KODU", 
                                            display.contentWidth*0.5 - 182, 
                                            display.contentHeight*0.5 + 84, 
                                            200, 
                                            100, 
                                            native.systemFontBold, 
                                            28)
    confirmationCodeText.anchorX = 0.5
    confirmationCodeText.anchorY = 0.5
    confirmationCodeText:setFillColor(cColorM(0, 0, 0))
    
    -- VERIFICATION TEXT FIELD
    local verificationTextField = CTextField.new(display.contentWidth*0.5 - 320, 
                                                display.contentHeight*0.5 + 90)
    
    -- SEND AGAIN BUTTON
    local sendAgainButton = widget.newButton({left  = 318,
                                            top     = 530,
                                            width   = 105,
                                            height  = 29,
                                            label   = "TEKRAR GÖNDER",
                                            labelAlign = "left",
                                            labelColor = { default={ 0, 0, 0 }, over={ 1, 0, 0, 1 } },
                                            fontSize = 12,

                                            onEvent = function (event)                    
                                                            if event.phase == "ended" then
                                                                
                                                            end 
                                                      end,})
    
    -- VISUAL ENVELOPE
    local envelopeImage = display.newImage("Assets/VisualEnvelope.png", 
                                            system.ResourceDirectory, 
                                            150, 
                                            display.contentHeight*0.5)
    
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
                            local prevScene = storyboard.getPrevious()
                            storyboard.gotoScene(prevScene, "slideRight", 400)
                        end 
                  end,
    })
    
    group:insert(headerBar)
    group:insert(logo)
    group:insert(progressBar)
    group:insert(bgHeaderText)
    group:insert(headerText)
    group:insert(informationText)
    group:insert(confirmationCodeText)
    group:insert(verificationTextField)
    group:insert(envelopeImage)
    group:insert(sendAgainButton)
    
    group:insert(backButtonBg)
    group:insert(backButton)
    group:insert(nextButtonBg)
    group:insert(nextButton)
    
end
ConfirmationScene:addEventListener("createScene")

function ConfirmationScene:enterScene(event)
    
end
ConfirmationScene:addEventListener("enterScene")

function ConfirmationScene:didExitScene(event)
    
end
ConfirmationScene:addEventListener("didExitScene")

function ConfirmationScene:destroyScene(event)
    
end
ConfirmationScene:addEventListener("destroyScene")

return ConfirmationScene

