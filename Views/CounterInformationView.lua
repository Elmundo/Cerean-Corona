local display = require( "display" )
local native = require( "native" )
local widget = require( "widget" )

local CTextField = require( "Views.TextFields.CTextField" )
local DropDownMenu = require "libs.DDM.DropDownMenu"
local DataService = require( "Network.DataService" )

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

    local billImageScrollView

    counterInformationGroup = display.newGroup( )
    contentGroup = display.newGroup( )

    function counterInformationGroup:hideGroup( isHidden )
        --distrubitionCompanyField:hide(isHidden)
        --supplierCompanyField:hide(isHidden)
        companyCodeField:hide(isHidden)
        subscriberNumberField:hide(isHidden)
        recieptField:hide(isHidden)
        subscriberGroupField:hideDDM(isHidden)
        customerNameField:hide(isHidden)
        counterSerialNumberField:hide(isHidden)
        inductiveCounterSerialNumberField:hide(isHidden)
        counterMultiplierField:hide(isHidden)
        billAmountField:hide(isHidden)
    end
    
        

    function counterInformationGroup:getContent () 
        local contentData = {}

        contentData = {
            DistributorId = "19733ca2-0bf9-e211-ae2c-0050568e1778",--distrubitionCompanyField:getText()--Not TextField
            SkaDescId = "17d03b5d-6f87-e311-9572-0050568e1778",--supplierCompanyField:getText()
            CompanyCode = "035.25.16.51.56",--companyCodeField:getText()
            MembershipNumber = "16516516",--subscriberGroupField:getText()
            TariffCode = "546545",--recieptField:getText()
            MembershipGroup = "ff0f17d9-3003-e311-aa19-0050568e1778",--subscriberGroupField:getText()
            CustomerName = "Bahadır Böge",--customerNameField:getText()
            MeterSerialNumber = counterSerialNumberField:getText(),
            MeterSerialNumberAgain = inductiveCounterSerialNumberField:getText(),
            MeterParameter = "5465",--counterMultiplierField:getText()
            BillAmount = "454"--billAmountField:getText()
       } 

        return contentData
    end
    
    function counterInformationGroup.didHideDDMTable( ID, isTableHidden)
            if( ID == "DistrubitionCompany" )then
                print("IH8DZ")
                counterInformation.isVisible = isTableHidden
                companyCodeLabel.isVisible = isTableHidden
                companyCodeField:hide(not isTableHidden)
                recieptLabel.isVisible = isTableHidden
                recieptField:hide(not isTableHidden)
            elseif( ID == "SupplierCompany" )then
                
                subscriberNumberLabel.isVisible = isTableHidden
                subscriberNumberField:hide(not isTableHidden)
                subscriberGroupLabel.isVisible = isTableHidden
                --subscriberGroupField.hideDDM(isTableHidden)
            elseif( ID == "SubscriberGroup")then
                inductiveCounterSerialNumberLabel.isVisible = isTableHidden
                inductiveCounterSerialNumberField:hide(not isTableHidden)
            end
    end
    -------------------------------------------------------------------------------------------------------------
        -------------------------------------------------------------------------------------------------------------
        --DDM GROUP
        -------------------------------------------------------------------------------------------------------------
        -------------------------------------------------------------------------------------------------------------
        
        
        
        function counterInformationGroup.didDDMItemSelected(ddmValue, ID, index)
            if( ID == "DistrubitionCompany")then
                --TODO:setBillImage
            elseif( ID == "SupplierCompany" )then
                --TODO:setBillImage
            elseif( ID == "SubscriberGroup" )then
                --TODO:setBillImage
            end
        end
        

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
    
    --CTextField.new( 50, 505, 240, 30)
    --[[
    DropDownMenu.new{
                                dataList = getDropDownList(DataService.cities),
                                ID = "DistrubitionCompany",
                                parent = counterInformationGroup,
                                delegate = counterInformationGroup,
                                buttonWidth = 360,
                                buttonHeight = 40,
                                x = 50,
                                y = 680,
                            }
    --]]
    
    --[[]
    distrubitionCompanyField  = display.newRoundedRect( 50, 505, 240, 30, 5 )
    distrubitionCompanyField:setFillColor( 0.5, 0.5, 0.5 )
    --]]
    supplierCompanyLabel = display.newText( "Tedarik Şirketi Adı", 470, 490, native.systemFontBold, 15 )
    supplierCompanyLabel:setFillColor( 0,0,0 )
    
    --CTextField.new( centerX-60-120, 510, 240, 30)
    --[[]
    supplierCompanyField = display.newRoundedRect( centerX-60-120, 510, 240, 30, 5 )
    supplierCompanyField:setFillColor( 0.5, 0.5, 0.5 )
    --]]
    counterInformation = display.newText( "2. Sayaç Bilgileri", 60, 540, native.systemFontBold, 17 )
    counterInformation:setFillColor( 0, 0, 0 )

    companyCodeLabel = display.newText( "İşletme Kodu", 60, 555, native.systemFontBold, 15 )
    companyCodeLabel:setFillColor( 0,0,0 )
    companyCodeField = CTextField.new( 50, 575, 240, 30)
    companyCodeField:setKeyboardType("number")
    --[[]
    companyCodeField  = display.newRoundedRect( 50, 575, 240, 30, 5 )
    companyCodeField:setFillColor( 0.5, 0.5, 0.5 )
    --]]
    subscriberNumberLabel = display.newText( "Abone/Tesisat No", 470, 555, native.systemFontBold, 15 )
    subscriberNumberLabel:setFillColor( 0,0,0 )
    subscriberNumberField = CTextField.new( centerX-180, 575, 240, 30)
    subscriberNumberField:setKeyboardType("number")
    --[[]
    subscriberNumberField  = display.newRoundedRect( centerX-180, 575, 240, 30, 5 )
    subscriberNumberField:setFillColor( 0.5, 0.5, 0.5 )
    --]]
    recieptLabel = display.newText( "Tarife Kodu", 60, 605, native.systemFontBold, 15 )
    recieptLabel:setFillColor( 0,0,0 )
    recieptField = CTextField.new( 50, 625, 240, 30)
    recieptField:setKeyboardType("number")
    --[[]
    recieptField  = display.newRoundedRect( 50, 625, 240, 30, 5 )
    recieptField:setFillColor( 0.5, 0.5, 0.5 )
    --]]
    subscriberGroupLabel = display.newText( "Abone Grubu", 470, 605, native.systemFontBold, 15 )
    subscriberGroupLabel:setFillColor( 0,0,0 )
    --subscriberGroupField = CTextField.new( centerX-180, 625, 240, 30)
    --[[]
    subscriberGroupField  = display.newRoundedRect( centerX-180, 625, 240, 30, 5 )
    subscriberGroupField:setFillColor( 0.5, 0.5, 0.5 )
    --]]
    customerNameLabel = display.newText( "Müşteri Adı/Ünvanı", 60, 655, native.systemFontBold, 15 )
    customerNameLabel:setFillColor( 0,0,0 ) 
    customerNameField = CTextField.new( 50, 675, 240, 30)
    --[[]
    customerNameField = display.newRoundedRect( 50, 675, centerX-50, 30, 5 )
    customerNameField:setFillColor( 0.5,0.5,0.5 )
    -]]
    counterSerialNumberLabel = display.newText( "Aktif Sayaç Seri No", 60, 710, native.systemFontBold, 15 )
    counterSerialNumberLabel:setFillColor( 0,0,0 )
    counterSerialNumberField = CTextField.new( 50, 730, 240, 30)
    counterSerialNumberField:setKeyboardType("number")
    --[[]
    counterSerialNumberField  = display.newRoundedRect( 50, 730, 240, 30, 5 )
    counterSerialNumberField:setFillColor( 0.5, 0.5, 0.5 )
    --]]
    inductiveCounterSerialNumberLabel = display.newText( "Endüktif Sayaç Seri No", 470, 710, native.systemFontBold, 15 )
    inductiveCounterSerialNumberLabel:setFillColor( 0,0,0 )
    inductiveCounterSerialNumberField = CTextField.new( centerX-180, 730, 240, 30)
    inductiveCounterSerialNumberField:setKeyboardType("number")
    --[[]
    inductiveCounterSerialNumberField  = display.newRoundedRect( centerX-180, 730, 240, 30, 5 )
    inductiveCounterSerialNumberField:setFillColor( 0.5, 0.5, 0.5 )
    --]]
    counterMultiplierLabel = display.newText( "Sayaç Çarpanı", 60, 760, native.systemFontBold, 15 )
    counterMultiplierLabel:setFillColor( 0,0,0 )
    counterMultiplierField = CTextField.new( 50, 780, 240, 30)
    counterMultiplierField:setKeyboardType("number")
    --[[]
    counterMultiplierField  = display.newRoundedRect( 50, 780, 240, 30, 5 )
    counterMultiplierField:setFillColor( 0.5, 0.5, 0.5 )
    --]]
    billAmountLabel = display.newText( "Fatura Tutarı", 470, 760, native.systemFontBold, 15 )
    billAmountLabel:setFillColor( 0,0,0 )
    billAmountField = CTextField.new( centerX-180, 780, 240, 30)
    billAmountField:setKeyboardType("number")
    --[[]
    billAmountField  = display.newRoundedRect( centerX-180, 780, 240, 30, 5 )
    billAmountField:setFillColor( 0.5, 0.5, 0.5 )
    --]]
    
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
    subscriberGroupField = DropDownMenu.new{
                                dataList = getDropDownList(DataService.membershipgroups),
                                ID = "SubscriberGroup",
                                parent = counterInformationGroup,
                                delegate = counterInformationGroup,
                                buttonWidth = 240,
                                buttonHeight = 30,
                                visibleCellCount = 3,
                                x = centerX-180,
                                y = 625,
                            }
    
    distrubitionCompanyField = DropDownMenu.new{
                                dataList = getDropDownList(DataService.companies),
                                ID = "DistrubitionCompany",
                                parent = counterInformationGroup,
                                delegate = counterInformationGroup,
                                buttonWidth = 240,
                                buttonHeight = 30,
                                x = 50,
                                y = 505,
                            }
    supplierCompanyField = DropDownMenu.new{
                                dataList = getDropDownList(DataService.suppliers),
                                ID = "SupplierCompany",
                                parent = counterInformationGroup,
                                delegate = counterInformationGroup,
                                buttonWidth = 240,
                                buttonHeight = 30,
                                x = centerX-60-120,
                                y = 505,
                            }
                     
    local dummyBillImage = display.newImage("Assets/BillImages/Akdeniz.jpg", 0, 0, true)
    --display.newImageRect("Assets/BillImages/b_enerjisa.jpg", 510, 1285, true)
    --display.newImage("Assets/BillImages/b_enerjisa.jpg", 0, 0)
    --display.newImageRect("Assets/BillImages/Akdeniz.jpg", 510, 1285)
    
    billImageScrollView = widget.newScrollView{
        top = 465,
        left = 730,
        width = 510,
        height = 387,
        scrollWidth = 510,
        scrollHeight = 1432,
        -- Visual Options
        backgroundColor = { 0.8, 0.8, 0.8 }
    }
    billImageScrollView:insert(dummyBillImage)

    counterInformationGroup:insert(billImageScrollView)

    counterInformationGroup:insert( counterInformationGroupBackground )
    counterInformationGroup:insert( counterInformationHeaderBackground )
    counterInformationGroup:insert( counterInformationHeaderText )
    
    contentGroup:insert( subscriberGroupField )
    
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
    contentGroup:insert( billImageScrollView )

    counterInformationGroup:insert( contentGroup )

    counterInformationGroup.y = 230
    --counterInformationGroup.alpha = 0
    
    function counterInformationGroup:setCompany()
        local company = DataService:findCompanyForCity(DataService.selectedCity.id)
        if( company == nil )then
            print( "Nil City" )
        else 
            distrubitionCompanyField:updateButton(company)
            --[[
            distrubitionCompanyField:updateButton(company)
            billImageScrollView.dummyBillImage = display.newImage( "Assets/BillImages/" .. company.Image .. ".jpg", 0, 0, true)
            billImageScrollView = widget.newScrollView{
                    top = 465,
                    left = 730,
                    width = 510,
                    height = 387,
                    scrollWidth = 510,
                    scrollHeight = 1432,
                    -- Visual Options
                    backgroundColor = { 0.8, 0.8, 0.8 }
            }
            billImageScrollView:insert(dummyBillImage)

            counterInformationGroup:insert(billImageScrollView)
            --]]
        end
    end
    
    function counterInformationGroup:onViewInit()
        distrubitionCompanyField.addListener()
        supplierCompanyField.addListener()
        subscriberGroupField.addListener()
    end
    
    function counterInformationGroup:onViewDelete()
        distrubitionCompanyField.destroy()
        supplierCompanyField.destroy()
        subscriberGroupField.destroy()
    end 
    
    return counterInformationGroup
end

return CounterInformationView
