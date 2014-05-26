local widget      = require "widget"
local display     = require "display"
local storyboard  = require "storyboard"
local BaseScene   = require "Scenes.BaseScene"
local ProgressBar = require "libs.ProgressBar.ProgressBar"
local CTextField  = require "Views.TextFields.CTextField"
local DataService = require "Network.DataService"
local Logger      = require "libs.Log.Logger"

local CButton = require "Views.Buttons.CButton"

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
local function setFocus ( yPos )
    transition.to(ConfirmationScene.view, {time=400, y= yPos, transition = easing.outExpo})
end 

local function onSceneTouch( event )
    if( "began" == event.phase )then
        if( event.target.isKeyboard )then
        else
            setFocus(0)
            native.setKeyboardFocus(nil)
        end
            
    end
end

function ConfirmationScene:onInputBegan( event )
        
    setFocus(-330)
        
end
        
function ConfirmationScene:onInputEdit( event )
    
end

function ConfirmationScene:onInputEnd( event )
    --scene:alert("SetFocus TEST", "SettingFocusTo 0")
    setFocus(0)
end

function ConfirmationScene:onButtonTouchEnded( event )
    
    if( event.target.id == "backButton" )then
        storyboard.gotoScene("Scenes.AppointmentScene", "slideRight", 400)
    elseif( event.target.id == "nextButton" )then
        ConfirmationScene:saveContent(step, function (success, errorDetail)
            if success then
                ConfirmationScene:sendCustomerNumberMail()
                storyboard.gotoScene("Scenes.FeedbackScene", "slideLeft", 400)
            else
                Logger:debug(ConfirmationScene, "ConfirmationScene.onNextButton", "Step 6 is failure!")
                ConfirmationScene:alert("UYARI!", errorDetail, {"OK"})
            end
            
        end)
    end
end
-- Network Error handler, check type 2
function ConfirmationScene:isErrorCheckOk(responseData)
    if responseData.ErrorCode == "00" and responseData.ErrorDetail == nil then
        return true
    end
    
    return false
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
    headerBar = display.newRect( 0, 0, 1280, 50 )
    headerBar:setFillColor( 74/255, 74/255, 74/255 )

    -- CEREAN LOGO
    logo = display.newImage( "Assets/Logo.png" )
    logo.x, logo.y = 40, 70

    -- EPIC PROGRESS BAR 
    progressBar = ProgressBar.new({x=290,y=66}, "Assets/ProgressBar.png", "Assets/ProgressBarMask.png")
    progressBar:setProgressWithPercentage(100)
    
    -- HEADER TEXT
    bgHeaderText = display.newRoundedRect( 40, 170, 1200, 40, 5 )
    bgHeaderText:setFillColor( cColorM(157, 20, 97, 1) )
    headerText     = display.newText( "E-Posta Onaylama", 0, 0, native.systemFontBold, 18 )
    headerText:setFillColor( 1, 1, 1 )
    headerText.x, headerText.y = 50,180
    
    -- INFORMATION TEXT
    informationText = display.newText("Mail ve SMS olarak gönderilen onay kodunu girerek başvurunuzu tamamlayınız", 
                                            display.contentWidth*0.5+150, 
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
                                            display.contentWidth*0.5, 
                                            display.contentHeight*0.5 + 84, 
                                            200, 
                                            100, 
                                            native.systemFontBold, 
                                            28)
    confirmationCodeText.anchorX = 0.5
    confirmationCodeText.anchorY = 0.5
    confirmationCodeText:setFillColor(cColorM(0, 0, 0))
    
    -- VERIFICATION TEXT FIELD
    verificationTextField = CTextField.new(display.contentWidth*0.5 - 120, 
                                                display.contentHeight*0.5 + 90, 240, 40)
    verificationTextField:setDelegate(self, "verificationTextField")            
    verificationTextField:setKeyboardType("number")
    
    -- SEND AGAIN BUTTON
    sendAgainButton = display.newRoundedRect(520, 495, 105, 29, 3)
    sendAgainButton:setFillColor(0.5, 1)
    sendAgainButton:addEventListener("touch", function(event)
                                                if( event.phase == "ended" )then
                                                    sendAgainButton:setFillColor(0.5, 1)
                                                    self:resendMail()
                                                elseif( event.phase == "began" )then
                                                    sendAgainButton:setFillColor(0.5, 0.5)
                                                elseif( event.phase == "moved")then
                                                    sendAgainButton:setFillColor(0.5, 1)
                                                end
                                             end)
                                             
    local sendAgainText = display.newText("TEKRAR GÖNDER", 530, 500, native.systemFont, 10)
    --[[]
    sendAgainButton = widget.newButton({left  = 520,
                                            top     = 485,
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
                                                      end,})--]]
    
    -- VISUAL ENVELOPE
    envelopeImage = display.newImage("Assets/VisualEnvelope.png", 
                                            system.ResourceDirectory, 
                                            350, 
                                            display.contentHeight*0.5)
    
    -- SCENE BUTTONS
    backButton = CButton.new( "GERİ", "backButton", self, 40, 630, 0 )
    nextButton = CButton.new( "DEVAM", "nextButton", self, 1100, 630, 0 )
    
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
    group:insert(sendAgainText)
    
    --group:insert(backButtonBg)
    group:insert(backButton)
    --group:insert(nextButtonBg)
    group:insert(nextButton)
    
end

local superEnterScene = ConfirmationScene.enterScene
function ConfirmationScene:enterScene(event)
    --Call parent enterScene method
    superEnterScene(self, event)
    ConfirmationScene:sendMail()
    ConfirmationScene.view:addEventListener("touch", onSceneTouch)
end


function ConfirmationScene:didExitScene(event)
    ConfirmationScene.view:removeEventListener("touch", onSceneTouch)
    native.setKeyboardFocus(nil)
end


function ConfirmationScene:destroyScene(event)
    
end


ConfirmationScene:addEventListener("createScene")
ConfirmationScene:addEventListener("enterScene")
ConfirmationScene:addEventListener("didExitScene")
ConfirmationScene:addEventListener("destroyScene")

return ConfirmationScene

