local widget = require( "widget" )
local display = require( "display" )
local CLabel = require( "Views.Labels.CLabel" )
--local CButton = require( "Views.Buttons.CButton" )

module( ... )

local displayGroup 
local background

local icon
local userTitleLabel

local exitIcon
local exitText
local exitButton

function new( )

	displayGroup = display.newGroup( )
        
        background = display.newRect(0, 0, 1280, 50 )
        background:setFillColor(0.5, 0.5, 0.5, 1)
        
        icon = display.newImage("Assets/IconIdentityGray.png", 20, 15 )
        userTitleLabel = CLabel.new( "Yeni Kullanıcı", 45, 15, 15 )
        userTitleLabel:setTextColor( 0, 0, 0 )
        
        exitIcon = display.newImage( "Assets/IconLogoutGray.png", 1220, 15 )
        exitText = CLabel.new( "Çıkış Yap", 1150, 15, 15 )
        exitText:setTextColor( 0, 0, 0 )
        exitButton  = widget.newButton{
                x = 1140,
                y = 15,
   		width = 110,
                height = 20,
                label = ""
	}
        --[[
        exitButton = widget.newButton{
             width = 200,
             height = 40,
             defaultFile = "Assets/IconLogoutGrey.png",
             overFile = "Assets/IconLogoutGrey.png",
             label = "button",
             onEvent = onExitButtonTouched
	}
        
        
        exitButton.x = 900
        exitButton.y = 15
        --]]
        
        --[[
        exitButton = widget.newButton { left = 100,
                                        top = 200,
                                        id= "exitButton",
                                        label = "Çıkış Yap",
                                        defaultFile = "Assets/IconLogoutGrey.png",
                                        overFile = "Assets/IConLogoutGrey.png"
                                        }
                                        
        --]]
        displayGroup:insert( background )
        displayGroup:insert( exitButton )
        displayGroup:insert( exitIcon )
        displayGroup:insert( exitText )
        
        displayGroup:insert( icon )
        displayGroup:insert( userTitleLabel )
        --displayGroup:insert( exitButton )
        displayGroup.x = 0
        displayGroup.y = 0
        
	return displayGroup
        

end
