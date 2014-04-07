local storyboard = require "storyboard"
local LoadingMask = require "Views.LoadingMask"

local BaseScene = {}

function BaseScene.new()
    
	local baseScene = storyboard.newScene()
        
        -- Properties
        local group = nil
        
        local loadingMask
        
	function baseScene:alert()
		-- Make alert message here
	end

	function baseScene:showMask()
		loadingMask:start()
	end

	function baseScene:hideMask()
		loadingMask:stop()
	end

        function baseScene:enterScene( event )
            gruop = self.view
            loadingMask = LoadingMask.new {
            view = gruop, 
        }
        end
        
        return baseScene
end



return BaseScene