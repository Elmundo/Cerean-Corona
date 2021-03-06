

local display = require( "display" )
local native = require( "native" )
local widget = require( "widget" )
local DataService = require( "Network.DataService" )
local CTextField = require( "Views.TextFields.CTextField" )
local DropDownMenu = require "libs.DDM.DropDownMenu"

local EnterpriseInformationView = {}

function EnterpriseInformationView.new( delegate )
        
	local enterpriseInformationGroup
	local enterpriseInformationGroupBackground
	local enterpriseInformationHeaderText
	local enterpriseInformationHeaderBackground
	local contentGroup
        
        local delegate = delegate
        
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
        
        local counties

	local centerX = display.contentCenterX
	local centerY = display.contentCenterY
        
        enterpriseInformationGroup = display.newGroup( )
	contentGroup = display.newGroup( )
        
        local function setFocus ( yPos )
            delegate:setFocus( yPos )
        end 
        
        function enterpriseInformationGroup:onInputBegan( event )

            setFocus(-230)

        end

        function enterpriseInformationGroup:onInputEdit( event )

        end

        function enterpriseInformationGroup:onInputEnd( event )
            setFocus(0)
        end
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
        
        function enterpriseInformationGroup.didHideDDMTable( ID, isTableHidden)
            
        end
        
        function enterpriseInformationGroup.didDDMItemSelected(ddmValue, ID, index)
            if( ID == "CityField")then
                --local index = index
                --Enable DDM?
                --Start Spinner but first check for Corona Behaviour
                --Save Sellected City
                DataService.selectedCity = ddmValue
                --Get County List
                DataService:getParametersWithGuid(kParameterCounties, ddmValue.id, nil, function(responseData)
                    --Check for error
                    print("Success")
                    counties = getDropDownList(responseData)
                    countyField:loadData(counties)
                end, 
                    function(errorData)
                        --Error Handling
                        print("Fail")
                    end)
            elseif( ID == "CountyField") then
                
            end
        end
        -------------------------------------------------------------------------------------------------------------
        -------------------------------------------------------------------------------------------------------------
        --END DDM GROUP
        -------------------------------------------------------------------------------------------------------------
        -------------------------------------------------------------------------------------------------------------
        
        function enterpriseInformationGroup:hideGroup ( isHidden )
            
            companyNameField:hide(isHidden)
            taxOfficField:hide(isHidden)
            taxNumberField:hide(isHidden)
            representativeNameField:hide(isHidden)
            representativeLastNameField:hide(isHidden)
            representativePhoneField:hide(isHidden)
            phoneField:hide(isHidden)
            emailField:hide(isHidden)
            cityField:hideDDM(isHidden)
            countyField:hideDDM(isHidden)
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
    companyNameField:setDelegate(enterpriseInformationGroup, "companyNameField")
    
    taxOfficeLabel =  display.newText( "Vergi Dairesi", centerX-170, 500, native.systemFontBold, 15 )
    taxOfficeLabel:setFillColor( 0, 0, 0 )
    taxOfficField = CTextField.new(centerX-180, 520, 360, 40)
    taxOfficField:setDelegate(enterpriseInformationGroup, "taxOfficField")

    taxNumberLabel = display.newText( "Vergi Numarası", 2*centerX-400, 500, native.systemFontBold, 15 )
    taxNumberLabel:setFillColor( 0, 0, 0 )
    taxNumberField = CTextField.new(2*centerX-410, 520, 360, 40)
    taxNumberField:setKeyboardType("number")
    taxNumberField:setDelegate(enterpriseInformationGroup, "taxNumberField")
    
    representativeNameLabel = display.newText( "Şirket Yetkilisi Adı", 60, 570, native.systemFontBold, 15 )
    representativeNameLabel:setFillColor( 0,0,0 )
    representativeNameField = CTextField.new(50, 590, 360, 40)
    representativeNameField:setDelegate(enterpriseInformationGroup, "representativeNameField" )
    
    representativeLastNameLabel = display.newText( "Şirket Yetkilisi Soyadı", centerX-170, 570, native.systemFontBold, 15 )
    representativeLastNameLabel:setFillColor( 0,0,0 )
    representativeLastNameField = CTextField.new(centerX-180, 590, 360, 40)
    representativeLastNameField:setDelegate(enterpriseInformationGroup, "representativeLastNameField" )
    
    representativePhoneLabel = display.newText( "Yetkili Telefon Numarası", 2*centerX-400, 570, native.systemFontBold, 15 )
    representativePhoneLabel:setFillColor( 0,0,0 )
    representativePhoneField = CTextField.new(2*centerX-410, 590, 360, 40)
    representativePhoneField:setKeyboardType("phone")
    representativePhoneField:setDelegate(enterpriseInformationGroup, "representativePhoneField")
    
    phoneLabel = display.newText( "Sabit Telefon", 60, 640, native.systemFontBold, 15 )
    phoneLabel:setFillColor( 0,0,0 )
    phoneField = CTextField.new(50, 660, 360, 40)
    phoneField:setKeyboardType("phone")
    phoneField:setDelegate(enterpriseInformationGroup, "phoneField" )

    emailLabel = display.newText( "E-Posta Adresi", centerX-170, 640, native.systemFontBold, 15 )
    emailLabel:setFillColor( 0,0,0 )
    emailField = CTextField.new(centerX-180, 660, 360, 40)
    emailField:setKeyboardType("email")
    emailField:setDelegate(enterpriseInformationGroup, "emailField" )
    
    locationInformation = display.newText( "2. Konum Bilgileri", 60, 710, native.systemFontBold, 17 )
    locationInformation:setFillColor( 0, 0, 0 )

    cityLabel = display.newText( "İl", 60, 730, native.systemFontBold, 17 )
    cityLabel:setFillColor( 0, 0, 0 )
    cityField = DropDownMenu.new{
                                dataList = getDropDownList(DataService.cities),
                                ID = "CityField",
                                parent = enterpriseInformationGroup,
                                delegate = enterpriseInformationGroup,
                                visibleCellCount = 2,
                                buttonWidth = 360,
                                buttonHeight = 40,
                                x = 50,
                                y = 750,
                            }

    
    countyLabel = display.newText( "İlçe", centerX-170, 730, native.systemFontBold, 17 )
    countyLabel:setFillColor( 0, 0, 0 )
    countyField = DropDownMenu.new{
                                ID = "CountyField",
                                parent = enterpriseInformationGroup,
                                delegate = enterpriseInformationGroup,
                                visibleCellCount = 2,
                                buttonWidth = 360,
                                buttonHeight = 40,
                                x = centerX-180,
                                y = 750,
                            }
    
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
    
    function enterpriseInformationGroup:onViewInit()
        cityField.addListener()
        countyField.addListener()
    end
    
    function enterpriseInformationGroup:onViewDelete()
        cityField.destroy()
        countyField.destroy()
    end
    
    return enterpriseInformationGroup
end

return EnterpriseInformationView
