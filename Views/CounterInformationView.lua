local display = require( "display" )
local native = require( "native" )
local widget = require( "widget" )

local CounterInformationView = {}

function CounterInformationView.new()

local centerX = display.contentCenterX
local centerY = display.contentCenterY

local counterInformationGroup
local counterInformationGroupBackground
local counterInformationHeaderText
local counterInformationHeaderBackground
local contentGroup

local distrubitionCompanyInformation
local distrubitionCompanyLabel
local distrubitionCompanyField
local supplierCompanyLabel
local supplierCompanyField
local counterInformation
local companyCodeLabel
local companyCodeField
local subscriberNumberLabel
local subscriberNumberField
local recieptLabel
local recieptField
local subscriberGroupLabel
local subscriberGroupField
local customerNameLabel
local customerNameField
local counterSerialNumberLabel
local counterSerialNumberField
local inductiveCounterSerialNumberLabel
local inductiveCounterSerialNumberField
local counterMultiplierLabel
local counterMultiplierField
local billAmountLabel
local billAmountField

function getContent () 
            local contentData = {}
            
            contentData = {
                DistributorId = "123",--distrubitionCompanyField:getText()--Not TextField
                SkaDescId = "123",--supplierCompanyField:getText()
                CompanyCode = "123",--companyCodeField:getText()
                MembershipNumber = "123",--subscriberGroupField:getText()
                TariffCode = "123",--recieptField:getText()
                MembershipGroup = "133",--subscriberGroupField:getText()
                CustomerName = "123",--customerNameField:getText()
                MeterSerialNumber = "245",--counterSerialNumberField:getText()
                MeterSerialNumberAgain = "768",--inductiveCounterSerialNumberField:getText()
                MeterParameter = "1233",--counterMultiplierField:getText()
                BillAmount = "89761"--billAmountField:getText()
           } 
           
             
            return contentData
        end

counterInformationGroup = display.newGroup( )
contentGroup = display.newGroup( )

        counterInformationGroupBackground = display.newRect( 40, 420, 1200, 400 )
        --counterInformationGroupBackground:setFillColor( 0,0,1 )

        counterInformationHeaderBackground = display.newRoundedRect( 40, 420, 1200, 40, 5 )
        counterInformationHeaderBackground:setFillColor( 255/255, 107/255, 0 )

        counterInformationHeaderText = display.newText(  "Sayaç Bilgileri", 60, 430, native.systemFontBold, 15 )
        counterInformationHeaderText:setFillColor( 1,1,1 )

        distrubitionCompanyInformation = display.newText( "1. Dağıtım Şirketi Bilgileri", 60, 465, native.systemFontBold, 17 )
        distrubitionCompanyInformation:setFillColor( 0, 0, 0 )

        distrubitionCompanyLabel = display.newText( "Dağıtım Şirketi Adı", 60, 485, native.systemFontBold, 15 )
        distrubitionCompanyLabel:setFillColor( 0,0,0 )
        distrubitionCompanyField  = display.newRoundedRect( 50, 505, 240, 30, 5 )
        distrubitionCompanyField:setFillColor( 0.5, 0.5, 0.5 )

        supplierCompanyLabel = display.newText( "Tedarik Şirketi Adı", 470, 490, native.systemFontBold, 15 )
        supplierCompanyLabel:setFillColor( 0,0,0 )
        supplierCompanyField = display.newRoundedRect( centerX-60-120, 510, 240, 30, 5 )
        supplierCompanyField:setFillColor( 0.5, 0.5, 0.5 )

        counterInformation = display.newText( "2. Sayaç Bilgileri", 60, 540, native.systemFontBold, 17 )
        counterInformation:setFillColor( 0, 0, 0 )

        companyCodeLabel = display.newText( "İşletme Kodu", 60, 555, native.systemFontBold, 15 )
        companyCodeLabel:setFillColor( 0,0,0 )
        companyCodeField  = display.newRoundedRect( 50, 575, 240, 30, 5 )
        companyCodeField:setFillColor( 0.5, 0.5, 0.5 )

        subscriberNumberLabel = display.newText( "Abone/Tesisat No", 470, 555, native.systemFontBold, 15 )
        subscriberNumberLabel:setFillColor( 0,0,0 )
        subscriberNumberField  = display.newRoundedRect( centerX-180, 575, 240, 30, 5 )
        subscriberNumberField:setFillColor( 0.5, 0.5, 0.5 )

        recieptLabel = display.newText( "Tarife Kodu", 60, 605, native.systemFontBold, 15 )
        recieptLabel:setFillColor( 0,0,0 )
        recieptField  = display.newRoundedRect( 50, 625, 240, 30, 5 )
        recieptField:setFillColor( 0.5, 0.5, 0.5 )

        subscriberGroupLabel = display.newText( "Abone Grubu", 470, 605, native.systemFontBold, 15 )
        subscriberGroupLabel:setFillColor( 0,0,0 )
        subscriberGroupField  = display.newRoundedRect( centerX-180, 625, 240, 30, 5 )
        subscriberGroupField:setFillColor( 0.5, 0.5, 0.5 )

        customerNameLabel = display.newText( "Müşteri Adı/Ünvanı", 60, 655, native.systemFontBold, 15 )
        customerNameLabel:setFillColor( 0,0,0 ) 
        customerNameField = display.newRoundedRect( 50, 675, centerX-50, 30, 5 )
        customerNameField:setFillColor( 0.5,0.5,0.5 )

        counterSerialNumberLabel = display.newText( "Aktif Sayaç Seri No", 60, 710, native.systemFontBold, 15 )
        counterSerialNumberLabel:setFillColor( 0,0,0 )
        counterSerialNumberField  = display.newRoundedRect( 50, 730, 240, 30, 5 )
        counterSerialNumberField:setFillColor( 0.5, 0.5, 0.5 )

        inductiveCounterSerialNumberLabel = display.newText( "Endüktif Sayaç Seri No", 470, 710, native.systemFontBold, 15 )
        inductiveCounterSerialNumberLabel:setFillColor( 0,0,0 )
        inductiveCounterSerialNumberField  = display.newRoundedRect( centerX-180, 730, 240, 30, 5 )
        inductiveCounterSerialNumberField:setFillColor( 0.5, 0.5, 0.5 )

        counterMultiplierLabel = display.newText( "Sayaç Çarpanı", 60, 760, native.systemFontBold, 15 )
        counterMultiplierLabel:setFillColor( 0,0,0 )
        counterMultiplierField  = display.newRoundedRect( 50, 780, 240, 30, 5 )
        counterMultiplierField:setFillColor( 0.5, 0.5, 0.5 )

        billAmountLabel = display.newText( "Fatura Tutarı", 470, 760, native.systemFontBold, 15 )
        billAmountLabel:setFillColor( 0,0,0 )
        billAmountField  = display.newRoundedRect( centerX-180, 780, 240, 30, 5 )
        billAmountField:setFillColor( 0.5, 0.5, 0.5 )


        counterInformationGroup:insert( counterInformationGroupBackground )
        counterInformationGroup:insert( counterInformationHeaderBackground )
        counterInformationGroup:insert( counterInformationHeaderText )

        contentGroup:insert( distrubitionCompanyInformation )
        contentGroup:insert( distrubitionCompanyLabel )
        contentGroup:insert( distrubitionCompanyField )
        contentGroup:insert( supplierCompanyLabel )
        contentGroup:insert( supplierCompanyField )
        contentGroup:insert( counterInformation )
        contentGroup:insert( companyCodeLabel )
        contentGroup:insert( companyCodeField ) 
        contentGroup:insert( subscriberNumberLabel )
        contentGroup:insert( subscriberNumberField )
        contentGroup:insert( recieptLabel )
        contentGroup:insert( recieptField )
        contentGroup:insert( subscriberGroupLabel )
        contentGroup:insert( subscriberGroupField )
        contentGroup:insert( customerNameLabel)
        contentGroup:insert( customerNameField)
        contentGroup:insert( counterSerialNumberLabel )
        contentGroup:insert( counterSerialNumberField )
        contentGroup:insert( inductiveCounterSerialNumberLabel )
        contentGroup:insert( inductiveCounterSerialNumberField )
        contentGroup:insert( counterMultiplierLabel )
        contentGroup:insert( counterMultiplierField )
        contentGroup:insert( billAmountLabel )
        contentGroup:insert( billAmountField )

        counterInformationGroup:insert( contentGroup )

        counterInformationGroup.y = 230
        --counterInformationGroup.alpha = 0

    return counterInformationGroup
end

return CounterInformationView
