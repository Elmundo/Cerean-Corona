local display = require( "display" )
local native = require( "native" )
local widget = require( "widget" )

module( ... )

function new()

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

counterInformationGroup = display.newGroup( )
contentGroup = display.newGroup( )

        counterInformationGroupBackground = display.newRect( 640, 620, 1200, 400 )
        --counterInformationGroupBackground:setFillColor( 1,0,0 )

        counterInformationHeaderBackground = display.newRoundedRect( 640, 440, 1200, 40, 5 )
        counterInformationHeaderBackground:setFillColor( 255/255, 107/255, 0 )

        counterInformationHeaderText = display.newText(  "Sayaç Bilgileri", 100, 440, native.systemFontBold, 15 )
        counterInformationHeaderText:setFillColor( 1,1,1 )

        distrubitionCompanyInformation = display.newText( "1. Dağıtım Şirketi Bilgileri", 150, 475, native.systemFontBold, 17 )
        distrubitionCompanyInformation:setFillColor( 0, 0, 0 )

        distrubitionCompanyLabel = display.newText( "Dağıtım Şirketi Adı", 120, 490, native.systemFontBold, 15 )
        distrubitionCompanyLabel:setFillColor( 0,0,0 )
        distrubitionCompanyField  = display.newRoundedRect( 230-60, 515, 240, 30, 5 )
        distrubitionCompanyField:setFillColor( 0.5, 0.5, 0.5 )

        supplierCompanyLabel = display.newText( "Tedarik Şirketi Adı", 522-60, 490, native.systemFontBold, 15 )
        supplierCompanyLabel:setFillColor( 0,0,0 )
        supplierCompanyField = display.newRoundedRect( centerX-60-60, 515, 240, 30, 5 )
        supplierCompanyField:setFillColor( 0.5, 0.5, 0.5 )

        counterInformation = display.newText( "2. Sayaç Bilgileri", 120, 540, native.systemFontBold, 17 )
        counterInformation:setFillColor( 0, 0, 0 )

        companyCodeLabel = display.newText( "İşletme Kodu", 100, 555, native.systemFontBold, 15 )
        companyCodeLabel:setFillColor( 0,0,0 )
        companyCodeField  = display.newRoundedRect( 230-60, 580, 240, 30, 5 )
        companyCodeField:setFillColor( 0.5, 0.5, 0.5 )

        subscriberNumberLabel = display.newText( "Abone/Tesisat No", 462, 555, native.systemFontBold, 15 )
        subscriberNumberLabel:setFillColor( 0,0,0 )
        subscriberNumberField  = display.newRoundedRect( centerX-120, 580, 240, 30, 5 )
        subscriberNumberField:setFillColor( 0.5, 0.5, 0.5 )

        recieptLabel = display.newText( "Tarife Kodu", 90, 605, native.systemFontBold, 15 )
        recieptLabel:setFillColor( 0,0,0 )
        recieptField  = display.newRoundedRect( 230-60, 630, 240, 30, 5 )
        recieptField:setFillColor( 0.5, 0.5, 0.5 )

        subscriberGroupLabel = display.newText( "Abone Grubu", 452, 605, native.systemFontBold, 15 )
        subscriberGroupLabel:setFillColor( 0,0,0 )
        subscriberGroupField  = display.newRoundedRect( centerX-120, 630, 240, 30, 5 )
        subscriberGroupField:setFillColor( 0.5, 0.5, 0.5 )

        customerNameLabel = display.newText( "Müşteri Adı/Ünvanı", 120, 655, native.systemFontBold, 15 )
        customerNameLabel:setFillColor( 0,0,0 ) 
        customerNameField = display.newRoundedRect( 345, 680, centerX-50, 30, 5 )
        customerNameField:setFillColor( 0.5,0.5,0.5 )

        counterSerialNumberLabel = display.newText( "Aktif Sayaç Seri No", 120, 705, native.systemFontBold, 15 )
        counterSerialNumberLabel:setFillColor( 0,0,0 )
        counterSerialNumberField  = display.newRoundedRect( 230-60, 730, 240, 30, 5 )
        counterSerialNumberField:setFillColor( 0.5, 0.5, 0.5 )

        inductiveCounterSerialNumberLabel = display.newText( "Endüktif Sayaç Seri No", 482, 705, native.systemFontBold, 15 )
        inductiveCounterSerialNumberLabel:setFillColor( 0,0,0 )
        inductiveCounterSerialNumberField  = display.newRoundedRect( centerX-120, 730, 240, 30, 5 )
        inductiveCounterSerialNumberField:setFillColor( 0.5, 0.5, 0.5 )

        counterMultiplierLabel = display.newText( "Sayaç Çarpanı", 100, 755, native.systemFontBold, 15 )
        counterMultiplierLabel:setFillColor( 0,0,0 )
        counterMultiplierField  = display.newRoundedRect( 230-60, 780, 240, 30, 5 )
        counterMultiplierField:setFillColor( 0.5, 0.5, 0.5 )

        billAmountLabel = display.newText( "Fatura Tutarı", 447, 755, native.systemFontBold, 15 )
        billAmountLabel:setFillColor( 0,0,0 )
        billAmountField  = display.newRoundedRect( centerX-120, 780, 240, 30, 5 )
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