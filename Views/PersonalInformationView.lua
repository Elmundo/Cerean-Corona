local display = require( "display" )
local native = require( "native" )
local widget = require( "widget" )
local DataService = require( "Network.DataService" )

local PersonalInformationView = {}

function PersonalInformationView.new()
        
	local personalInformationGroup
	local personalInformationGroupBackground
	local personalInformationHeaderText
	local personalInformationHeaderBackground
	local contentGroup

	local personalSubscriptionInformation
	local nameLabel
	local nameField
	local iDNumberLabel
	local iDNumberField
	local mobileLabel
	local mobileField
	local emailLabel
	local emailField

	local locationInformation
	local cityLabel
	local cityField
	local countyLabel
	local countyField

	local centerX = display.contentCenterX
	local centerY = display.contentCenterY
        
        function getContent () 
            local contentData = {}
            
            DataService.customerPhone = mobileField:getText()
            DataService.customerEmail = emailField:getText()
            DataService.customerName = nameField:getText()
            contentData = {
                Name = nameField:getText(),
                TckNo = iDNumberField:getText(),
                MobilePhone = mobileField:getText(),
                Email = emailField:getText(),
                CityId = cityField:getText(),
                CountyId = countyField:getText()
            }
             
            return contentData
        end
        
	personalInformationGroup = display.newGroup( )
	contentGroup = display.newGroup( )

	--function personalInformationGroup:

    personalInformationGroupBackground = display.newRect( 40, 420, 1200, 400 )
    --personalInformationGroupBackground:setFillColor( 0, 1, 0 )

    personalInformationHeaderBackground = display.newRoundedRect( 40, 420, 1200, 40, 5 )
    personalInformationHeaderBackground:setFillColor( 255/255, 107/255, 0 )

    personalInformationHeaderText = display.newText(  "Kişisel Bilgiler", 60, 430, native.systemFontBold, 15 )
    personalInformationHeaderText:setFillColor( 1, 1, 1 )

    personalSubscriptionInformation = display.newText( "1. Bireysel Abonelik Bilgileri", 60, 480, native.systemFontBold, 17 )
    personalSubscriptionInformation:setFillColor( 0, 0, 0 )

    nameLabel = display.newText( "Ad - Soyad", 60, 500, native.systemFontBold, 15 )
    nameLabel:setFillColor( 0, 0, 0 )
    nameField = display.newRoundedRect( 50, 520, 360, 40, 5 )
    nameField:setFillColor( 0.5, 0.5, 0.5 )

    iDNumberLabel =  display.newText( "TC Kimlik No", centerX-170, 500, native.systemFontBold, 15 )
    iDNumberLabel:setFillColor( 0, 0, 0 )
    iDNumberField = display.newRoundedRect( centerX-180, 520, 360, 40, 5 )
    iDNumberField:setFillColor( 0.5, 0.5, 0.5 )

    mobileLabel = display.newText( "Mobil Telefon", 2*centerX-400, 500, native.systemFontBold, 15 )
    mobileLabel:setFillColor( 0, 0, 0 )
    mobileField = display.newRoundedRect( 2*centerX-410, 520, 360, 40, 5 )
    mobileField:setFillColor( 0.5, 0.5, 0.5 )

    emailLabel = display.newText( "E-Posta Adresi", 60, 570, native.systemFontBold, 15 )
    emailLabel:setFillColor( 0,0,0 )
    emailField = display.newRoundedRect( 50, 590, 360, 40, 5 )
    emailField:setFillColor( 0.5, 0.5, 0.5 )
    
    locationInformation = display.newText( "2. Konum Bilgileri", 60, 640, native.systemFontBold, 17 )
    locationInformation:setFillColor( 0, 0, 0 )

    cityLabel = display.newText( "İl", 60, 660, native.systemFontBold, 17 )
    cityLabel:setFillColor( 0, 0, 0 )
    cityField = display.newRoundedRect( 50, 680, 360, 40, 5 )
    cityField:setFillColor( 0.5, 0.5, 0.5 )
    
    countyLabel = display.newText( "İlçe", centerX-170, 660, native.systemFontBold, 17 )
    countyLabel:setFillColor( 0, 0, 0 )
    countyField = display.newRoundedRect( centerX-180, 680, 360, 40, 5 )
    countyField:setFillColor( 0.5, 0.5, 0.5 )

    personalInformationGroup:insert( personalInformationGroupBackground )
    personalInformationGroup:insert( personalInformationHeaderBackground )
    personalInformationGroup:insert( personalInformationHeaderText )

    contentGroup:insert( personalSubscriptionInformation )
    contentGroup:insert( nameLabel )
    contentGroup:insert( nameField )
    contentGroup:insert( iDNumberLabel )
    contentGroup:insert( iDNumberField )
    contentGroup:insert( mobileLabel )
    contentGroup:insert( mobileField )
    contentGroup:insert( emailLabel )
    contentGroup:insert( emailField )
    contentGroup:insert( locationInformation )
    contentGroup:insert( cityLabel )
    contentGroup:insert( cityField )
    contentGroup:insert( countyLabel )
    contentGroup:insert( countyField )

    personalInformationGroup:insert( contentGroup )
    personalInformationGroup.y = 185
    --personalInformationGroup.alpha = 0

    return personalInformationGroup
end

return PersonalInformationView
