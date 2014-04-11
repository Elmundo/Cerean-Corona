-- Includes
local display = require "display" 
local widget  = require "widget"

-- DropDownMenu Module
local DropDownMenu = {}

-- Constant Values
local cDefaultFontSize          = 16
local cDefaultFont              = "DefaultFont"
local cDefaultVisibleCellCount  = 4
local cDefaultCellXPadding      = 6
local cDefaultBorder            = 3
local cDefaultButtonValue       = "SEÇİNİZ"

-- PARAMS
--[[ params = {
        x = 0,
        y = 0,
        buttonWidth = width,
        buttonHeight = height,
        defaultImage = dImage,
        overImage = oImage,
        noLines = false,
        visibleCellCount = count,
        cellData = cellData,
        userCustomDataList = Array,
    }
--]]
--[[ cellData = {
        isCategory = false,
        rowHeight = rh,
        rowColor = { default={0.8, 0.8, 0.8}, , over={ 1, 0.5, 0, 0.2 }  }
        lineColor = {1,0,0},
    }
--]]

function DropDownMenu.new( params )

    -- New DropDownMenu object
    local dropDownMenu  = display.newGroup()
    
    local cellData         = params.cellData or {}
    local x                = params.x
    local y                = params.y
    local noLines          = params.noLines
    local visibleCellCount = params.visibleCellCount or cDefaultVisibleCellCount
    local parent           = params.parent
    
    parent:insert(dropDownMenu)
    
    -- Properties
    local ddmTable       = nil
    local ddmTableBG     = nil
    local button         = nil
    local buttonBG       = nil
    local buttonLabel    = nil
    
    local ddmValue       = cDefaultButtonValue
    local isTableHidden = true
    
    -- Button Properties
    local buttonImage               = nil
    local buttonDefaultImageName    = (params.defaultImage or nil)
    local buttonOverImageName       = (params.overImage    or nil)
    local buttonWidth               = (params.buttonWidth  or 360)
    local buttonHeight              = (params.buttonHeight or 40)
    local isButtonActive            = false
    
    -- Cell Properties
    local isCategory    = cellData.isCategory or false
    local rowHeight     = cellData.rowHeight or buttonHeight
    local rowColor      = cellData.rowColor or { default={ 1, 1, 1 }, over={ 1, 0.5, 0, 0.2 } }
    local lineColor     = cellData.lineColor or { 0.5, 0.5, 0.5 }
    local cellHeight    = cellData.rowHeight or buttonHeight
    local cellWidth     = buttonWidth
    
    -- User Data List Property
    local dataList = params.dataList or {}
    
    dropDownMenu.x, dropDownMenu.y = x, y
    
    -- Instantiate Button
    buttonBG = display.newRoundedRect(dropDownMenu, -cDefaultBorder, -cDefaultBorder, buttonWidth + cDefaultBorder*2, buttonHeight + cDefaultBorder*2, 5)
    buttonBG:setFillColor( 0.5, 0.5, 0.5 )
    
    button = display.newRect(dropDownMenu, 0, 0, buttonWidth, buttonHeight)
    button:setFillColor( 1, 1, 1 )
    
    buttonLabel = display.newText(dropDownMenu, "SEÇİNİZ", 10, 10, buttonWidth, buttonHeight, nil, cDefaultFontSize)
    buttonLabel:setFillColor(0)
    
    -- Table Delegate - Touch Events
    function dropDownMenu.onRowTouch( event )

        if event.phase == "press" then

        elseif event.phase == "release" then
            local params = event.row.params
            ddmValue = params.value
            buttonLabel.text = ddmValue
            dropDownMenu:hideTable(true)
        end

    end

    function dropDownMenu.onRowRender( event )

        local row    = event.row
        local params = event.row.params

        local rowHeight = row.contentHeight
        local rowWidth  = row.contentWidth

        local rowTitle  = display.newText(row, params.value, 0, 0, rowWidth, rowHeight, nil, cDefaultFontSize)
        rowTitle:setFillColor(0)

        rowTitle.anchorY = 0.5
        rowTitle.x = 6
        rowTitle.y = (rowHeight * 0.5) + cDefaultFontSize/2

    end
    
     -- Instantiate Table
    ddmTableBG = display.newRoundedRect(-cDefaultBorder,cellHeight, buttonWidth + cDefaultBorder*2, (visibleCellCount * cellHeight) + cDefaultBorder*2, 5)
    ddmTableBG:setFillColor( 0.5, 0.5, 0.5 )
    
    ddmTable = widget.newTableView{
        width = buttonWidth,
        height = visibleCellCount * cellHeight,
        x = 0,
        y = buttonHeight + 2,
        
        noLines = (noLines or true),
        backgroundColor = { 1, 1, 1 },
        
        onRowTouch = dropDownMenu.onRowTouch,
        onRowRender = dropDownMenu.onRowRender,
    }
    dropDownMenu:insert(dropDownMenu.numChildren+1, ddmTableBG)
    dropDownMenu:insert(dropDownMenu.numChildren+1, ddmTable)
    
    --Instantiate ddm table
    for i = 1, #dataList do
        local value = dataList[i]
        
        ddmTable:insertRow{
                         
                                isCategory = isCategory,
                                rowHeight  = rowHeight,
                                rowColor   = rowColor,
                                lineColor  = lineColor,
                                params     = {value = value}
                          }
    end
    
    -- Drop Down Menu Methods
    function dropDownMenu:laodData(dataList)
        for i = 1, #dataList do
            local value = dataList[i]

            ddmTable:insertRow{

                                    isCategory = isCategory,
                                    rowHeight  = rowHeight,
                                    rowColor   = rowColor,
                                    lineColor  = lineColor,
                                    params     = {value = value}
                              }
        end
    end
    
    function dropDownMenu:insertRow(value)
        ddmTable:insertRow{

                                isCategory = isCategory,
                                rowHeight  = rowHeight,
                                rowColor   = rowColor,
                                lineColor  = lineColor,
                                params     = {value = value}
                          }
    end
    
    function dropDownMenu:removeRow(value)
        ddmTable:deleteRow{

                                isCategory = isCategory,
                                rowHeight  = rowHeight,
                                rowColor   = rowColor,
                                lineColor  = lineColor,
                                params     = {value = value}
                          }
    end
    
    function dropDownMenu:hideTable(value)
        isTableHidden        = value
        ddmTable.isVisible   = not isTableHidden
        ddmTableBG.isVisible = not isTableHidden
    end
    
    -- Button Touch Methods
    function dropDownMenu:touch(event)
        
        if event.phase == "began" then
        
        elseif event.phase == "moved" then
        
        elseif event.phase == "ended" then
            self:hideTable(not isTableHidden)
        end
        
        return true
    end
    
    function dropDownMenu:tap(event)
        return true
    end
    
    -- Catch the userInput event which is dispatched by native textfields
    local function hideDDMTable( event )
        dropDownMenu:hideTable(true)
    end

    -- GETTER METHODS
    function dropDownMenu:getValue()
        return ddmValue
    end
    
    -- Add event listeners
    dropDownMenu:addEventListener("touch", dropDownMenu)
    dropDownMenu:addEventListener("tap", dropDownMenu)
    Runtime:addEventListener("userInput", hideDDMTable)
    Runtime:addEventListener("tap", hideDDMTable)
    
    -- Default visibilty of table is false
    dropDownMenu:hideTable(isTableHidden)
    
    return dropDownMenu
end

return DropDownMenu
