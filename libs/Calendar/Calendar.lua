local DateBox = require( "libs.Calendar.DateBox" )

local Calendar = {}



DateBoxType = {
    Sellectable = 1,
    Sellected = 2,
    UnSellectable = 3
}

local widget = require( "widget" )
local display = require( "display" )

function Calendar.new( delegate, xPos, yPos, width, height )
    local calendar = display.newGroup()
    local delegate = delegate
    local date = os.date("*t")
    --local thisDay = date.
    local thisMonth = date.month
    local curMonth = date.month
    local thisYear = date.year
    local curYear = date.year
    local lastSellecetedDateBox
    local monthName = {
        "Ocak", "Şubat", "Mart", "Nisan", "Mayıs", "Haziran", "Temmuz", "Ağustos", "Eylül", "Ekim", "Kasım", "Aralık"
    }
    local daysInMonth = { 
            31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 
        }
    local function getDaysInMonth( month, year )
        
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
        --[[]
        if( thisYear > curYear)then
            return daysInMonth[curMonth]
        elseif( thisMonth > curMonth )then
            return daysInMonth[curMonth]
        end
        --]]
        local temp = os.time{
            year = curYear, month = curMonth, day = 1 
        }
        local returnDay = tonumber(  os.date("%w", temp))
        return returnDay
    end
    
    local function getEndDay ( curMonth, curYear )
        return tonumber(getDaysInMonth(curMonth, curYear))
    end
    
    local function getWeekStart()
        local curDate = os.date("*t")
        local weekDay = os.date("%w")
        local monthEnd = daysInMonth[curDate.month]
        local nextMonday = curDate.day + 1 - weekDay 
        if( nextMonday<curDate.day)then
            nextMonday = nextMonday + 7
        elseif( nextMonday>monthEnd )then
            nextMonday = nextMonday - monthEnd
            curDate.month = curDate.month + 1
            if( curDate.month>12)then
                curDate.year = curDate.year + 1
                curDate.month = 1
            end
        end
        curDate.wday = 1
        curDate.day = nextMonday
        return curDate
    end
    
    local function createBackground()
        local background = display.newRect( 0, 0, width, height )
        calendar:insert( background )
    end
    
    
        createBackground()
        
        
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
        local sellecetedStartDay = getStartDay(month, year)

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
        if( daysToSellectedMonth ~= 0 )then
            previousDays = true
        end
        
        if( daysToSellectedMonth>0)then
            daysToSellectedMonth = daysToSellectedMonth - 7
        end
        if( previousDays )then
            previousEndDay = getDaysInMonth(previosMonth, previousYear)
            previousStartDay = previousEndDay + daysToSellectedMonth +1
        end
        
        --Show Sellected Month Year
        local headerBox = display.newRect( 0, 0, width, 50 )
        headerBox:setFillColor(0.5, 1)
        calendar:insert(headerBox)
        
        --Selected month name
        local monthName = display.newText( monthName[sellectedMonth], width/2-40, 10, 50, 10, native.systemFont, 10 )
        monthName:setTextColor( 255, 255, 255 )
        calendar:insert(monthName)
        
        --Selected year name
        local yearName = display.newText( year, width/2+15, 10, 50, 10, native.systemFont, 10 )
        yearName:setTextColor( 255, 255, 255 )
        calendar:insert(yearName)
        
        local weekDayNames = {}
        
        
        
        local function dateBoxSetup(boxHeight)
            
        end
        
        local function removeObjects()
            lastSellecetedDateBox = nil
            for i=calendar.numChildren,1,-1 do
                local child = calendar[i]
                child.parent:remove( child )
                child = nil
            end
        end

        
        local function previousMonthButtonTapped(event)
            --Remove all objects
            removeObjects()
            curMonth = curMonth - 1

            if curMonth < 1 then
                curMonth = 12
                curYear = curYear - 1
            end
        
            --Create background, buttons and calender. 
            createBackground()
            createCalendar(curMonth, curYear)
            --create_bg()
            --create_buttons()
            --create_calender( curYear, curMonth )
            print("BACK")
            
        end
        local function nextMonthButtonTapped(event)
            --Remove all objects
            removeObjects()
            curMonth = curMonth + 1
        
            if curMonth > 12 then
                curMonth = 1
                curYear = curYear + 1
            end
        
            --Create background, buttons and calender. 
            createBackground()
            createCalendar(curMonth, curYear)
            --create_bg()
            --create_buttons()
            --create_calender( curYear, curMonth )
            print("NEXT")
        end
        
        local function dayTapped ( event )
            print( event.target.text )
        end
        
        function calendar:dateBoxDelegate( params )
            if( lastSellecetedDateBox ~= nil )then
                lastSellecetedDateBox:desellect()
            end
            lastSellecetedDateBox = params.sellected
            local dayData = params.day .." ".. sellectedMonth .." "..sellectedYear
            delegate:daySellected(dayData)
        end
        local previousMonthButtonBackground = display.newRect(0, 0, 40, 40)
        previousMonthButtonBackground:setFillColor(0.5, 1)
        calendar:insert(previousMonthButtonBackground)
        local previousMonthButton = display.newImageRect("Assets/DSLCalendar-previousMonth.png", 12, 16)
        previousMonthButton.x = 10
        previousMonthButton.y = 8
        previousMonthButtonBackground:addEventListener( "tap", previousMonthButtonTapped )
        calendar:insert(previousMonthButton)
        
        local nextMonthButtonBackground = display.newRect(width-40, 0, 40, 40)
        nextMonthButtonBackground:setFillColor(0.5, 1)
        calendar:insert(nextMonthButtonBackground)
        local nextMonthButton = display.newImageRect("Assets/DSLCalendar-nextMonth.png", 12, 16)
        nextMonthButton.x = width-10-12
        nextMonthButton.y = 8
        nextMonthButtonBackground:addEventListener( "tap", nextMonthButtonTapped )
        calendar:insert(nextMonthButton)
        --AddNext and Back Buttons Here
        
        for i=1, 7 do
            weekDayNames[i] = display.newText( daysOfWeek[i], (i-0.7)*width/7, 35, width/7, 10, native.systemFont, 6 )
            weekDayNames[i]:setTextColor( 255, 255, 255 )
            calendar:insert(weekDayNames[i])
        end
        
        local calendarDay
        local calendarMonth
        local calendarYear
        local calendarEnd
        local calendarFirst = false
        local calendarWhatMonth
        local calendarRows = 6
        --[[]
        if( 34 - sellectedEndDay - sellecetedStartDay < 0 )then
            calendarRows = 6
        end
        --]]
        if( previousDays )then
            calendarDay = previousStartDay
            calendarMonth = previosMonth
            calendarYear = previousYear
            calendarEnd = previousEndDay
            calendarFirst = true
            calendarWhatMonth = 1
        else 
            calendarDay = sellecetedStartDay
            calendarMonth = sellectedMonth
            calendarYear = sellectedYear
            calendarEnd = sellectedEndDay
            calendarFirst = true
            calendarWhatMonth = 2
        end
        
        local x = 0
        local y = 50
        local weekStart = getWeekStart()
        for j=1, calendarRows do
            for i=1, 7 do
                local dayBox 
                --[[]
                if( calendarRows == 5 )then
                    foo( (height-50)/5 )
                    --dayBox = display.newRect( x, y, (width)/7, (height-50)/5 )
                else   
                    foo( (height-50)/6 )
                    --dayBox = display.newRect(x, y, (width)/7, (height-50)/6 )
                end
                --]]
                
                if( weekStart.year <= calendarYear )then
                    if( weekStart.month > calendarMonth )then
                        dayBox = DateBox.new(DateBoxType.UnSellectable, calendarDay, calendar, x, y,(width)/7, (height-50)/calendarRows )
                    elseif( weekStart.month == calendarMonth )then
                        if( weekStart.day > calendarDay )then
                            dayBox = DateBox.new(DateBoxType.UnSellectable, calendarDay, calendar, x, y,(width)/7, (height-50)/calendarRows )
                        else 
                            if( i==6 or i==7 )then
                                dayBox = DateBox.new(DateBoxType.UnSellectable, calendarDay, calendar, x, y,(width)/7, (height-50)/calendarRows )
                            else
                                dayBox = DateBox.new(DateBoxType.Sellectable, calendarDay, calendar, x, y,(width)/7, (height-50)/calendarRows )
                            end
                        end
                    else
                        if( i==6 or i==7 )then
                            dayBox = DateBox.new(DateBoxType.UnSellectable, calendarDay, calendar, x, y,(width)/7, (height-50)/calendarRows )

                        else
                            dayBox = DateBox.new(DateBoxType.Sellectable, calendarDay, calendar, x, y,(width)/7, (height-50)/calendarRows )
                        end
                    end
                else
                    dayBox = DateBox.new(DateBoxType.UnSellectable, calendarDay, calendar, x, y,(width)/7, (height-50)/calendarRows )
                end
                
                --[[]
                if( (weekStart.year <= thisYear) and (weekStart.month <= calendarMonth) and (weekStart.day <= calendarDay) )then
                    if calendarWhatMonth ~= 2 then
                        dayBox = DateBox.new(DateBoxType.UnSellectable, calendarDay, calendar, x, y,(width)/7, (height-50)/calendarRows )
                    elseif i == 6 or i == 7 then --Fills weekend days with a different color
                        dayBox = DateBox.new(DateBoxType.UnSellectable, calendarDay, calendar, x, y,(width)/7, (height-50)/calendarRows )
                    else
                        dayBox = DateBox.new(DateBoxType.Sellectable, calendarDay, calendar, x, y,(width)/7, (height-50)/calendarRows )
                    end
                else
                    dayBox = DateBox.new(DateBoxType.UnSellectable, calendarDay, calendar, x, y,(width)/7, (height-50)/calendarRows )
                end
                --]]
                
                
                
                
                
                
                calendar:insert(dayBox)
                 
                    if calendarDay == calendarEnd then
                        if calendarWhatMonth == 1 then
                            calendarDay = 1
                            calendarMonth = sellectedMonth
                            calendarYear = sellectedYear
                            calendarEnd = sellectedEndDay
                            calendarFirst = true
                            calendarWhatMonth = 2 
                        elseif calendarWhatMonth == 2 then
                            calendarDay = 1
                            calendarMonth = nextMonth
                            calendarYear = nextYear
                            calendarEnd = nextEndDay
                            calendarFirst = true
                            calendarWhatMonth = 3
                        end
                    else
                        calendarDay = calendarDay + 1
                    end
                    x = x+width/7
                end
                y = y +(height-50)/calendarRows
                x=0             
        end
    end
    
    createCalendar(curMonth, curYear)
    calendar.x = xPos
    calendar.y = yPos
    return calendar
end

return Calendar

