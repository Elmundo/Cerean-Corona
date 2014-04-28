local AppointmentPlanningView = {}

local display = require( "display" )
local native = require( "native" )
local widget = require( "widget" )

local CLabel = require( "Views.Labels.Clabel" )
local Calendar = require( "libs.Calendar.Calendar")
local DataService = require( "Network.DataService" )


function AppointmentPlanningView.new()
    
    local phase
    local testData = {}
    
    testData[1] = "09:00-12:00"
    testData[2] = "12:00-15:00"
    testData[3] = "15:00-18:00"
    
    local centerX = display.contentCenterX
    local centerY = display.contentCenterY
    local defaultYPos = 150
    local appointmentPlanningGroup
    local appointmentPlanningBackground
    local appointmentPlanningHeaderText
    local appointmentPlanningHeaderBackground
    
    local contentGroup
    local backgroundLeftImage
    local backgroundRightImage
    local calendarView
    local hoursTableHeader
    local hourIcon
    local hoursTable
    
    local sellectedRow
    
    local publicFunctions = {}
    local dayData
    
    local function onRowTouch ( event )
        if( event.phase == "release" )then
            
            if( sellectedRow )then
                sellectedRow:setRowColor{ 
                    default = { 74/255, 74/255, 74/255, 1 },
                    over = { 74/255, 74/255, 74/255, 1 }
                }
            end
            
            hoursTable:getRowAtIndex( event.target.index ):setRowColor{
                default = { 0, 1, 0, 1 },
                over = { 0, 0, 0, 1}
            }
            
            sellectedRow = hoursTable:getRowAtIndex( event.target.index )
    
        end
        
    end 

    local function onRowRender( event )
        local row = event.row
        local id = row.index
        local params = event.row.params
        --[[]
        row.bg = display.newRoundedRect(2, 2, 116, 56, 2 ) 
        row.bg:setFillColor( 0.9, 0.9, 0.9 )
        row:insert( row.bg )
        ]]
        
        row.hour = CLabel.new( params, 20, 15, 15 )
        row.hour:setTextColor( 1, 1, 1, 1 )
        row:setRowColor{ 
            default = { 74/255, 74/255, 74/255, 1 },
            over = { 74/255, 74/255, 74/255, 1 }
        }
        row:insert( row.hour )
        
        return true   
    end
    
    
    
    appointmentPlanningGroup = display.newGroup()
    contentGroup = display.newGroup()
    
    function appointmentPlanningGroup:getContent( appStep )--?appStep
        local contentData = {}
            
            contentData = {
                ScheduledStart = "6 3 2014 00:00:00",
                IntervalTime = "16"
           } 
           
             
            return contentData
    end
    
    appointmentPlanningBackground = display.newRect( 40, defaultYPos, 1200, 550 )
    --appointmentPlanningBackground:setFillColor( 1, 1, 0 )
    
    appointmentPlanningHeaderBackground = display.newRoundedRect( 40, defaultYPos, 1200, 40, 5)
    appointmentPlanningHeaderBackground:setFillColor( 157/255, 20/255, 97/255 )
    
    appointmentPlanningHeaderText = display.newText( "Ziyaret Planlama", 60, defaultYPos+10, native.systemFontBold, 15 )
    appointmentPlanningHeaderText:setFillColor( 1,1,1 )
    if( phase ) then --FOR TEST
        backgroundLeftImage = display.newImageRect( "Assets/VisualManLeft.png", 142, 136  )
        backgroundLeftImage.x = 100
        backgroundLeftImage.y = centerY-136/2
        backgroundRightImage = display.newImageRect( "Assets/VisualManRight.png", 142, 136  )
        backgroundRightImage.x = 1180-142
        backgroundRightImage.y = centerY-136/2
        
    else 
        backgroundLeftImage = display.newImageRect( "Assets/VisualPhoneLeft.png", 102, 130  )
        backgroundLeftImage.x = 100
        backgroundLeftImage.y = centerY-130/2
        backgroundRightImage = display.newImageRect( "Assets/VisualPhoneRight.png", 102, 130  )
        backgroundRightImage.x = 1180-102
        backgroundRightImage.y = centerY-130/2
    end
    
    function publicFunctions:daySellected(newDayData)
        dayData = newDayData
        print( dayData )
        --
    end
    
    calendarView = Calendar.new( publicFunctions, 380, 260, 320, 320 )
    hoursTableHeader = display.newRect(710, 260, 120, 50)
    hoursTableHeader:setFillColor(0.5, 1)
    hourIcon = display.newImageRect("Assets/IconClock.png", 32, 32)
    hourIcon.x = 755
    hourIcon.y = 270
    hoursTable = widget.newTableView{
            left = 710,
            top = 310,
            width = 120,
            height = 270,
            backgroundColor = { 165/255, 161/255, 155/255, 1  },
            onRowRender = onRowRender,
            onRowTouch = onRowTouch,
            listener = scrollListener
    }
    local testt = #(DataService.timeIntervals)
    for i=1, #(DataService.timeIntervals) do
        hoursTable:insertRow{
            rowHeight = 60,
            rowWidth = 120,
            isCategory = false,
            lineColor = {0,0,0,0},
            rowColor = { default = {0, 1, 1, 0}, over = { 165/255, 161/255, 155/255, 1}, },--74/255, 74/255, 74/255, 1} },
            params = DataService.timeIntervals[i].Name,
        }
    end
    --[[]
    for j = 1, #(DataService.timeIntervals) do--hoursTable:getNumRows() do
        hoursTable:getRowAtIndex( j ):setRowColor(  
        { default = {1, 0, 0},
        over = { 0,1,0 } })
    end
    --]]
    contentGroup:insert( backgroundLeftImage )
    contentGroup:insert(backgroundRightImage )
    contentGroup:insert( calendarView )
    
    contentGroup:insert( hoursTableHeader )
    contentGroup:insert( hourIcon )
    contentGroup:insert( hoursTable ) 
    appointmentPlanningGroup:insert( appointmentPlanningBackground )
    appointmentPlanningGroup:insert( appointmentPlanningHeaderBackground )
    appointmentPlanningGroup:insert( appointmentPlanningHeaderText )
    appointmentPlanningGroup:insert( contentGroup )
    
    return appointmentPlanningGroup
    
end

return AppointmentPlanningView


