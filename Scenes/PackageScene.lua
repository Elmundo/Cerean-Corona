local display         = require "display"
local BaseScene       = require "Scenes.BaseScene"
local widget          = require "widget"
local storyboard      = require "storyboard"
local ProgressBar     = require "libs.ProgressBar.ProgressBar"
local PackageScroller = require "Views.PackageScroller"
local PackageDetail     = require "Views.PackageDetail"
local Utils           = require "libs.Util.Utils"
local DataService     = require "Network.DataService"
local Logger          = require "libs.Log.Logger"

local CTextField = require "Views.TextFields.CTextField"
local CButton = require "Views.Buttons.CButton"
local ControlBar = require "Views.ControlBar"
-- PackageScene Module
local PackageScene    = BaseScene.new()

-- Properties
local step = kStepPackage
local selectedProduct = nil
local products = nil
local dataList = nil

-- Widget Properties 
local headerBar
local logo
local progressBar
local bgHeaderText
local headerText
local promotionText
local promotionTextField
local usedPackageText
local packageDetail
local packageScroller
local backButtonBg
local backButton
local nextButtonBg
local cancelButton
local nextButton
local usedPackage
-- METHODS
function PackageScene:onButtonTouchEnded( event )
    
    if( event.target.id == "backButton" )then
        print("BACK BUTTON PRESSED")
        if( DataService.phase == Phase.EditPhase )then
            storyboard.gotoScene("Scenes.SearchMeterScene", "slideRight", 400 )
        else
            storyboard.gotoScene("Scenes.SubscriptionScene", "slideRight", 400 )    
        end
                
    elseif( event.target.id == "nextButton" )then
        print("NEXT BUTTON PRESSED")
        if selectedProduct == nil then
            --TODO: Buarada hata mesajı verdir. 
        end
        
        PackageScene:saveContent(step, function (success, errorDetail)
            if success then
                storyboard.gotoScene("Scenes.AppointmentScene", "slideLeft", 400 )
            else
                Logger:error(PackageScene, "PackageScene:saveContent", errorDetail)
                PackageScene:alert("UYARI!", errorDetail, {"OK"})
            end
            
        end)
        
    end
end
        
function PackageScene:logout()
    storyboard.removeAll()
    DataService:resetCachedData()
    storyboard.gotoScene("Scenes.LoginScene", "slideRight", 800)
end
        
function PackageScene:onInputBegan( event )
        
end
        
function PackageScene:onInputEdit( event )
    
end

function PackageScene:onInputEnd( event )

end

local function onSceneTouch( event )
    if( "began" == event.phase )then
        if( event.target.isKeyboard )then
            
        else
            native.setKeyboardFocus(nil)
        end
            
    end
end

-- Network Error handler, check type 2
function PackageScene:isErrorCheckOk(responseData)
    if responseData.ErrorCode == "00" and responseData.ErrorDetail == nil then
        return true
    end
    
    return false
end

function PackageScene:createDummyProductList()
    
    local list = {}
    
    for i= 1, 10 do
        local productData = {
            Name = "TICARETHANE UZUN",
            Detail = "TARİFE DÖNEMİ BOYUNCA TEDAŞ BİRİM FİYATINA 1.4% İNDİRİM YAPILACAK ŞEKİLDE ELEKTRİK ENERJİSİ TEMİN EDİLECEKTİR",
            StartDate = "12.12.2014",
            EndDate = "12.12.2015", 
        }
        
        list[i] = productData
    end
    
    return list
end

function PackageScene:getCombinedDateString(startDate, endDate)
    
    local startDateNewFormat = os.date("%d.%m.%Y", startDate)
    local endDateNewFormat = os.date("%d.%m.%Y", endDate)
    
    local combinedDate = startDateNewFormat .. " - " .. endDateNewFormat
    
    return combinedDate
end

function PackageScene:saveContent(step, callback)
    
    local contentData
    
    local promotionCode =  promotionTextField:getText()
    if promotionCode == nil then
        promotionCode = ""
    end

    if DataService.phase == Phase.RegistryPhase then
        
        contentData = {
            WebFormPage = DataService.webFormPage,
            ProductId = selectedProduct.ProductId,
            PromotionCode = promotionCode,
            CustomerId = DataService.customerId,
            MeterId = DataService.meterId,
        }
    else
        contentData = {
            WebFormPage = DataService.webFormPage,
            ProductId = selectedProduct.ProductId,
            PromotionCode = promotionCode,
            CustomerId = DataService.customerId,
            MeterId = DataService.meterId,
            UserCode = DataService.userId,
        }
    end
    
    contentData.step = step
    
    if DataService.productId == "" then
        --contentData.QuoteId = DataService.quoteId 
    end
    
    DataService:saveContent(contentData, function (responseData)
    
        if PackageScene:isErrorCheckOk(responseData) then
            Logger:debug(PackageScene, "PackageScene:saveContent", "Step Package is success!")
            DataService.customerId = responseData.CustomerId
            DataService.productId  = responseData.ProductId
            DataService.quoteId    = responseData.QuoteId
            callback(true, nil)
        else
            Logger:debug(PackageScene, "PackageScene:saveContent", "Step Package is failure!")
            callback(false, responseData.ErrorMessage)
        end
        
    end, function (errorData)
        Logger:debug(PackageScene, "PackageScene:saveContent", "Step Package is failure!")
        callback(false, errorData.Description)
    end)
end

-- Button Methods 
function PackageScene.onNextButton(event)
    if event.phase == "ended" then
        if selectedProduct == nil then
            --TODO: Buarada hata mesajı verdir. 
        end
        
        PackageScene:saveContent(step, function (success, errorDetail)
            if success then
                storyboard.gotoScene("Scenes.AppointmentScene", "slideLeft", 400 )
            else
                Logger:error(PackageScene, "PackageScene:saveContent", errorDetail)
                PackageScene:alert("UYARI!", errorDetail, {"OK"})
            end
            
        end)
        
    end
end

function PackageScene.onBackButton(event)
    if event.phase == "ended" then
        storyboard.gotoScene("Scenes.SubscriptionScene", "slideRight", 400 )
    end
end
local function arrangeProducts(productList)
    local returnList = {}
    for i=1, #productList do
        if( productList[i].IsUsed == true )then
            usedPackage = productList[i]
            usedPackageText = display.newText( DataService.customer.CustomerName .."/".. usedPackage.Name .. "/" .. usedPackage.TotalOpenAmount .. "/" .. usedPackage.EndDate, 0, 50, native.systemFont, 18 )
            usedPackageText:setFillColor( 0,0,0 ) 
            usedPackageText.x, usedPackageText.y = 300, 260
            --group:insert(usedPackageText )
        else
            table.insert( returnList, productList[i])
        end
    end
    return returnList
end

function PackageScene:createScene( event)
    if( DataService.phase == Phase.EditPhase )then
        products = arrangeProducts( DataService.products )
    else
        products = DataService.products
    end
    --products = self:createDummyProductList()
    
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
    progressBar:setProgress(242)
    
    -- HEADER TEXT
    bgHeaderText = display.newRoundedRect( 40, 220, 1200, 40, 5 )
    bgHeaderText:setFillColor( 1,0,0 )
    headerText     = display.newText( "Size Özel Paketler", 0, 0, native.systemFontBold, 18 )
    headerText:setFillColor( 1, 1, 1 )
    headerText.x, headerText.y = 50,230

    -- PROMOTION TEXT
    promotionText  = display.newText( "PROMOSYON KODU", 0, 50, native.systemFont, 24 )
    promotionText:setFillColor( 0,0,0 )
    promotionText.x, promotionText.y = 40,260
    promotionTextField = CTextField.new( 40, 290, 240, 40 ) 
    promotionTextField:setDelegate(self, "promotionText")
    -- used
    if( DataService.phase == Phase.EditPhase)then
        --usedPackageText = display.newText( "Test", 0, 50, native.systemFont, 24 )
        --usedPackageText:setFillColor( 0,0,0 )
        --usedPackageText.x, usedPackageText.y = 300, 260
        cancelButton = CButton.new( "VAZGEÇ", "cancelButton", self, 200, 630, 0 )
        if( usedPackageText )then
            group:insert( usedPackageText )
        end
        group:insert( cancelButton )
    end
    -- PACKAGE DETAIL
    packageDetail = PackageDetail.new()
    packageDetail.x = 950
    packageDetail.y = 265
    PackageScene.packageDetail = packageDetail
   
    -- PROMOTION TABLE - SCROLLER
    packageScroller  = PackageScroller.new({            x               = 40,
                                                        y               = 330,
                                                        width           = 640,
                                                        height          = 284,
                                                        scrollWidth     = 640,
                                                        scrollHeight    = 284,
                                                        backgroundColor = cColor(255, 255, 255, 1),
                                                        horizontalScrollDisabled = true,
                                                        delegate = self,
                                                        products = products,
                                                        })
    -- SCENE BUTTONS
    backButton = CButton.new( "GERİ", "backButton", self, 40, 630, 0 )
    nextButton = CButton.new( "DEVAM", "nextButton", self, 1100, 630, 0 )
    --[[]
    backButtonBg = display.newRoundedRect( 40, 630, 105, 29, 0.5 )
    backButtonBg:setFillColor( 165/255, 161/255, 155/255 )
    backButton = widget.newButton({
        left    = 40,
        top     = 630,
        width   = 105,
        height  = 29,
        label   = "GERİ",
        labelAlign = "center",
        labelColor = { default={ 1, 1, 1 }, over={ 1, 0, 0, 0.5 } },
        emboss = true,
        onEvent = self.onBackButton,
    })
    --]]
    --[[]
    nextButtonBg = display.newRoundedRect( 1135, 630, 105, 30, 0.5 )
    nextButtonBg:setFillColor( 165/255, 161/255, 155/255 )
    nextButton = widget.newButton({
        left    = 1135,
        top     = 630,
        width   = 105,
        height  = 29,
        label   = "DEVAM",
        labelAlign = "center",
        labelColor = { default={ 1, 1, 1 }, over={ 1, 0, 0, 0.5 } },
        emboss = true,
        onEvent = self.onNextButton,
    })
    --]]
    group:insert(headerBar)
    group:insert(logo)
    group:insert(progressBar)
    group:insert(bgHeaderText)
    group:insert(headerText)
    group:insert(promotionText)
    group:insert(promotionTextField)
    group:insert(packageDetail)
    group:insert(packageScroller)
    --group:insert(backButtonBg)
    group:insert(backButton)
    --group:insert(nextButtonBg)
    group:insert(nextButton)
end
PackageScene:addEventListener("createScene")

-- 
local superEnterScene = PackageScene.enterScene
function PackageScene:enterScene(event)
    -- Call superclass method
    superEnterScene(self, event)
    PackageScene.view:addEventListener("touch", onSceneTouch)
end

PackageScene:addEventListener("enterScene")

function PackageScene:didExitScene(event)
   PackageScene.view:removeEventListener("touch", onSceneTouch) 
   native.setKeyboardFocus(nil)
end
PackageScene:addEventListener("didExitScene")

function PackageScene:destroyScene(event)
    
end
PackageScene:addEventListener("destroyScene")

-- Package Delegate
function PackageScene:didPackageSelect( packageView )

    selectedProduct = packageView.product
    
    --TODO: Baris Open this line when working real data, not dummy ones
    --selectedProduct.CombinedDate = self:getCombinedDateString(packageView.StartDate, packageView.EndDate)
    
    self.packageDetail:setPackageDetail(selectedProduct)
    -- TODO: Set the PackageDetail when it is ready
    self.packageDetail:hideMask()
end

return PackageScene