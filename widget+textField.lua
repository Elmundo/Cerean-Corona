local widget = require "widget"

--[[
    ** OPTIONS **
    top             — distance from the top of the screen
    left            — distance from the left of the screen
    x               — location of the widget horizontally (center)
    y               — location of the widget vertically (center)
    width           — width of the field
    height          — height of the field
    font            — Font to use
    fontSize        — size of the font
    backgroundColor — the color behind the text
    strokeColor     — the color of the stroke around the field
    strokeWidth     — the size of the stroke
    cornerRadius    — if you want rounded corners
    text            — the initial text
    inputType       — the type of keyboard to show
    listener        — the input handler
--]]

function widget.newTextField( options )
    
    local opt = {}
    local customOptions = options or {}

    opt.left = customOptions.left or 0
    opt.top = customOptions.top or 0
    opt.x = customOptions.x or 0
    opt.y = customOptions.y or 0
    opt.width = customOptions.width or (display.contentWidth * 0.75)
    opt.height = customOptions.height or 20
    opt.id = customOptions.id
    opt.listener = customOptions.listener or nil
    opt.text = customOptions.text or ""
    opt.inputType = customOptions.inputType or "default"
    opt.font = customOptions.font or native.systemFont
    opt.fontSize = customOptions.fontSize or opt.height * 0.67

    -- Vector options
    opt.strokeWidth = customOptions.strokeWidth or 2
    opt.cornerRadius = customOptions.cornerRadius or opt.height * 0.33 or 10
    opt.strokeColor = customOptions.strokeColor or { 0, 0, 0 }
    opt.backgroundColor = customOptions.backgroundColor or { 1, 1, 1 }
   
    function opt:textFieldHandler( event )
        -- "event.text" only exists during the editing phase to show what's being edited;  
        -- it is NOT the field's ".text" attribute (that is "event.target.text").
        
        if ( event.phase == "began" ) then
            -- user begins editing textField
            print( "Begin editing", event.target.text )
        elseif ( event.phase == "ended" or event.phase == "submitted" ) then
            -- do something with defaulField's text
            print( "Final Text: ", event.target.text )
            native.setKeyboardFocus( nil )
        elseif ( event.phase == "editing" ) then
            print( event.newCharacters )
            print( event.oldText )
            print( event.startPosition )
            print( event.text )
        end
    end
    
    -- Visual Parts
    local textField = display.newGroup()

    local background = display.newRoundedRect( 0, 0, opt.width, opt.height, opt.cornerRadius )
    background:setFillColor( unpack(opt.backgroundColor) )
    background.strokeWidth = opt.strokeWidth
    background.stroke = opt.strokeColor
    textField:insert( background )

    if ( opt.x ) then
       textField.x = opt.x
    elseif ( opt.left ) then
       textField.x = opt.left + opt.width * 0.5
    end
    if ( opt.y ) then
       textField.y = opt.y
    elseif ( opt.top ) then
       textField.y = opt.top + opt.height * 0.5
    end

    -- Native UI element
    local tHeight = opt.height - opt.strokeWidth * 2
    if "Android" == system.getInfo("platformName") then
        --
        -- Older Android devices have extra "chrome" that needs to be compesnated for.
        --
        tHeight = tHeight + 10
    end

    textField.textField = native.newTextField( 0, 0, opt.width - opt.cornerRadius, tHeight )
    textField.textField.x = textField.x
    textField.textField.y = textField.y
    textField.textField.hasBackground = false
    textField.textField.inputType = opt.inputType
    textField.textField.text = opt.text
    print( opt.listener, type(opt.listener) )
    if ( opt.listener and type(opt.listener) == "function" ) then
       textField.textField:addEventListener( "userInput", opt.listener )
    end

    local deviceScale = ( display.pixelWidth / display.contentWidth ) * 0.5

    textField.textField.font = native.newFont( opt.font )
    textField.textField.size = opt.fontSize * deviceScale
    
    function textField:syncFields ( event)
        --[[
        self.textField.x = self.x
        self.textField.y = self.y
        --]]
    end
    Runtime:addEventListener("enterFrame", textField.syncFields)
    
    function textField:finalize( event )
        event.target.textField:removeSelf()
    end
    textField:addEventListener("finalize") 
    
    return textField
end



