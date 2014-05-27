local display = require( "display" )
local native = require( "native" )
local widget = require( "widget" )

--local CButton = require( "Views.Buttons.CButton" )
local CTextField = require( "Views.TextFields.CTextField" )
local DropDownMenu = require "libs.DDM.DropDownMenu"

local DataService = require( "Network.DataService")

local AddressInformationView = {}

function AddressInformationView.new( delegate )
    
    local addressInformationView
    local contentView
    
    local addressInformationGroupBackground
    local addressInformationHeaderText
    local addressInformationHeaderBackground
    
    local delegate = delegate
    
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
    
    local counties1
    local counties2
    local sameVisitingAndContactAdress
    local mirrorDataButton
    local mirrorDataButtonLabel
    local communicationButton
    local communicationButtonLabel
    
    local mirrorData
    local communicationData
    
    addressInformationView = display.newGroup()
    -------------------------------------------------------------------------------------------------------------
        -------------------------------------------------------------------------------------------------------------
        --DDM GROUP
        -------------------------------------------------------------------------------------------------------------
        -------------------------------------------------------------------------------------------------------------
        local function getDropDownList( dataTable )
            local returnTable = {}
            for i=1, #dataTable do
                returnTable[i] = {
                                    value = dataTable[i].Name,
                                    id = dataTable[i].ID,
                                 }
            end
            return returnTable    
        end
        
        function addressInformationView.didDDMItemSelected(ddmValue, ID, index)
            if( ID == "CityField1")then
                --local index = index
                --Enable DDM?
                --Start Spinner but first check for Corona Behaviour
                --Save Sellected City
                --Get County List
                if( mirrorData )then
                    cityField2:updateWithId(ddmValue, ID)
                end    
                DataService:getParametersWithGuid(kParameterCounties, ddmValue.id, nil, function(responseData)
                    --Check for error
                    print("Success")
                    counties1 = getDropDownList(responseData)
                    countyField1:loadData(counties1)
                    if(mirrorData)then
                       counties2 = counties1
                       countyField2:loadData(counties2)
                    end
                end, 
                    function(errorData)
                        --Error Handling
                        print("Fail")
                    end)
            elseif( ID == "CityField2")then
                --local index = index
                --Enable DDM?
                --Start Spinner but first check for Corona Behaviour
                --Save Sellected City
                --Get County List
                DataService:getParametersWithGuid(kParameterCounties, ddmValue.id, nil, function(responseData)
                    --Check for error
                    print("Success")
                    counties2 = getDropDownList(responseData)
                    countyField2:loadData(counties2)
                end, 
                    function(errorData)
                        --Error Handling
                        print("Fail")
                    end)
            elseif( ID == "CountyField1") then
                if( mirrorData )then
                    countyField2:updateWithId(ddmValue, ID)
                end  
            elseif( ID == "CountyField2") then
                    
            end
        end
        -------------------------------------------------------------------------------------------------------------
        -------------------------------------------------------------------------------------------------------------
        --END DDM GROUP
        -------------------------------------------------------------------------------------------------------------
        -------------------------------------------------------------------------------------------------------------
    contentView = display.newGroup()
    
    local function mirrorDataButtonTouched( event )
        if( event.phase == "ended" )then
            print("MirrorData")
            
            
            if( mirrorData )then
                mirrorData = false 
                mirrorDataButton:removeSelf()
                mirrorDataButton = nil
                mirrorDataButton = display.newImageRect("Assets/SwitchButton.png", 48, 20)
                mirrorDataButton.x = 60
                mirrorDataButton.y = 880
                mirrorDataButton:addEventListener("touch", mirrorDataButtonTouched)
                contentView:insert(mirrorDataButton)
            else 
                addressField2:setText(addressField1:getText())

                postalCodeField2:setText(postalCodeField1:getText())

                phoneField2:setText(phoneField1:getText())

                mobileField2:setText(mobileField1:getText())

                faxField2:setText(faxField1:getText())

                addressField2:setText(addressField1:getText())

                emailField2:setText(emailField1:getText())
                
                
                local cityValue = cityField1:getValue()
                local countyValue = countyField1:getValue()
                local cityId = cityField1:getID()
                local countyId = countyField1:getID()
                
                if( cityValue ~= "SEÇİNİZ" )then
                    
                
                    cityField2:updateWithId(cityValue, cityId)
                    --setValue(cityValue)
                    --countyField2:updateButton(countyValue)
                    --setValue(countyValue)
                
                    counties2 = counties1
                    countyField2:loadData( counties2 )
                    countyField2:updateWithId(countyValue, countyId)
                    
                    --cityField2:setID(cityId)
                    --countyField2:setID(countyId)
                    
                end
                --[[]
                [self.city2 updateButtonWithName:self.city1.name];
                self.city2.ID = self.city1.ID;
    
                self.county2.objects = self.county1.objects;
    _           counties2 = _counties1;
                [self.county2 updateButtonWithName:self.county1.name];
                self.county2.ID = self.county1.ID;
                --]]
                mirrorData = true 
                mirrorDataButton:removeSelf()
                mirrorDataButton = nil
                mirrorDataButton = display.newImageRect("Assets/SwitchButtonActive.png", 48, 20)
                mirrorDataButton.x = 60
                mirrorDataButton.y = 880
                mirrorDataButton:addEventListener("touch", mirrorDataButtonTouched)
                contentView:insert(mirrorDataButton)
            end
        end
        
        if( mirrorData )then
            
        end
    end
    
    local function communicationButtonTouched( event )
        if( event.phase == "ended" )then
            print("CommunicationData")
            if( communicationData )then
                communicationData = false 
                communicationButton:removeSelf()
                communicationButton = nil
                communicationButton = display.newImageRect("Assets/SwitchButton.png", 48, 20)
                communicationButton.x = 560
                communicationButton.y = 880
                communicationButton:addEventListener("touch", communicationButtonTouched)
                contentView:insert(communicationButton)
            else 
                communicationData = true 
                communicationButton:removeSelf()
                communicationButton = nil
                communicationButton = display.newImageRect("Assets/SwitchButtonActive.png", 48, 20)
                communicationButton.x = 560
                communicationButton.y = 880
                communicationButton:addEventListener("touch", communicationButtonTouched)
                contentView:insert(communicationButton)
            end
        end
    end
    
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
    addressField1:setDelegate(addressInformationView, "addressField1")
    
    addressLabel2 = display.newText( "Adres", 620, 500, native.systemFontBold, 15 )
    addressLabel2:setFillColor( 0, 0, 0 )
    addressField2 = CTextField.new(610, 520, 500, 40)
    addressField2:setDelegate(addressInformationView, "addressField2")
    
    postalCodeLabel1 = display.newText( "Posta Kodu", 60, 570, native.systemFontBold, 15 )
    postalCodeLabel1:setFillColor( 0, 0, 0 )
    postalCodeField1 = CTextField.new(50, 590, 240, 40)
    postalCodeField1:setKeyboardType( "number" )
    postalCodeField1:setDelegate(addressInformationView, "postalCode1")
    
    postalCodeLabel2 = display.newText( "Posta Kodu", 620, 570, native.systemFontBold, 15 )
    postalCodeLabel2:setFillColor( 0, 0, 0 )
    postalCodeField2 = CTextField.new(610, 590, 240, 40)
    postalCodeField2:setKeyboardType( "number" )
    postalCodeField2:setDelegate(addressInformationView, "postalCode2")
    
    cityLabel1 = display.newText( "İl", 60, 640, native.systemFontBold, 15 )
    cityLabel1:setFillColor( 0, 0, 0 )
    phoneLabel1 = display.newText( "Sabit Telefon", 60, 710, native.systemFontBold, 15 )
    phoneLabel1:setFillColor( 0, 0, 0 )
    phoneField1 = CTextField.new(50, 730, 240, 40)
    phoneField1:setKeyboardType( "phone" )
    phoneField1:setDelegate(addressInformationView, "phoneField1")
    
    mobileLabel1 = display.newText( "Mobil Telefon", 320, 710, native.systemFontBold, 15 )
    mobileLabel1:setFillColor( 0, 0, 0 )
    mobileField1 = CTextField.new(310, 730, 240, 40)
    mobileField1:setKeyboardType( "phone" )
    mobileField1:setDelegate(addressInformationView, "mobileField1")

    phoneLabel2 = display.newText( "Sabit Telefon", 620, 710, native.systemFontBold, 15 )
    phoneLabel2:setFillColor( 0, 0, 0 )
    phoneField2 = CTextField.new(610, 730, 240, 40)
    phoneField2:setKeyboardType( "phone" )
    phoneField2:setDelegate(addressInformationView, "phoneField2")

    mobileLabel2 = display.newText( "Mobil Telefon", 880, 710, native.systemFontBold, 15 )
    mobileLabel2:setFillColor( 0, 0, 0 )
    mobileField2 = CTextField.new(870, 730, 240, 40)
    mobileField2:setKeyboardType( "phone" )
    mobileField2:setDelegate(addressInformationView, "mobileField2")
    
    faxLabel1 = display.newText( "Faks", 60, 780, native.systemFontBold, 15 )
    faxLabel1:setFillColor( 0, 0, 0 )
    faxField1 = CTextField.new(50, 800, 240, 40)
    faxField1:setKeyboardType("phone")
    faxField1:setDelegate(addressInformationView, "faxField1")
    
    emailLabel1 = display.newText( "E-Posta Adresi", 320, 780, native.systemFontBold, 15 )
    emailLabel1:setFillColor( 0, 0, 0 )
    emailField1 = CTextField.new(310, 800, 240, 40)
    emailField1:setKeyboardType("email")
    emailField1:setDelegate(addressInformationView, "emailField1")
    
    faxLabel2 = display.newText( "Faks", 620, 780, native.systemFontBold, 15 )
    faxLabel2:setFillColor( 0, 0, 0 )
    faxField2 = CTextField.new(610, 800, 240, 40)
    faxField2:setKeyboardType("phone")
    faxField2:setDelegate(addressInformationView, "faxField2")
    
    emailLabel2 = display.newText( "E-Posta Adresi", 880, 780, native.systemFontBold, 15 )
    emailLabel2:setFillColor( 0, 0, 0 )
    emailField2 = CTextField.new(870, 800, 240, 40)
    emailField2:setKeyboardType("email")
    emailField2:setDelegate(addressInformationView, "emailField2")
    
    mirrorDataButtonLabel = display.newText("Ziyaret adresim aynı zamanda düzenli iletişim adresim.", 620, 880, 0, 0, native.systemFont, 12)
    mirrorDataButtonLabel:setFillColor( 0.5, 1 )
    mirrorDataButton = display.newImageRect("Assets/SwitchButton.png", 48, 20)
    mirrorDataButton.x = 60
    mirrorDataButton.y = 880
    mirrorData = false
    mirrorDataButton:addEventListener("touch", mirrorDataButtonTouched)
    
    communicationButtonLabel = display.newText("Fatura adresim ziyaret adresimle aynı.", 120, 880, 0, 0, native.systemFont, 12)
    communicationButtonLabel:setFillColor( 0.5, 1 )
    communicationButton = display.newImageRect("Assets/SwitchButton.png", 48, 20)
    communicationButton.x = 560
    communicationButton.y = 880
    communicationData = false
    communicationButton:addEventListener("touch", communicationButtonTouched)
    
    function addressInformationView.didHideDDMTable( ID, isTableHidden)
        if( ID ==  "CityField1" )then
            phoneLabel1.isVisible = isTableHidden
            phoneField1:hide(not isTableHidden)
            faxLabel1.isVisible = isTableHidden
            faxField1:hide(not isTableHidden)
        elseif( ID == "CityField2" )then
            phoneLabel2.isVisible = isTableHidden
            phoneField2:hide(not isTableHidden)
            faxLabel2.isVisible = isTableHidden
            faxField2:hide(not isTableHidden)
        elseif( ID == "CountyField1" )then
            mobileLabel1.isVisible = isTableHidden
            mobileField1:hide(not isTableHidden)
            emailLabel1.isVisible = isTableHidden
            emailField1:hide(not isTableHidden)
        elseif( ID == "CountyField2" )then
            mobileLabel2.isVisible = isTableHidden
            mobileField2:hide(not isTableHidden)
            emailLabel2.isVisible = isTableHidden
            emailField2:hide(not isTableHidden)
        end
    end
    cityField1 = DropDownMenu.new{
                                dataList = getDropDownList(DataService.cities),
                                ID = "CityField1",
                                parent = addressInformationView,
                                delegate = addressInformationView,
                                buttonWidth = 240,
                                buttonHeight = 40,
                                x = 50,
                                y = 660,
                            }
    
    countyLabel1 = display.newText( "İlçe", 320, 640, native.systemFontBold, 15 )
    countyLabel1:setFillColor( 0, 0, 0 )
    --countyField1 = CTextField.new(310, 660, 240, 40)
    countyField1 = DropDownMenu.new{
                                ID = "CountyField1",
                                parent = addressInformationView,
                                delegate = addressInformationView,
                                buttonWidth = 240,
                                buttonHeight = 40,
                                x = 310,
                                y = 660,
                            }
    
    cityLabel2 = display.newText( "İl", 620, 640, native.systemFontBold, 15 )
    cityLabel2:setFillColor( 0, 0, 0 )
    --cityField2 = CTextField.new(610, 660, 240, 40)
    cityField2 = DropDownMenu.new{
                                dataList = getDropDownList(DataService.cities),
                                ID = "CityField2",
                                parent = addressInformationView,
                                delegate = addressInformationView,
                                buttonWidth = 240,
                                buttonHeight = 40,
                                x = 610,
                                y = 660,
                            }
    
    countyLabel2 = display.newText( "İlçe", 880, 640, native.systemFontBold, 15 )
    countyLabel2:setFillColor( 0, 0, 0 )
    --countyField2 = CTextField.new(870, 660, 240, 40)
    countyField2 = DropDownMenu.new{
                                ID = "CountyField2",
                                parent = addressInformationView,
                                delegate = addressInformationView,
                                buttonWidth = 240,
                                buttonHeight = 40,
                                x = 870,
                                y = 660,
                            }
    
    
    
    function addressInformationView:hideGroup ( isHidden )
            
        addressField1:hide(isHidden)
        postalCodeField1:hide(isHidden)
        --cityField1:hide(isHidden)
        --countyField1:hide(isHidden)
        phoneField1:hide(isHidden)
        mobileField1:hide(isHidden)
        faxField1:hide(isHidden)
        emailField1:hide(isHidden)
        addressField2:hide(isHidden)
        postalCodeField2:hide(isHidden)
        --cityField2:hide(isHidden)
        --countyField2:hide(isHidden)
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
            AddressDetailVisiting = addressField1:getText(),
            PostalCodeVisiting = postalCodeField1:getText(),
            CityVisiting = cityField1:getID(),
            CountyVisiting = countyField1:getID(),
            TelephoneVisiting = phoneField1:getText(),
            MobilePhoneVisiting = mobileField1:getText(),
            FaxVisiting = faxField1:getText(),
            EmailVisiting = emailField1:getText(),
            AddressDetailInvoice = addressField1:getText(),
            PostalCodeInvoice = postalCodeField1:getText(),
            CityInvoice = cityField1:getID(),
            CountyInvoice = countyField1:getID(),
            TelephoneInvoice = phoneField1:getText(),
            MobilePhoneInvoice = mobileField1:getText(),
            FaxInvoice = faxField1:getText(),
            EmailInvoice = emailField1:getText(),
            SameVisitingAndContactAddress= communicationData,
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
    
    contentView:insert( mirrorDataButtonLabel )
    contentView:insert( mirrorDataButton )
    contentView:insert( communicationButtonLabel )
    contentView:insert( communicationButton )
    
    
    addressInformationView:insert( contentView )
    addressInformationView.y = 220
    --addressInformationView.y = -220
    
    function addressInformationView:onViewInit()
        cityField1.addListener()
        countyField1.addListener()
        cityField2.addListener()
        countyField2.addListener()
    end
    
    function addressInformationView:onViewDelete()
        cityField1.destroy()
        countyField1.destroy()
        cityField2.destroy()
        countyField2.destroy()
    end
    
    local function setFocus ( yPos )
        delegate:setFocus( yPos )
    end 

    function addressInformationView:onInputBegan( event )
        setFocus(-230)
    end

    function addressInformationView:onInputEdit( event )
        if(mirrorData)then
            if( "addressField1" == event.target.iD )then
                addressField2:setText(addressField1:getText())
            elseif( "postalCode1" == event.target.iD )then
                postalCodeField2:setText(postalCodeField1:getText())
            elseif( "phoneField1" == event.target.iD )then
                phoneField2:setText(phoneField1:getText())
            elseif( "mobileField1" == event.target.iD )then
                mobileField2:setText(mobileField1:getText())
            elseif( "faxField1" == event.target.iD )then
                faxField2:setText(faxField1:getText())
            elseif( "addressField1" == event.target.iD )then
                addressField2:setText(addressField1:getText())
            elseif( "emailField1" == event.target.iD )then
                emailField2:setText(emailField1:getText())
            end
        end
    end

    function addressInformationView:onInputEnd( event )
        setFocus(0)
    end
    
    return addressInformationView
end

return AddressInformationView
