

local display = require( "display" )
local native = require( "native" )
local widget = require( "widget" )
local DataService = require( "Network.DataService" )
local CTextField = require( "Views.TextFields.CTextField" )
local DropDownMenu = require "libs.DDM.DropDownMenu"

local EnterpriseInformationView = {}

function EnterpriseInformationView.new()
        
	local enterpriseInformationGroup
	local enterpriseInformationGroupBackground
	local enterpriseInformationHeaderText
	local enterpriseInformationHeaderBackground
	local contentGroup

	local enterpriseSubscriptionInformation
	local companyNameLabel
	local companyNameField
	local taxOfficeLabel
	local taxOfficField
	local taxNumberLabel
	local taxNumberField
	local representativeNameLabel
	local representativeNameField
        local representativeLastNameLabel
	local representativeLastNameField
        local representativePhoneLabel
	local representativePhoneField
        local phoneLabel
	local phoneField
        local emailLabel
	local emailField


	local locationInformation
	local cityLabel
	local cityField
	local countyLabel
	local countyField

	local centerX = display.contentCenterX
	local centerY = display.contentCenterY
        
        enterpriseInformationGroup = display.newGroup( )
	contentGroup = display.newGroup( )
        
        function enterpriseInformationGroup:hideGroup ( isHidden )
            
            companyNameField:hide(isHidden)
            taxOfficField:hide(isHidden)
            taxNumberField:hide(isHidden)
            representativeNameField:hide(isHidden)
            representativeLastNameField:hide(isHidden)
            representativePhoneField:hide(isHidden)
            phoneField:hide(isHidden)
            emailField:hide(isHidden)
            cityField:hide(isHidden)
            countyField:hide(isHidden)
            --[[]
            if( isHidden )then
                contentGroup.alpha = 0
            else 
                nameField:hide(false)
                contentGroup.alpha = 1
            end
            --]]
        end
        
        function enterpriseInformationGroup:getContent () 
            local contentData = {}
            DataService.CustomerPhone = phoneField:getText()
            DataService.CustomerEmail = emailField:getText()
            DataService.customerName = companyNameField:getText()
            contentData = {
                Name                        = companyNameField:getText(),
                TaxOffice                   = taxOfficField:getText(),
                TaxNo                       = taxNumberField:getText(),
                PrimaryContactFirstName     = representativeNameField:getText(),
                PrimaryContactLastName      = representativeLastNameField:getText(),
                MobilePhone                 = representativePhoneField:getText(),
                Telephone                   = phoneField:getText(),
                Email                       = emailField:getText(),
            }

            return contentData
        end
        
	

	--function personalInformationGroup:

    enterpriseInformationGroupBackground = display.newRect( 40, 420, 1200, 400 )
    --personalInformationGroupBackground:setFillColor( 0, 1, 0 )

    enterpriseInformationHeaderBackground = display.newRoundedRect( 40, 420, 1200, 40, 5 )
    enterpriseInformationHeaderBackground:setFillColor( 255/255, 107/255, 0 )

    enterpriseInformationHeaderText = display.newText(  "Kurumsal Bilgiler", 60, 430, native.systemFontBold, 15 )
    enterpriseInformationHeaderText:setFillColor( 1, 1, 1 )

    enterpriseSubscriptionInformation = display.newText( "1. Kurumsal Abonelik Bilgileri", 60, 480, native.systemFontBold, 17 )
    enterpriseSubscriptionInformation:setFillColor( 0, 0, 0 )

    companyNameLabel = display.newText( "Şirket Adı", 60, 500, native.systemFontBold, 15 )
    companyNameLabel:setFillColor( 0, 0, 0 )
    companyNameField = CTextField.new(50, 520, 360, 40)
    --[[
    nameField = display.newRoundedRect( 50, 520, 360, 40, 5 )
    nameField:setFillColor( 0.5, 0.5, 0.5 )
    --]]
    taxOfficeLabel =  display.newText( "Vergi Dairesi", centerX-170, 500, native.systemFontBold, 15 )
    taxOfficeLabel:setFillColor( 0, 0, 0 )
    taxOfficField = CTextField.new(centerX-180, 520, 360, 40)
    --[[]
    iDNumberField = display.newRoundedRect( centerX-180, 520, 360, 40, 5 )
    iDNumberField:setFillColor( 0.5, 0.5, 0.5 )
    --]]
    taxNumberLabel = display.newText( "Vergi Numarası", 2*centerX-400, 500, native.systemFontBold, 15 )
    taxNumberLabel:setFillColor( 0, 0, 0 )
    taxNumberField = CTextField.new(2*centerX-410, 520, 360, 40)
    --[[
    mobileField = display.newRoundedRect( 2*centerX-410, 520, 360, 40, 5 )
    mobileField:setFillColor( 0.5, 0.5, 0.5 )
    --]]
    representativeNameLabel = display.newText( "Şirket Yetkilisi Adı", 60, 570, native.systemFontBold, 15 )
    representativeNameLabel:setFillColor( 0,0,0 )
    representativeNameField = CTextField.new(50, 590, 360, 40)
    --[[]
    emailField = display.newRoundedRect( 50, 590, 360, 40, 5 )
    emailField:setFillColor( 0.5, 0.5, 0.5 )
    --]]
    representativeLastNameLabel = display.newText( "Şirket Yetkilisi Soyadı", centerX-170, 570, native.systemFontBold, 15 )
    representativeLastNameLabel:setFillColor( 0,0,0 )
    representativeLastNameField = CTextField.new(centerX-180, 590, 360, 40)
    
    representativePhoneLabel = display.newText( "Yetkili Telefon Numarası", 2*centerX-400, 570, native.systemFontBold, 15 )
    representativePhoneLabel:setFillColor( 0,0,0 )
    representativePhoneField = CTextField.new(2*centerX-410, 590, 360, 40)
    
    phoneLabel = display.newText( "Sabit Telefon", 60, 640, native.systemFontBold, 15 )
    phoneLabel:setFillColor( 0,0,0 )
    phoneField = CTextField.new(50, 660, 360, 40)

    emailLabel = display.newText( "E-Posta Adresi", centerX-170, 640, native.systemFontBold, 15 )
    emailLabel:setFillColor( 0,0,0 )
    emailField = CTextField.new(centerX-180, 660, 360, 40)
    
    locationInformation = display.newText( "2. Konum Bilgileri", 60, 710, native.systemFontBold, 17 )
    locationInformation:setFillColor( 0, 0, 0 )

    cityLabel = display.newText( "İl", 60, 730, native.systemFontBold, 17 )
    cityLabel:setFillColor( 0, 0, 0 )
    cityField = CTextField.new(50, 750, 360, 40)
    --[[]
    cityField = display.newRoundedRect( 50, 680, 360, 40, 5 )
    cityField:setFillColor( 0.5, 0.5, 0.5 )
    --]]
    
    countyLabel = display.newText( "İlçe", centerX-170, 730, native.systemFontBold, 17 )
    countyLabel:setFillColor( 0, 0, 0 )
    countyField = CTextField.new(centerX-180, 750, 360, 40)
    --[[]
    countyField = display.newRoundedRect( centerX-180, 680, 360, 40, 5 )
    countyField:setFillColor( 0.5, 0.5, 0.5 )
    --]]
    
    enterpriseInformationGroup:insert( enterpriseInformationGroupBackground )
    enterpriseInformationGroup:insert( enterpriseInformationHeaderBackground )
    enterpriseInformationGroup:insert( enterpriseInformationHeaderText )

    contentGroup:insert( enterpriseSubscriptionInformation )
    contentGroup:insert( companyNameLabel )
    contentGroup:insert( companyNameField )
    contentGroup:insert( taxOfficeLabel )
    contentGroup:insert( taxOfficField )
    contentGroup:insert( taxNumberLabel )
    contentGroup:insert( taxNumberField )
    contentGroup:insert( representativeNameLabel )
    contentGroup:insert( representativeNameField )
    contentGroup:insert( representativeLastNameLabel )
    contentGroup:insert( representativeLastNameField )
    contentGroup:insert( representativePhoneLabel )
    contentGroup:insert( representativePhoneField )
    contentGroup:insert( phoneLabel )
    contentGroup:insert( phoneField )
    contentGroup:insert( emailLabel )
    contentGroup:insert( emailField )
    
    contentGroup:insert( locationInformation )
    contentGroup:insert( cityLabel )
    contentGroup:insert( cityField )
    contentGroup:insert( countyLabel )
    contentGroup:insert( countyField )

    enterpriseInformationGroup:insert( contentGroup )
    enterpriseInformationGroup.y = 185
    --personalInformationGroup.alpha = 0

    return enterpriseInformationGroup
end

return EnterpriseInformationView
