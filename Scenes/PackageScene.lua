local display         = require "display"
local BaseScene       = require "Scenes.BaseScene"
local widget          = require "widget"
local storyboard      = require "storyboard"
local ProgressBar     = require "libs.ProgressBar.ProgressBar"
local PackageScroller = require "Views.PackageScroller"
local PackageView     = require "Views.PackageDetail"
local Utils           = require "libs.Util.Utils"
local DataService     = require "Network.DataService"

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
local bgHeaderTex
local promotionText
local packageDetail
local packageScroller

-- METHODS
function PackageScene:createDummyProductList()
    
    local list = {}
    
    for i= 1, 10 do
        productData = {
            name = "ENDEKSLİ " .. i,
            detail = "TARİFE DÖNEMİ BOYUNCA TEDAŞ BİRİM FİYATINA 1.4% İNDİRİM YAPILACAK ŞEKİLDE ELEKTRİK ENERJİSİ TEMİN EDİLECEKTİR",
            startDate = "12.12.2014",
            endDate = "12.12.2015", 
        }
        
        list[i] = productData
    end
    
    return list
end

function PackageScene:getCombinedDateString(startDate, endDate)
    -- TODO: İmplement later
end

function PackageScene:saveContent(step, callback)
    
    local contentData
    
    local promotionCode =  self.promotionText.text
    if promotionCode == nil then
        promotionCode = ""
    end
    
    if DataService.phase == Phase.RegistryPhase then
        
        contentData = {
            WebFormPage = DataService.webFormPage,
            ProductId = selectedProduct.productId,
            PromotionCode = promotionCode,
            CustomerId = DataService.customerId,
            MeterId = DataService.meterId,
        }
    else
        contentData = {
            WebFormPage = DataService.webFormPage,
            ProductId = selectedProduct.productId,
            PromotionCode = promotionCode,
            CustomerId = DataService.customerId,
            MeterId = DataService.meterId,
        }
    end
    
    contentData.step = step
    
    DataService:saveContent(contentData, function (responseData)
        DataService.customerId = responseData.customerId
        DataService.productId  = responseData.productId
        DataService.quoteId    = responseData.quoteId
        
        callback(responseData)
    end)
    
end

-- Button Methods 
function PackageScene:onNextButton(event)
    if event.phase == "ended" then
        if selectedProduct == nil then
            --TODO: Buarada hata mesajı verdir. 
        end
        
        self:saveContent(step, function (responseData)
            storyboard.gotoScene("Scenes.AppointmentScene", "slideLeft", 400 )
        end)
        
    end
end

function PackageScene:onBackButton(event)
    if event.phase == "ended" then
        --storyboard.gotoScene("Scenes.ConfirmationScene", "slideLeft", 400 )
    end
end

function PackageScene:createScene( event)
    
    --products = DataService.products
    products = self:createDummyProductList()
    
    -- View of scene
    local group = self.view
 
    -- HEADER BAR
    headerBar = display.newRect( 0, 0, 1024, 50 )
    headerBar:setFillColor( 74/255, 74/255, 74/255 )

    -- CEREAN LOGO
    logo = display.newImage( "Assets/Logo.png" )
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
    local packageScroller  = PackageScroller.new({      x               = 30,
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
        onEvent = self.onBackButton,
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
        onEvent = self.onNextButton,
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
function PackageScene:didPackageSelect( packageView )
    print "We are here now!"
    
    local product = packageView.product
    self.packageDetail:setPackageDetail(product)
    -- TODO: Set the PackageDetail when it is ready
    self.packageDetail:hideMask()
end

return PackageScene