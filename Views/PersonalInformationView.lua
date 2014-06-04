local display = require( "display" )
local native = require( "native" )
local widget = require( "widget" )
local DataService = require( "Network.DataService" )
local CTextField = require( "Views.TextFields.CTextField" )
local DropDownMenu = require "libs.DDM.DropDownMenu"

local PersonalInformationView = {}

function PersonalInformationView.new(delegate)
        
        
	local personalInformationGroup
	local personalInformationGroupBackground
	local personalInformationHeaderText
	local personalInformationHeaderBackground
	local contentGroup

        local delegate = delegate
        
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

        local counties

	local centerX = display.contentCenterX
	local centerY = display.contentCenterY
        
        personalInformationGroup = display.newGroup( )
	contentGroup = display.newGroup( )
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
        
        function personalInformationGroup.didDDMItemSelected(ddmValue, ID, index)
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
        
        function personalInformationGroup:hideGroup ( isHidden )
            
            nameField:hide(isHidden)
            iDNumberField:hide(isHidden)
            mobileField:hide(isHidden)
            emailField:hide(isHidden)
            cityField:hideDDM(isHidden)
            countyField:hideDDM(isHidden)
            --cityField:hide(isHidden)
            --countyField:hide(isHidden)
            --[[]
            if( isHidden )then
                contentGroup.alpha = 0
            else 
                nameField:hide(false)
                contentGroup.alpha = 1
            end
            --]]
        end
        
        function personalInformationGroup.didHideDDMTable( ID, isTableHidden)
            
        end
        
        function personalInformationGroup:getContent () 
            local contentData = {}
            
            DataService.customerPhone = mobileField:getText()
            DataService.customerEmail = emailField:getText()
            DataService.customerName = nameField:getText()
            contentData = {
                Name = nameField:getText(),
                TckNo = iDNumberField:getText(),
                MobilePhone = mobileField:getText(),
                Email = emailField:getText(),
                CityId = cityField:getID(),--cityField:getText(),
                --DataService.selectedCity = DataService.cities
                
                CountyId = countyField:getID(),--countyField:getText()
            }
             
            return contentData
        end
        
	

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
    nameField = CTextField.new(50, 520, 360, 40)
    nameField:setDelegate(personalInformationGroup, "nameField")

    iDNumberLabel =  display.newText( "TC Kimlik No", centerX-170, 500, native.systemFontBold, 15 )
    iDNumberLabel:setFillColor( 0, 0, 0 )
    iDNumberField = CTextField.new(centerX-180, 520, 360, 40)
    iDNumberField:setKeyboardType("number")
    iDNumberField:setDelegate(personalInformationGroup, "iDNumberField")

    mobileLabel = display.newText( "Mobil Telefon", 2*centerX-400, 500, native.systemFontBold, 15 )
    mobileLabel:setFillColor( 0, 0, 0 )
    mobileField = CTextField.new(2*centerX-410, 520, 360, 40)
    mobileField:setKeyboardType("phone")
    mobileField:setDelegate(personalInformationGroup, "mobileField")

    emailLabel = display.newText( "E-Posta Adresi", 60, 570, native.systemFontBold, 15 )
    emailLabel:setFillColor( 0,0,0 )
    emailField = CTextField.new(50, 590, 360, 40)
    emailField:setKeyboardType("email")
    emailField:setDelegate(personalInformationGroup, "emailField")

    locationInformation = display.newText( "2. Konum Bilgileri", 60, 635, native.systemFontBold, 17 )
    locationInformation:setFillColor( 0, 0, 0 )

    cityLabel = display.newText( "İl", 60, 655, native.systemFontBold, 17 )
    cityLabel:setFillColor( 0, 0, 0 )
    local dataList = DataService.cities
    
    cityField = DropDownMenu.new{
                                dataList = getDropDownList(DataService.cities),
                                ID = "CityField",
                                parent = personalInformationGroup,
                                delegate = personalInformationGroup,
                                buttonWidth = 360,
                                buttonHeight = 40,
                                x = 50,
                                y = 680,
                            }
    
    countyLabel = display.newText( "İlçe", centerX-170, 655, native.systemFontBold, 17 )
    countyLabel:setFillColor( 0, 0, 0 )
    countyField = DropDownMenu.new{
                                ID = "CountyField",
                                parent = personalInformationGroup,
                                delegate = personalInformationGroup,
                                buttonWidth = 360,
                                buttonHeight = 40,
                                x = centerX-180,
                                y = 680,
                            }

    
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
    
    function personalInformationGroup:onViewInit()
        cityField.addListener()
        countyField.addListener()
    end
    
    function personalInformationGroup:onViewDelete()
        cityField.destroy()
        countyField.destroy()
    end
    
    local function setFocus ( yPos )
        delegate:setFocus( yPos )
    end 

    function personalInformationGroup:onInputBegan( event )
        
        setFocus(-230)

    end

    function personalInformationGroup:onInputEdit( event )
        if( "nameField" == event.target.iD )then
            
        elseif( "iDNumberField" == event.target.iD )then
            
            if( event.text)then
                if(string.len(event.text) > 11 )then
                    iDNumberField:setText(event.text:sub(1, 11))
                else
                    if( tonumber(event.newCharacters) )then
                        
                    else
                        iDNumberField:setText(event.text:sub(1, string.len(event.text)-1))
                    end
                end
            end
        elseif( "mobileField" == event.target.iD )then
            local test = addLetterToStringForPhone(event.text:sub(1, string.len(event.text)-1), event.newCharacters)
            mobileField:setText(test)
            --print(test)
        end
    end

    function personalInformationGroup:onInputEnd( event )
        setFocus(0)
    end
    
    return personalInformationGroup
end

return PersonalInformationView
