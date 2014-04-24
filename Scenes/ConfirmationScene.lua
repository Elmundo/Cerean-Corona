local widget      = require "widget"
local display     = require "display"
local storyboard  = require "storyboard"
local BaseScene   = require "Scenes.BaseScene"
local ProgressBar = require "libs.ProgressBar.ProgressBar"
local CTextField  = require "Views.TextFields.CTextField"
local DataService = require "Network.DataService"
local Logger      = require "libs.Log.Logger"

-- GLOBAL MailType Enum
MailType = {
    MailTypeVerification = "1",
    MailTypeCustomerNumber = "4",
}

-- ConfirmationScene Module
local ConfirmationScene = BaseScene.new()

-- Properties
local step = -1

-- Widget Properties
local headerBar
local logo
local progressBar
local bgHeaderText
local headerText
local informationText
local confirmationCodeText
local verificationTextField
local sendAgainButton
local envelopeImage
local backButtonBg
local backButton
local nextButtonBg
local nextButton

-- METHODS

-- Network Error handler, check type 2
function ConfirmationScene:isErrorCheckOk(responseData)
    if responseData.ErrorCode == "00" and responseData.ErrorDetail == nil then
        return true
    end
    
    return false
end

local function onNextButton(event)
    if event.phase == "ended" then
        ConfirmationScene:saveContent(step, function (success, errorDetail)
            if success then
                ConfirmationScene:sendCustomerNumberMail()
                storyboard.gotoScene("Scenes.FeedbackScene", "slideLeft", 400)
            else
                Logger:debug(self, "ConfirmationScene.onNextButton", "Step 6 is failure!")
                ConfirmationScene:alert("UYARI!", errorDetail, {"OK"})
            end
            
        end)
        
    end
end

local function onBackButton(event)
    if event.phase == "ended" then
        local prevScene = storyboard.getPrevious()
        --storyboard.gotoScene(prevScene, "slideRight", 400)
        storyboard.gotoScene("Scenes.AppointmentScene", "slideRight", 400)
    end   
end

function ConfirmationScene:sendMail()
    
    local contentData
    
    if DataService.phase == Phase.RegistryPhase then
        contentData = {
            Name = DataService.customer.customerName,
            Sms = DataService.customer.customerPhone,
            Email = DataService.customer.customerEmail,
            VerificationCode = DataService.customer.verificationCode,
        }
    else
        contentData = {
            Name = DataService.customerName,
            Sms = DataService.customerPhone,
            Email = DataService.customerEmail,
            VerificationCode = DataService.verificationCode,
        }
    end
    DataService:sendMail("1", contentData, function (responseData)
        if ConfirmationScene:isErrorCheckOk(responseData) == false then
            ConfirmationScene:alert("UYARI!", responseData.responseDetail, "OK")
        end
    end, function (errorData)
        Logger:error(self, "ConfirmationScene:sendMail", errorData)
        ConfirmationScene:alert("UYARI!", "Mail gönderme istediğinde hata oluştu!", "OK")
    end)
    --[[]
    DataService:sendMail(MailType.MailTypeVerification, contentData, function (responseData)
        if ConfirmationScene:isErrorCheckOk(responseData) == false then
            ConfirmationScene:alert("UYARI!", responseData.responseDetail, "OK")
        end
    end, function (errorData)
        Logger:error(self, "ConfirmationScene:sendMail", errorData)
        ConfirmationScene:alert("UYARI!", "Mail gönderme istediğinde hata oluştu!", "OK")
    end)
    --]]
end

function ConfirmationScene:sendCustomerNumberMail()
    
    local contentData
    
    if DataService.phase == Phase.CallPhase then
        contentData = {
            Name = DataService.customerName,
            Sms = DataService.customerPhone,
            Email = DataService.customerEmail,
            meterserialnumber = "",
            CustomerNumber = DataService.customerNumber,
        }
    elseif DataService.phase == Phase.RegistryPhase then
        contentData = {
            Name = DataService.customer.customerName,
            Sms = DataService.customer.customerPhone,
            Email = DataService.customerEmail,
            meterserialnumber = DataService.meterSerialNumber,
            CustomerNumber = DataService.customerNumber,
        }
    elseif DataService.phase == Phase.ApplicationPhase then
        contentData = {
            Name = DataService.customerName,
            Sms = DataService.customerPhone,
            Email = DataService.customerEmail,
            meterserialnumber = DataService.meterSerialNumber,
            CustomerNumber = DataService.customerNumber,
        }
    end
    
    DataService:sendMail(MailType.MailTypeCustomerNumber, contentData, function (responseData)
        if ConfirmationScene:isErrorCheckOk(responseData) == false then
            ConfirmationScene:alert("UYARI!", responseData.responseDetail, "OK")
        end
    end, function (errorData)
        Logger:error(self, "ConfirmationScene:sendCustomerNumberMail", errorData)
        ConfirmationScene:alert("UYARI!", "Müşteri mail gönderme istediğinde hata oluştu!", "OK")
    end)
end

function ConfirmationScene:resendMail()
    self:sendMail()
end

function ConfirmationScene:getContent()
    local content = {}
    
    if DataService.phase == Phase.CallPhase then
        content = {
            WebFormPage = DataService.webFormPage,
            VerificationCode = verificationTextField:getText(),
            CustomerId = DataService.customerId,
            MeterId = "",
            QuoteId = "",
            AppointmentId = DataService.appointmentId,
            AddressIdVisiting = DataService.addressIdVisiting,
        }
    elseif DataService.phase == Phase.RegistryPhase then
        content = {
            WebFormPage = DataService.webFormPage,
            VerificationCode = verificationTextField:getText(),
            CustomerId = DataService.customerId,
            MeterId = DataService.meterId,
            QuoteId = DataService.quoteId,
            AppointmentId = DataService.appointmentId,
            AddressIdVisiting = DataService.addressIdVisiting,
        }
    elseif DataService.phase == Phase.ApplicationPhase then
        content = {
            WebFormPage = DataService.webFormPage,
            VerificationCode = verificationTextField:getText(),
            CustomerId = DataService.customerId,
            MeterId = DataService.meterId,
            QuoteId = DataService.quoteId,
            AppointmentId = DataService.appointmentId,
            AddressIdVisiting = DataService.addressIdVisiting,
        }
    end
    return content
end

function ConfirmationScene:saveContent(step, callback)
    local contentData = self:getContent()
    contentData["step"] = step 
    DataService:saveContent(contentData, function (responseData)
        if ConfirmationScene:isErrorCheckOk(responseData) then
            Logger:debug(self, "ConfirmationScene:saveContent", "Step 6 is success!")
            DataService.customerId = responseData.CustomerId
            DataService.customerNumber = responseData.CustomerNumber
            callback(true, nil)
        else
            Logger:debug(self, "ConfirmationScene:saveContent", "Step 6 is failure!")
            callback(false, responseData.ErrorDetail)
        end
    end, function (errorData)
        Logger:debug(self, "ConfirmationScene:saveContent", "Step 6 is failure!")
        callback(false, errorData.Description)
    end)
    
end

function ConfirmationScene:createScene( event )

    step = kStepConfirmation

    -- View of scene
    local group = self.view
    
    -- HEADER BAR
    headerBar = display.newRect( 0, 0, 1024, 50 )
    headerBar:setFillColor( 74/255, 74/255, 74/255 )

    -- CEREAN LOGO
    logo = display.newImage( "Assets/Logo.png" )
    logo.x, logo.y = 30, 70

    -- EPIC PROGRESS BAR 
    progressBar = ProgressBar.new({x=280,y=66}, "Assets/ProgressBar.png", "Assets/ProgressBarMask.png")
    progressBar:setProgressWithPercentage(100)
    
    -- HEADER TEXT
    bgHeaderText = display.newRoundedRect( 30, 170, 960, 40, 5 )
    bgHeaderText:setFillColor( cColorM(157, 20, 97, 1) )
    headerText     = display.newText( "E-Posta Onaylama", 0, 0, native.systemFontBold, 18 )
    headerText:setFillColor( 1, 1, 1 )
    headerText.x, headerText.y = 40,180
    
    -- INFORMATION TEXT
    informationText = display.newText("Mail ve SMS olarak gönderilen onay kodunu girerek başvurunuzu tamamlayınız", 
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
    confirmationCodeText = display.newText("ONAY KODU", 
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
    verificationTextField = CTextField.new(display.contentWidth*0.5 - 320, 
                                                display.contentHeight*0.5 + 90, 240, 40)
    
    -- SEND AGAIN BUTTON
    sendAgainButton = widget.newButton({left  = 318,
                                            top     = 530,
                                            width   = 105,
                                            height  = 29,
                                            label   = "TEKRAR GÖNDER",
                                            labelAlign = "left",
                                            labelColor = { default={ 0, 0, 0 }, over={ 1, 0, 0, 1 } },
                                            fontSize = 12,

                                            onEvent = function (event)                    
                                                            if event.phase == "ended" then
                                                                self:resendMail()
                                                            end 
                                                      end,})
    
    -- VISUAL ENVELOPE
    envelopeImage = display.newImage("Assets/VisualEnvelope.png", 
                                            system.ResourceDirectory, 
                                            150, 
                                            display.contentHeight*0.5)
    
    -- SCENE BUTTONS
    backButtonBg = display.newRoundedRect( 30, 630, 105, 29, 0.5 )
    backButtonBg:setFillColor( 165/255, 161/255, 155/255 )
    backButton = widget.newButton({
        left    = 30,
        top     = 630,
        width   = 105, 
        height  = 29,
        label   = "GERİ",
        labelAlign = "center",
        labelColor = { default={ 1, 1, 1 }, over={ 1, 0, 0, 0.5 } },
        emboss = true,
        onEvent = onBackButton
    })
    
    nextButtonBg = display.newRoundedRect( 885, 630, 105, 30, 0.5 )
    nextButtonBg:setFillColor( 165/255, 161/255, 155/255 )
    nextButton = widget.newButton({
        left    = 885,
        top     = 630,
        width   = 105,
        height  = 29,
        label   = "DEVAM",
        labelAlign = "center",
        labelColor = { default={ 1, 1, 1 }, over={ 1, 0, 0, 0.5 } },
        emboss = true,
        onEvent = onNextButton
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

local superEnterScene = ConfirmationScene.enterScene
function ConfirmationScene:enterScene(event)
    --Call parent enterScene method
    superEnterScene(self, event)
    ConfirmationScene:sendMail()
end


function ConfirmationScene:didExitScene(event)
    
end


function ConfirmationScene:destroyScene(event)
    
end


ConfirmationScene:addEventListener("createScene")
ConfirmationScene:addEventListener("enterScene")
ConfirmationScene:addEventListener("didExitScene")
ConfirmationScene:addEventListener("destroyScene")

return ConfirmationScene

