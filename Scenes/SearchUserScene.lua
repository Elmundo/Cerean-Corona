local widget = require( "widget" )
local native = require( "native" )
local storyboard = require( "storyboard" )

local CTextField = require( "Views.TextFields.CTextField" )
local CLabel = require( "Views.Labels.CLabel" )
local CButton = require( "Views.Buttons.CButton" )
local ControlBar = require( "Views.ControlBar" )

local BaseScene   = require "Scenes.BaseScene"
local scene = BaseScene.new()

----------------------------------------------------------------------------------
-- 
--      NOTE:
--      
--      Code outside of listener functions (below) will only be executed once,
--      unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------


-- local forward references should go here --


---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
local centerX = display.contentCenterX
local centerY = display.contentCenterY

local controlBar
local headerImage

local cancelButton

local headerText
local searchFieldHeader
local searchField
local searchButton

local resultMessage
local resultTable
local doneSearch

local testData = {}


function onSearchButtonTouched ()
    testData[1] = { name="Bahadır BÖGE", customerID="12345"}
    testData[2] = { name="Mustafa BÖGE", customerID="12346"}
    testData[3] = { name="John DOE", customerID="12347"}
    testData[4] = { name="Jane DOE", customerID="12348"}
    testData[5] = { name="Jack SPARROW", customerID="12349"}
    --Clear TableView
    if( doneSearch ) then
        doneSearch = false
    else 
        doneSearch = true
        resultTable:reloadData()
    end
    
    if( doneSearch ) then
        onSearchComplete()
    end
end

function onSearchComplete ()
    resultTable:deleteAllRows()
    for i=1, #testData do
        resultTable:insertRow{
            rowHeight = 60,
            isCategory = false,
            rowColor = { default = {1, 0, 0, 0}, over = { 0, 0, 0, 0} },
            params = {
                name = testData[i].name,
                id = testData[i].customerID
            }
        }
    end
end

function onRowTouch ( event )
--event.phase="tap", "press", "release", "swipeLeft", "swipeRight"
--event.target=row
--event.target.index=index
end 

function onRowRender( event )
    local row = event.row
    local id = row.index
    local params = event.row.params
    
    row.bg = display.newRect( 0, display.contentHeight-2, display.contentWidth, 2 )
    row.bg:setFillColor( 0, 1, 0 )
    row:insert( row.bg )
    
    row.editButton = CButton.new( "Düzenle", params.id, onEditButtonTouched, 15, 10  )
    row:insert( row.editButton )

    row.nameText = CLabel.new( params.name, 320, 15, 15 )
    row.nameText:setTextColor( 165/255, 161/255, 155/255 )
    row:insert( row.nameText )
    
    row.id = CLabel.new( params.id, 170, 15, 15 )
    row:insert( row.id )
    return true   
end

function scrollListener ( event )
--event.phase="began", "moved", "ended"
--event.limitReached for border check
--event.direction "up", "down"
end
-- Called when the scene's view does not exist:
function scene:createScene( event )
        local group = self.view
        
        doneSearch = false
        --logo = display.newImage( "Assets/Logo.png", 50, 55, true )
        controlBar = ControlBar.new()
        headerImage = display.newImageRect( "Assets/MenuHeader.png", 1280, 100 )
        headerImage.x = 0
        headerImage.y = 50
        
        cancelButton = CButton.new( "VAZGEÇ", "cancelButton", onCancelButtonTouch, 1100, 80, 5 )
        
        --BOLD
        headerText = CLabel.new( "Sayaç Ekle", 50, 200, 20 )

        searchFieldHeader = CLabel.new( "Müşteri Kodu İle Ara", 50, 240, 15 )
        --MAY NEED TO RESIZE
        searchField = display.newRoundedRect(45, 260, 360, 40, 5)
        searchField:setFillColor( 165/255, 161/255, 155/255 )
        --CTextField.new( 45, 260 )
        searchButton = CButton.new( "ARA", "searchButton", onSearchButtonTouched, 415, 260 )
        
        
        resultTable = widget.newTableView{
            left = 40,
            top = 320,
            width = 1200,
            height = display.contentHeight - 320,
            onRowRender = onRowRender,
            onRowTouch = onRowTouch,
            listener = scrollListener
        }
        
        group:insert( controlBar )
        group:insert( headerImage )
        group:insert( cancelButton )
        group:insert( headerText )
        group:insert( searchFieldHeader )
        group:insert( searchField )
        group:insert( searchButton )

        -----------------------------------------------------------------------------

        --      CREATE display objects and add them to 'group' here.
        --      Example use-case: Restore 'group' from previously saved state.

        -----------------------------------------------------------------------------


end


-- Called BEFORE scene has moved onscreen:
function scene:willEnterScene( event )
        local group = self.view
        

        -----------------------------------------------------------------------------

        --      This event requires build 2012.782 or later.

        -----------------------------------------------------------------------------

end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
        local group = self.view
        
        -----------------------------------------------------------------------------

        --      INSERT code here (e.g. start timers, load audio, start listeners, etc.)

        -----------------------------------------------------------------------------

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
        local group = self.view

        -----------------------------------------------------------------------------

        --      INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)

        -----------------------------------------------------------------------------

end


-- Called AFTER scene has finished moving offscreen:
function scene:didExitScene( event )
        local group = self.view

        -----------------------------------------------------------------------------

        --      This event requires build 2012.782 or later.

        -----------------------------------------------------------------------------

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
        local group = self.view

        -----------------------------------------------------------------------------

        --      INSERT code here (e.g. remove listeners, widgets, save state, etc.)

        -----------------------------------------------------------------------------

end


-- Called if/when overlay scene is displayed via storyboard.showOverlay()
function scene:overlayBegan( event )
        local group = self.view
        local overlay_name = event.sceneName  -- name of the overlay scene
        
        -----------------------------------------------------------------------------

        --      This event requires build 2012.797 or later.

        -----------------------------------------------------------------------------

end


-- Called if/when overlay scene is hidden/removed via storyboard.hideOverlay()
function scene:overlayEnded( event )
        local group = self.view
        local overlay_name = event.sceneName  -- name of the overlay scene

        -----------------------------------------------------------------------------

        --      This event requires build 2012.797 or later.

        -----------------------------------------------------------------------------

end



---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "willEnterScene" event is dispatched before scene transition begins
scene:addEventListener( "willEnterScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "didExitScene" event is dispatched after scene has finished transitioning out
scene:addEventListener( "didExitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

-- "overlayBegan" event is dispatched when an overlay scene is shown
scene:addEventListener( "overlayBegan", scene )

-- "overlayEnded" event is dispatched when an overlay scene is hidden/removed
scene:addEventListener( "overlayEnded", scene )

---------------------------------------------------------------------------------

return scene
