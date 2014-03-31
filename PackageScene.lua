local display = require "display"
local BaseScene = require "BaseScene"

local PackageScene = {}

function PackageScene.new()

	local packageScene = BaseScene.new()

	function packageScene:init( )
		local group = display.newGroup( )
		
		local bgHeaderText = display.newRoundedRect( 30, 220, 960, 40, 5 )
		bgHeaderText:setFillColor( 1,0,0 )
		local headerText     = display.newText( "Size Özel Paketler", 0, 0, native.systemFontBold, 18 )
		headerText:setFillColor( 1, 1, 1 )
		headerText.x, headerText.y = 40,230
		
		local promotionText  = display.newText( "PROMOSYON KODU", 0, 50, native.systemFont, 24 )
		promotionText:setFillColor( 0,0,0 )
		promotionText.x, promotionText.y = 30,290

		local promotionImage = display.newImage("Assets/VisualSelectTariff.png")
		promotionImage.x = 700
		promotionImage.y = 265

		--[[
		group:insert( headerText )
		group:insert( promotionText )
		group:insert( promotionImage )
		]]
	end

	return packageScene
end

return PackageScene