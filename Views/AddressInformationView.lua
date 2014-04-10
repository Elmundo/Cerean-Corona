local display = require( "display" )
local native = require( "native" )
local widget = require( "widget" )

local CLabel = require( "Views.Labels.Clabel" )
local CButton = require( "Views.Buttons.CButton" )
local CTextField = require( "Views.TextFields.CTextField" )

local AddressInformationView = {}

function AddressInformationView.new()
    
    local addressInformationView
    local contentView
    
    local addressInformationGroupBackground
    local addressInformationHeaderText
    local addressInformationHeaderBackground
    
    local visitingAddressLabel
    local billingAddressLabel
    local addressLabel1
    local addressField1
    local addressLabel2
    local addressField2
    
    local postalCodeLabel1
    local postalCodeField1
    local postalCodeLabel2
    local postalCodeField2
    
    local cityLabel1
    local cityField1
    local cityLabel2
    local cityField2
    
    local countyLabel1
    local countyField1
    local countyLabel2
    local countyField2
    
    local phoneLabel1
    local phoneField1
    local phoneLabel2
    local phoneField2
    
    local mobileLabel1
    local mobileField1
    local mobileLabel2
    local mobileField2
    
    local faxLabel1
    local faxField1
    local faxLabel2
    local faxField2
    
    local emailLabel1
    local emailField1
    local emailLabel2
    local emailField2
    
    addressInformationView = display.newGroup()
    contentView = display.newGroup()
    
    addressInformationGroupBackground = display.newRect( 40, 420, 1200, 500 )
    --personalInformationGroupBackground:setFillColor( 0, 1, 0 )

    addressInformationHeaderBackground = display.newRoundedRect( 40, 420, 1200, 40, 5 )
    addressInformationHeaderBackground:setFillColor( 113/255, 27/255, 69/255 )

    addressInformationHeaderText = display.newText(  "Adres Bilgileri", 60, 430, native.systemFontBold, 15 )
    addressInformationHeaderText:setFillColor( 1, 1, 1 )
    
    visitingAddressLabel = display.newText("1.Ziyaret Adresi", 60, 480, native.systemFontBold, 17 )
    visitingAddressLabel:setFillColor( 0, 0, 0 )
    billingAddressLabel = display.newText("2.Fatura Adresi", 620, 480, native.systemFontBold, 17 )
    billingAddressLabel:setFillColor( 0, 0, 0 )
    addressLabel1 = display.newText( "Adres", 60, 500, native.systemFontBold, 15 )
    addressLabel1:setFillColor( 0, 0, 0 )
    addressField1 = CTextField.new(50, 520, 500, 40)
    
    addressLabel2 = display.newText( "Adres", 620, 500, native.systemFontBold, 15 )
    addressLabel2:setFillColor( 0, 0, 0 )
    addressField2 = CTextField.new(610, 520, 500, 40)
    
    postalCodeLabel1 = display.newText( "Posta Kodu", 60, 570, native.systemFontBold, 15 )
    postalCodeLabel1:setFillColor( 0, 0, 0 )
    postalCodeField1 = CTextField.new(50, 590, 240, 40)
    
    postalCodeLabel2 = display.newText( "Posta Kodu", 620, 570, native.systemFontBold, 15 )
    postalCodeLabel2:setFillColor( 0, 0, 0 )
    postalCodeField2 = CTextField.new(610, 590, 240, 40)
    
    cityLabel1 = display.newText( "İl", 60, 640, native.systemFontBold, 15 )
    cityLabel1:setFillColor( 0, 0, 0 )
    cityField1 = CTextField.new(50, 660, 240, 40)
    
    countyLabel1 = display.newText( "İlçe", 320, 640, native.systemFontBold, 15 )
    countyLabel1:setFillColor( 0, 0, 0 )
    countyField1 = CTextField.new(310, 660, 240, 40)
    
    cityLabel2 = display.newText( "İl", 620, 640, native.systemFontBold, 15 )
    cityLabel2:setFillColor( 0, 0, 0 )
    cityField2 = CTextField.new(610, 660, 240, 40)
    
    countyLabel2 = display.newText( "İlçe", 880, 640, native.systemFontBold, 15 )
    countyLabel2:setFillColor( 0, 0, 0 )
    countyField2 = CTextField.new(870, 660, 240, 40)
    
    phoneLabel1 = display.newText( "Sabit Telefon", 60, 710, native.systemFontBold, 15 )
    phoneLabel1:setFillColor( 0, 0, 0 )
    phoneField1 = CTextField.new(50, 730, 240, 40)
    
    mobileLabel1 = display.newText( "Mobil Telefon", 320, 710, native.systemFontBold, 15 )
    mobileLabel1:setFillColor( 0, 0, 0 )
    mobileField1 = CTextField.new(310, 730, 240, 40)
    
    phoneLabel2 = display.newText( "Sabit Telefon", 620, 710, native.systemFontBold, 15 )
    phoneLabel2:setFillColor( 0, 0, 0 )
    phoneField2 = CTextField.new(610, 730, 240, 40)
    
    mobileLabel2 = display.newText( "Mobil Telefon", 880, 710, native.systemFontBold, 15 )
    mobileLabel2:setFillColor( 0, 0, 0 )
    mobileField2 = CTextField.new(870, 730, 240, 40)
    
    faxLabel1 = display.newText( "Faks", 60, 780, native.systemFontBold, 15 )
    faxLabel1:setFillColor( 0, 0, 0 )
    faxField1 = CTextField.new(50, 800, 240, 40)
    
    emailLabel1 = display.newText( "E-Posta Adresi", 320, 780, native.systemFontBold, 15 )
    emailLabel1:setFillColor( 0, 0, 0 )
    emailField1 = CTextField.new(310, 800, 240, 40)
    
    faxLabel2 = display.newText( "Faks", 620, 780, native.systemFontBold, 15 )
    faxLabel2:setFillColor( 0, 0, 0 )
    faxField2 = CTextField.new(610, 800, 240, 40)
    
    emailLabel2 = display.newText( "E-Posta Adresi", 880, 780, native.systemFontBold, 15 )
    emailLabel2:setFillColor( 0, 0, 0 )
    emailField2 = CTextField.new(870, 800, 240, 40)
    
    function addressInformationView:hideGroup ( isHidden )
            
            addressField1:hide(isHidden)
            postalCodeField1:hide(isHidden)
            cityField1:hide(isHidden)
            countyField1:hide(isHidden)
            phoneField1:hide(isHidden)
            mobileField1:hide(isHidden)
            faxField1:hide(isHidden)
            emailField1:hide(isHidden)
            addressField2:hide(isHidden)
            postalCodeField2:hide(isHidden)
            cityField2:hide(isHidden)
            countyField2:hide(isHidden)
            phoneField2:hide(isHidden)
            mobileField2:hide(isHidden)
            faxField2:hide(isHidden)
            emailField2:hide(isHidden)
            --[[]
            if( isHidden )then
                contentGroup.alpha = 0
            else 
                nameField:hide(false)
                contentGroup.alpha = 1
            end
            --]]
        end
    
    function addressInformationView:getContent () 
        local contentData = {}
        
        contentData = {
            AddressDetailVisiting = "",
            PostalCodeVisiting = "",
            CityVisiting = "",
            CountyVisiting = "",
            TelephoneVisiting = "",
            MobilePhoneVisiting = "",
            FaxVisiting = "",
            EmailVisiting = "",
            AddressDetailInvoice = "",
            PostalCodeInvoice = "",
            CityInvoice = "",
            CountyInvoice = "",
            TelephoneInvoice = "",
            MobilePhoneInvoice = "",
            FaxInvoice = "",
            EmailInvoice = "",
        }
        
        return contentData
    end
    
    addressInformationView:insert( addressInformationGroupBackground )
    addressInformationView:insert( addressInformationHeaderBackground )
    addressInformationView:insert( addressInformationHeaderText )
    
    contentView:insert( visitingAddressLabel )
    contentView:insert( addressLabel1 )
    contentView:insert( addressField1 )
    contentView:insert( postalCodeLabel1 )
    contentView:insert( postalCodeField1 )
    contentView:insert( cityLabel1 )
    contentView:insert( cityField1 )
    contentView:insert( countyLabel1 )
    contentView:insert( countyField1 )
    contentView:insert( phoneLabel1 )
    contentView:insert( phoneField1 )
    contentView:insert( mobileLabel1 )
    contentView:insert( mobileField1 )
    contentView:insert( faxLabel1 )
    contentView:insert( faxField1 )
    contentView:insert( emailLabel1 )
    contentView:insert( emailField1 )
    
    contentView:insert( billingAddressLabel )
    contentView:insert( addressLabel2 )
    contentView:insert( addressField2 )
    contentView:insert( postalCodeLabel2 )
    contentView:insert( postalCodeField2 )
    contentView:insert( cityLabel2 )
    contentView:insert( cityField2 )
    contentView:insert( countyLabel2 )
    contentView:insert( countyField2 )
    contentView:insert( phoneLabel2 )
    contentView:insert( phoneField2 )
    contentView:insert( mobileLabel2 )
    contentView:insert( mobileField2 )
    contentView:insert( faxLabel2 )
    contentView:insert( faxField2 )
    contentView:insert( emailLabel2 )
    contentView:insert( emailField2 )
    
    
    addressInformationView:insert( contentView )
    addressInformationView.y = 220
    --addressInformationView.y = -220
    return addressInformationView
end

return AddressInformationView
