local display = require "display"

module(...)

---[[
function new(  )
	
	local CTextField = display.newText( "Hello World!", 
		20, 
		20, 
		"Arial", 
		30)

	function CTextField:removeFromParent( )
		self:removeSelf( )
	end

	return CTextField

end

--]]