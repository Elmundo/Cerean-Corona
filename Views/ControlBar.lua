local widget = require( "widget" )
local CLabel = require( "Views.Labels.CLabel" )
local CButton = require( "Views.Buttons.CButton" )

module( ... )

local displayGroup 
local icon
local userTitleLabel
local exitButton

function new( )

	displayGroup = display.newGroup( )
	icon = display.newImage( "Assets/IconIdentityGray.png", 10, 10 )
	userTitleLabel = CLabel.new( "Yeni Kullanıcı", 100, 10, 15)

	return displayGroup

end