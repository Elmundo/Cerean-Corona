local storyboard  = require "storyboard"
local LoadingMask = require "Views.LoadingMask"
local native      = require "native"
local BaseScene = {}

function BaseScene.new()
    
	local baseScene = storyboard.newScene()
        
        -- Properties
        local group = nil
        
        local loadingMask
        
	function baseScene:alert(title, message, labelList, listener)
            native.showAlert(title, message, labelList, function(event)
                -- Something to do
            end)
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
