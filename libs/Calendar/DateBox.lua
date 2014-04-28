local DateBox = {}

local widget = require( "widget" )
local display = require( "display" )

function DateBox.new( dateBoxType, dateText, delegate, xPos, yPos, width, height )
    local dateBox = display.newGroup()
    local delegate = delegate
    local text = dateText
    local dateBoxType = dateBoxType
    local background = display.newRect(xPos, yPos, width, height )
    if( dateBoxType == DateBoxType.UnSellectable )then
        background:setFillColor( 165/255, 161/255, 155/255, 1 )
    elseif( dateBoxType == DateBoxType.Sellectable )then
        background:setFillColor( 255/255, 107/255, 0/255, 1 )
    elseif( dateBoxType == DateBoxType.Sellected )then
        background:setFillColor( 74/255, 74/255, 74/255, 1 )
    end
    
    local function onTap (event)
        if( dateBoxType == DateBoxType.UnSellectable )then
            return
        end
        
        local params =
        {
            day = text,
            sellected = dateBox
        }
        delegate:dateBoxDelegate(params)
        background:setFillColor( 74/255, 74/255, 74/255, 1 )
    end
    
    function dateBox:desellect()
        if( background~=nil)then
            background:setFillColor( 255/255, 107/255, 0/255, 1 )
        end
    end
    
    background:addEventListener( "tap", onTap )
    dateBox:insert( background )
     
    local dateTextLabel = display.newText( dateText, 0,0,0,0, native.systemFont, 8  )
    dateTextLabel.x = xPos+width/3
    dateTextLabel.y = yPos+height/3
    dateBox:insert(dateTextLabel)

    
    return dateBox
end

return DateBox
