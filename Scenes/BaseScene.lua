local storyboard = require "storyboard"

local BaseScene = {}

function BaseScene.new()

	local baseScene = storyboard.newScene()

	function baseScene:alert()
		-- Make alert message here
	end

	function baseScene:showMask()
		-- Create a mask which includes the spinner
	end

	function baseScene:hideMask()
		-- Remove a mask which includes the spinner
	end

	return baseScene

end

return BaseScene