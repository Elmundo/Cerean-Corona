local display = require( "display" )
local native = require( "native" )
local widget = require( "widget" )

local CTextField = require( "Views.TextFields.CTextField" )
local DropDownMenu = require "libs.DDM.DropDownMenu"
local DataService = require( "Network.DataService" )
local ImageMapper = require( "ImageMapper" )
local Logger = require "libs.Log.Logger"

local CounterInformationView = {}

function CounterInformationView.new(delegate)
    local  viewFontSize= 8
    
    local centerX = display.contentCenterX
    local centerY = display.contentCenterY
    local delegate = delegate
    local sellectedImageName
    
    local sellectionFieldMask
    
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
    
    local billImage
    local billImageScrollView

    counterInformationGroup = display.newGroup( )
    contentGroup = display.newGroup( )
    
    function counterInformationGroup:setCustomerName()
        if( DataService.phase == Phase.ApplicationPhase )then
            customerNameField:setText(DataService.customerName)
       elseif( DataService.phase == Phase.EditPhase or DataService.phase == Phase.RegistryPhase )then
           customerNameField:setText(DataService.customer.CustomerName)
        end
    end
    
    function counterInformationGroup:hideGroup( isHidden )
        distrubitionCompanyField:hideDDM(isHidden)
        supplierCompanyField:hideDDM(isHidden)
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
            DistributorId = distrubitionCompanyField:getID(),
            SkaDescId = supplierCompanyField:getID(),
            CompanyCode = companyCodeField:getText(),
            MembershipNumber = subscriberNumberField:getText(),
            TariffCode = recieptField:getText(),
            MembershipGroup = subscriberGroupField:getID(),
            --CustomerName = customerNameField:getText(),
            MeterSerialNumber = counterSerialNumberField:getText(),
            MeterSerialNumberAgain = inductiveCounterSerialNumberField:getText(),
            MeterParameter = counterMultiplierField:getText(),
            BillAmount = billAmountField:getText()
       } 
       if( DataService.phase == Phase.ApplicationPhase )then
            contentData.CustomerName = DataService.customerName
       elseif( DataService.phase == Phase.EditPhase or DataService.phase == Phase.RegistryPhase )then
           contentData.CustomerName = DataService.customer.CustomerName
           DataService.meterSerialNumber = counterSerialNumberField:getText()
        end
           
        return contentData
    end
    
    function counterInformationGroup:updateBillImage(imageName)
        if( billImage )then
            billImage:removeSelf()
            billImage = nil
        end
        billImage = display.newImage( "Assets/BillImages/" .. imageName .. ".jpg", 0, 0, true)
        if billImage then
            billImageScrollView:insert( billImage )
        else
            Logger:error(nil, "updateBillImage", "There is no such an image '" .. imageName .. "'")
        end
    end
    
    local function setBillImageOffset ( frame )
        billImageScrollView:setIsLocked( false )
        if( sellectionFieldMask )then
            sellectionFieldMask:removeSelf()
            sellectionFieldMask = nil
        end
        sellectionFieldMask = display.newRect( frame[1], frame[2], frame[3], frame[4] )
        --(frame[1]+billImageScrollView.x, billImageScrollView.y, frame[3], frame[4])
        sellectionFieldMask:setFillColor( 1, 0, 0, 0.5)
        billImageScrollView:insert(sellectionFieldMask)
        billImageScrollView:scrollToPosition
        {
            x = 0,
            y = -frame[2]+(billImageScrollView.height/2 ),
            time = 400,
            --onComplete = onScrollComplete
        }

        billImageScrollView:setIsLocked( true )
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
                if( not isTableHidden )then
                    if( sellectedImageName )then
                        local imageMapperPosition = ImageMapper:findFieldRect( sellectedImageName, "membershipGroup" )
                        setBillImageOffset(imageMapperPosition)
                    end
                end
                inductiveCounterSerialNumberLabel.isVisible = isTableHidden
                inductiveCounterSerialNumberField:hide(not isTableHidden)
            end
    end
    -------------------------------------------------------------------------------------------------------------
        -------------------------------------------------------------------------------------------------------------
        --DDM GROUP
        -------------------------------------------------------------------------------------------------------------
        -------------------------------------------------------------------------------------------------------------
        
        local function setFocus ( yPos )
            delegate:setFocus( yPos )
        end
        
        function counterInformationGroup:onInputBegan( event )
            if( sellectedImageName )then
                local imageMapperPosition = ImageMapper:findFieldRect( sellectedImageName, event.target.iD )
                setBillImageOffset(imageMapperPosition)
            end
            setFocus(-280)
        end
        
        function counterInformationGroup:onInputEdit( event )
            print "asd"
        end
        
        function counterInformationGroup:onInputEnd( event )
            setFocus(0)
        end
        
        function counterInformationGroup.didDDMItemSelected(ddmValue, ID, index)
            if( ID == "DistrubitionCompany")then
                --TODO:setBillImage
                print( "Here" )
                local companyID = ddmValue.id
                local imageName = DataService:findImageForCompany(companyID)
                counterInformationGroup:updateBillImage(imageName) 
                
                
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

    distrubitionCompanyLabel = display.newText( "Dağıtım Şirketi Adı", 60, 483, native.systemFontBold, 15 )
    distrubitionCompanyLabel:setFillColor( 0,0,0 )
    
    supplierCompanyLabel = display.newText( "Tedarik Şirketi Adı", 470, 483, native.systemFontBold, 15 )
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
    companyCodeField:setDelegate(counterInformationGroup, "companyCode")
    companyCodeField:setFont(native.systemFont, viewFontSize)
    --[[]
    companyCodeField  = display.newRoundedRect( 50, 575, 240, 30, 5 )
    companyCodeField:setFillColor( 0.5, 0.5, 0.5 )
    --]]
    subscriberNumberLabel = display.newText( "Abone/Tesisat No", 470, 555, native.systemFontBold, 15 )
    subscriberNumberLabel:setFillColor( 0,0,0 )
    subscriberNumberField = CTextField.new( centerX-180, 575, 240, 30)
    subscriberNumberField:setKeyboardType("number")
    subscriberNumberField:setDelegate(counterInformationGroup, "membershipNumber")
    subscriberNumberField:setFont(native.systemFont, viewFontSize)
    --subscriberNumberField:setDelegate(counterInformationGroup, "subscri")
    --[[]
    subscriberNumberField  = display.newRoundedRect( centerX-180, 575, 240, 30, 5 )
    subscriberNumberField:setFillColor( 0.5, 0.5, 0.5 )
    --]]
    recieptLabel = display.newText( "Tarife Kodu", 60, 605, native.systemFontBold, 15 )
    recieptLabel:setFillColor( 0,0,0 )
    recieptField = CTextField.new( 50, 625, 240, 30)
    recieptField:setKeyboardType("number")
    recieptField:setDelegate(counterInformationGroup, "tariffCode" )
    recieptField:setFont(native.systemFont, viewFontSize)
    --[[]
    recieptField  = display.newRoundedRect( 50, 625, 240, 30, 5 )
    recieptField:setFillColor( 0.5, 0.5, 0.5 )
    --]]
    subscriberGroupLabel = display.newText( "Abone Grubu", 470, 605, native.systemFontBold, 15 )
    subscriberGroupLabel:setFillColor( 0,0,0 )
    
    customerNameLabel = display.newText( "Müşteri Adı/Ünvanı", 60, 655, native.systemFontBold, 15 )
    customerNameLabel:setFillColor( 0,0,0 ) 
    
    customerNameField = CTextField.new( 50, 675, 240, 30, true)  
    customerNameField:setDelegate(counterInformationGroup, "customerName")
    customerNameField:setFont(native.systemFont, viewFontSize)
    --[[]
    customerNameField = display.newRoundedRect( 50, 675, centerX-50, 30, 5 )
    customerNameField:setFillColor( 0.5,0.5,0.5 )
    -]]
    counterSerialNumberLabel = display.newText( "Aktif Sayaç Seri No", 60, 710, native.systemFontBold, 15 )
    counterSerialNumberLabel:setFillColor( 0,0,0 )
    counterSerialNumberField = CTextField.new( 50, 730, 240, 30)
    counterSerialNumberField:setKeyboardType("number")
    counterSerialNumberField:setDelegate(counterInformationGroup, "meterSerialNumber")
    counterSerialNumberField:setFont(native.systemFont, viewFontSize)
    --[[]
    counterSerialNumberField  = display.newRoundedRect( 50, 730, 240, 30, 5 )
    counterSerialNumberField:setFillColor( 0.5, 0.5, 0.5 )
    --]]
    inductiveCounterSerialNumberLabel = display.newText( "Endüktif Sayaç Seri No", 470, 710, native.systemFontBold, 15 )
    inductiveCounterSerialNumberLabel:setFillColor( 0,0,0 )
    inductiveCounterSerialNumberField = CTextField.new( centerX-180, 730, 240, 30)
    inductiveCounterSerialNumberField:setKeyboardType("number")
    inductiveCounterSerialNumberField:setDelegate(counterInformationGroup, "meterSerialNumberAgain")
    inductiveCounterSerialNumberField:setFont(native.systemFont, viewFontSize)
    --[[]
    inductiveCounterSerialNumberField  = display.newRoundedRect( centerX-180, 730, 240, 30, 5 )
    inductiveCounterSerialNumberField:setFillColor( 0.5, 0.5, 0.5 )
    --]]
    counterMultiplierLabel = display.newText( "Sayaç Çarpanı", 60, 760, native.systemFontBold, 15 )
    counterMultiplierLabel:setFillColor( 0,0,0 )
    counterMultiplierField = CTextField.new( 50, 780, 240, 30)
    counterMultiplierField:setKeyboardType("number")
    counterMultiplierField:setDelegate(counterInformationGroup, "meterParameter")
    counterMultiplierField:setFont(native.systemFont, viewFontSize)
    --[[]
    counterMultiplierField  = display.newRoundedRect( 50, 780, 240, 30, 5 )
    counterMultiplierField:setFillColor( 0.5, 0.5, 0.5 )
    --]]
    billAmountLabel = display.newText( "Fatura Tutarı", 470, 760, native.systemFontBold, 15 )
    billAmountLabel:setFillColor( 0,0,0 )
    billAmountField = CTextField.new( centerX-180, 780, 240, 30)
    billAmountField:setKeyboardType("number")
    billAmountField:setDelegate(counterInformationGroup, "billAmount")
    billAmountField:setFont(native.systemFont, viewFontSize)
    --[[]
    billAmountField  = display.newRoundedRect( centerX-180, 780, 240, 30, 5 )
    billAmountField:setFillColor( 0.5, 0.5, 0.5 )
    --]]
    
    local function getDropDownList( dataTable )
            local returnTable = {}
            if( dataTable == nil )then
                    print "Error with Name of DDM"
                end
        
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
                                y = 628,
                            }
    
    distrubitionCompanyField = DropDownMenu.new{
                                dataList = getDropDownList(DataService.companies),
                                ID = "DistrubitionCompany",
                                parent = counterInformationGroup,
                                delegate = counterInformationGroup,
                                buttonWidth = 240,
                                buttonHeight = 30,
                                x = 50,
                                y = 508,
                                fontSize = 10,
                            }
    supplierCompanyField = DropDownMenu.new{
                                dataList = getDropDownList(DataService.suppliers),
                                ID = "SupplierCompany",
                                parent = counterInformationGroup,
                                delegate = counterInformationGroup,
                                buttonWidth = 240,
                                buttonHeight = 30,
                                x = centerX-60-120,
                                y = 508,
                            }
                     
    billImage = display.newImage("Assets/BillImages/AKDENIZ.jpg", 0, 0, true)
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
        --backgroundColor = { 0.8, 0.8, 0.8 }
    }
    billImageScrollView:setIsLocked(true)
    billImageScrollView:insert(billImage)

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
    
    function counterInformationGroup:setCompany(cityId)
        local company = nil
        if cityId then
            company = DataService:findCompanyForCity(cityId)
        else
            company = DataService:findCompanyForCity(DataService.selectedCity.id)
        end
        
        if( company == nil )then
            Logger:error("CounterInformationView", "setCompany", "Company data is null so there is no Image name!")
        else 
            sellectedImageName = company.Image
            distrubitionCompanyField:updateWithId(company.Name, company.ID)
            counterInformationGroup:updateBillImage(company.Image)
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
