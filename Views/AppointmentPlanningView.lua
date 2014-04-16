local AppointmentPlanningView = {}

local display = require( "display" )
local native = require( "native" )
local widget = require( "widget" )

local CLabel = require( "Views.Labels.Clabel" )


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
    local hoursTable
    
    function onRowTouch ( event )
    --[[]
        for i = 1, hoursTable:getNumRows() do
            --print(hoursTable:getRowAtIndex( i ))
            hoursTable:getRowAtIndex( i ):setRowColor{
              default = { 74/255, 74/255, 74/255, 1 },
              over = { 74/255, 74/255, 74/255, 1 }
           }
        end
    --]]
        
        if( event.phase == "ended") then           
            for i = 1, hoursTable:getNumRows() do
                local curRow = hoursTable:getRowAtIndex( i )
                print( curRow )
                hoursTable:getRowAtIndex( i ):setRowColor  
                {   default = {1, 0, 0},
                    over = { 0,1,0 } }
            end
            event.target:setRowColor{ 
                default = { 74/255, 74/255, 74/255, 1 },
                over = { 74/255, 74/255, 74/255, 1 }
            }
            
            --[[
            hoursTable:getRowAtIndex( 1 ):setRowColor{ 
               default = { 1, 0, 0, 1 },--{ 74/255, 74/255, 74/255, 1 },
               over = { 74/255, 74/255, 74/255, 1 }
           }
           hoursTable:getRowAtIndex( 2 ):setRowColor{ 
               default = { 1, 0, 0, 1 },--{ 74/255, 74/255, 74/255, 1 },
               over = { 74/255, 74/255, 74/255, 1 }
           }
           hoursTable:getRowAtIndex( 3 ):setRowColor{ 
               default = { 1, 0, 0, 1 },--{ 74/255, 74/255, 74/255, 1 },
               over = { 74/255, 74/255, 74/255, 1 }
           }
           --]]
            --[[
            event.target:setRowColor{ 
                default = { 74/255, 74/255, 74/255, 1 },
                over = { 74/255, 74/255, 74/255, 1 }
            }
            --]]
        end
        --[[]
        for i=1, #testData do
            hoursTable:getRowAtIndex( i ):setRowColor( {default = {1, 1, 1, 1}, over = { 74/255, 74/255, 74/255, 1}} )
        end
        --]]
        --event.row.setFillColor( 1, 1, 0 )
    --event.phase="tap", "press", "release", "swipeLeft", "swipeRight"
    --event.target=row
    --event.target.index=index
    end 

    function onRowRender( event )
        local row = event.row
        local id = row.index
        local params = event.row.params
        --[[]
        row.bg = display.newRoundedRect(2, 2, 116, 56, 2 ) 
        row.bg:setFillColor( 0.9, 0.9, 0.9 )
        row:insert( row.bg )
        ]]
        
        row.hour = CLabel.new( params, 20, 15, 15 )
        row.hour:setTextColor( 165/255, 161/255, 155/255 )
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
    appointmentPlanningBackground:setFillColor( 1, 1, 0 )
    
    appointmentPlanningHeaderBackground = display.newRoundedRect( 40, defaultYPos, 1200, 40, 5)
    appointmentPlanningHeaderBackground:setFillColor( 157/255, 20/255, 97/255 )
    
    appointmentPlanningHeaderText = display.newText( "Ziyaret Planlama", 60, defaultYPos+10, native.systemFontBold, 15 )
    appointmentPlanningHeaderText:setFillColor( 1,1,1 )
    if( phase ) then
        backgroundLeftImage = display.newImageRect( "Assets/VisualManLeft.png", 142, 136  )
        backgroundLeftImage.x = 100
        backgroundLeftImage.y = centerY-136/2
        backgroundRightImage = display.newImageRect( "Assets/VisualManRight.png", 142, 136  )
        backgroundRightImage.x = 1180-142
        backgroundRighttImage.y = centerY-136/2
        
    else 
        backgroundLeftImage = display.newImageRect( "Assets/VisualPhoneLeft.png", 102, 130  )
        backgroundLeftImage.x = 100
        backgroundLeftImage.y = centerY-130/2
        backgroundRightImage = display.newImageRect( "Assets/VisualPhoneRight.png", 102, 130  )
        backgroundRightImage.x = 1180-102
        backgroundRightImage.y = centerY-130/2
    end
    
    --calendarView = display.
    hoursTable = widget.newTableView{
            left = 640,
            top = 320,
            width = 120,
            height = 220,
            backgroundColor = { 0.8, 0.8, 0.8, 0.8  },
            onRowRender = onRowRender,
            onRowTouch = onRowTouch,
            listener = scrollListener
    }
    
    for i=1, #testData do
        hoursTable:insertRow{
            rowHeight = 60,
            rowWidth = 120,
            isCategory = false,
            lineColor = {0,0,0,0},
            rowColor = { default = {0, 1, 1, 0}, over = { 74/255, 74/255, 74/255, 1} },
            params = testData[i]
        }
    end
    for j = 1, hoursTable:getNumRows() do
        hoursTable:getRowAtIndex( j ):setRowColor(  
        { default = {1, 0, 0},
        over = { 0,1,0 } })
    end
    contentGroup:insert( backgroundLeftImage )
    contentGroup:insert(backgroundRightImage )
    contentGroup:insert( hoursTable )
     
    appointmentPlanningGroup:insert( appointmentPlanningBackground )
    appointmentPlanningGroup:insert( appointmentPlanningHeaderBackground )
    appointmentPlanningGroup:insert( appointmentPlanningHeaderText )
    appointmentPlanningGroup:insert( contentGroup )
    
    return appointmentPlanningGroup
    
end

return AppointmentPlanningView


