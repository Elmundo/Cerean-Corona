local widget = require( "widget" )
local native = require( "native" )
local storyboard = require( "storyboard" )

local DataService = require "Network.DataService"

local LoadingMask  = require "Views.LoadingMask"

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

local searchData = {}


local function isErrorCheckOk(responseData)
    if( type(responseData) == "table" )then
        if( responseData.ErrorCode )then
            if( responseData.ErrorCode == 0 )then
                return true
            else 
                return false 
            end
        else 
            return true
        end
    else 
        return false
    end
end

local function onSearchComplete ()
    resultTable:deleteAllRows()
    for i=1, #searchData do
        resultTable:insertRow{
            rowHeight = 60,
            isCategory = false,
            rowColor = { default = {1, 0, 0, 0}, over = { 0, 0, 0, 0} },
            params = {
                name = searchData[i].CustomerName,
                id = searchData[i].CustomerNumber,
                customerData = searchData[i]
            }
        }
    end
end

local function onRowTouch ( event )
    if( "release" == event.phase )then
        if( DataService.phase == Phase.EditPhase )then
            DataService.customer = event.row.params.customerData
            storyboard.gotoScene("Scenes.SearchMeterScene", "slideRight", 800)
        elseif( DataService.phase == Phase.RegistryPhase)then 
            DataService.customer = event.row.params.customerData
            scene:hideMask()
            storyboard.gotoScene("Scenes.SubscriptionScene", "slideRight", 800)
        end
        
    end
--event.phase="tap", "press", "release", "swipeLeft", "swipeRight"
--event.target=row
--event.target.index=index
end 

local function onSceneTouch( event )
    if( "began" == event.phase )then
        if( event.target.isKeyboard )then
        else
            --setFocus(0)
            native.setKeyboardFocus(nil)
        end
            
    end
end

local function onRowRender( event )
    local row = event.row
    local id = row.index
    local params = event.row.params
    
    row.bg = display.newRect( 0, display.contentHeight-2, display.contentWidth, 2 )
    row.bg:setFillColor( 0, 1, 0 )
    row:insert( row.bg )
    
    row.editButton = display.newRoundedRect(0, 5, 140, 40, 5)--CButton.new( "Düzenle", params.id, onEditButtonTouched, 15, 10  )
    row.editButton:setFillColor(113/255, 27/255, 69/255)
    row.editButtonText = display.newText("DÜZENLE",40 ,13 ,native.systemFont, 16)
    
    row:insert( row.editButton )
    row:insert(row.editButtonText)

    row.nameText = CLabel.new( params.name, 320, 15, 15 )
    row.nameText:setTextColor( 165/255, 161/255, 155/255 )
    row:insert( row.nameText )
    
    row.id = CLabel.new( params.id, 170, 15, 15 )
    row:insert( row.id )
    
    row.data = params.customerData
    return true   
end

local function scrollListener ( event )

end

local function onCancelButtonTouch ()
    storyboard.removeAll()
    storyboard.gotoScene("Scenes.LoginScene", "slideRight", 800)
end
function scene:logout()
    storyboard.removeAll()
    DataService:resetCachedData()
    storyboard.gotoScene("Scenes.LoginScene", "slideRight", 800)
end

function scene:onInputBegan( event )

end
        
function scene:onInputEdit( event )

end

function scene:onInputEnd( event )
    
end

local function searchForText( stringArray, searchText )
    local returnTable = {}
    for i=0, #stringArray do
        local pos = string.find(stringArray[i], searchText)
        
        if( pos )then
            returnTable[i] = stringArray[i] 
        end
    end
    
end

function scene:onInputEdit(event)
    --[[]
    local searchText = event.text
    for i=0,  #testData do
        local position = string.find( testData[i], searchText )
        if( position ~= nil )then
            
            return
        end
    end
    --]]
end

function scene:onButtonTouchEnded( event )
    
    if( event.target.id == "cancelButton" )then
        storyboard.removeAll()
    storyboard.gotoScene("Scenes.MenuScene", "slideRight", 800)
    elseif( event.target.id == "searchButton" )then
        local customerId = searchField:getText()
        scene:showMask()
    DataService:isCustomer(customerId, 
        function(responseData)
            scene:hideMask()
            if(isErrorCheckOk(responseData) )then
                searchData = responseData
                onSearchComplete()
                --[[]
                if( doneSearch ) then
                    doneSearch = false
                else 
                    doneSearch = true
                    resultTable:reloadData()
                end

                if( doneSearch ) then
                    onSearchComplete()
                end
                --]]
            end
        end, 
        function(errorData)
            scene:hideMask()
            print "Error finding user"
        end)
    end
end
-- Called when the scene's view does not exist:
function scene:createScene( event )
        local group = self.view
        
        doneSearch = false
        --logo = display.newImage( "Assets/Logo.png", 50, 55, true )
        controlBar = ControlBar.new( self )
        headerImage = display.newImageRect( "Assets/MenuHeader.png", 1280, 100 )
        headerImage.x = 0
        headerImage.y = 50
        
        cancelButton = CButton.new( "VAZGEÇ", "cancelButton", scene, 1100, 80, 5 )
        
        --BOLD
        headerText = CLabel.new( "Sayaç Ekle", 50, 200, 20 )

        searchFieldHeader = CLabel.new( "Müşteri Kodu İle Ara", 50, 240, 15 )
        --MAY NEED TO RESIZE
        searchField = CTextField.new(45, 260, 360, 40)
        searchField:setDelegate(self, "searchField")
        --display.newRoundedRect(45, 260, 360, 40, 5)
        --searchField:setFillColor( 165/255, 161/255, 155/255 )
        --CTextField.new( 45, 260 )
        searchButton = CButton.new( "ARA", "searchButton", scene, 415, 260 )
        
        
        
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
        group:insert( resultTable )

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

local superEnterScene = scene.enterScene
-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
        superEnterScene(self, event)
        local group = self.view
        scene.view:addEventListener("touch", onSceneTouch)
        -----------------------------------------------------------------------------

        --      INSERT code here (e.g. start timers, load audio, start listeners, etc.)

        -----------------------------------------------------------------------------

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
    native.setKeyboardFocus(nil)
        local group = self.view
        scene.view:removeEventListener("touch", onSceneTouch)
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
