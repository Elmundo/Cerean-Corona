local Calendar = {}

local widget = require( "widget" )
local display = require( "display" )

function Calendar.new( xPos, yPos, width, height )
    local calendar = display.newGroup()
    
    local date = os.date("*t")
    local curMonth = date.month
    local curYear = date.year
    
    local monthName = {
        "Ocak", "Şubat", "Mart", "Nisan", "Mayıs", "Haziran", "Temmuz", "Ağustos", "Eylül", "Ekim", "Kasım", "Aralık"
    }
    
    local function getDaysInMonth( month, year )
        local daysInMonth = { 
            31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 
        }
        local returnData = daysInMonth[month]
        
        if( month == 2 )then
            if( year%4 == 0 and ( year%100~=0 or year%400==0 ) )then
                returnData = 29
            end
        end
        
        return returnData
    end
    
    local daysOfWeek = {
        "Ptesi", "Salı", "Çar", "Per", "Cuma", "Ctesi", "Pazar"
    }
    local function getStartDay ( curMonth, curYear )
        local temp = os.time{
            year = curYear, month = curMonth, day = 1 
        }
        return tonumber(  os.date("%w", temp))
    end
    
    local function getEndDay ( curMonth, curYear )
        return tonumber(getDaysInMonth(curMonth, curYear))
    end
    
    local function createCalendar ( month, year )
        local previosMonth = month - 1
        local previousYear = year - 1
        
        if( previosMonth<1 )then
            previosMonth = 12
            previousYear = previousYear - 1
        end
        
        local previousDays = false
        local previousStartDay
        local previousEndDay
        
        local sellectedMonth = month
        local sellectedYear = year
        local sellectedDays = false
        local sellecetedStartDay = getStartDay(month, year) + 1
        local sellectedEndDay = getEndDay(month, year)
        
        local nextMonth = month + 1
        local nextYear = year
        if( nextMonth == 13 )then
            nextMonth = 1
            nextYear = nextYear + 1
        end
        local nextDays = false
        local nextStartDay = 1
        local nextEndDay
        
        local daysToSellectedMonth = 1 - sellecetedStartDay
        if( daysToSellectedMonth < 0 )then
            previousDays = true
        end
        if( previousDays )then
            previousEndDay = getDaysInMonth(previosMonth, previousYear)
            previousStartDay = previousEndDay + daysToSellectedMonth
        end
        
        --Show Sellected Month Year
        local headerBox = display.newRect( 0, 0, 320, 100 )
        headerBox:setFillColor(0.5, 1)
        calendar:insert(headerBox)
        
        --Selected month name
        local monthName = display.newText( monthName[sellectedMonth], 0, 0, 0, 0, native.systemFont, 10 )
        monthName:setTextColor( 255, 255, 255 )
        monthName:setReferencePoint(display.CenterLeftReferencePoint)
        monthName.x = 5
        monthName.y = headerBox.y - 5
        calendar:insert(monthName)
        
        --Selected year name
        local yearName = display.newText( year, 0, 0, 0, 0, native.systemFont, 20 )
        yearName:setTextColor( 255, 255, 255 )
        yearName:setReferencePoint(display.CenterLeftReferencePoint)
        yearName.x = 360 + 5 - yearName.contentWidth
        yearName.y = headerBox.y - 5
        calendar:insert(yearName)
        
        
        
        
        
    end
    
    return calendar
end

return Calendar
