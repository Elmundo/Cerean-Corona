local CT = {}

local display = require( "display" )
local native = require( "native" )

function CT.new( xPos, yPos, width, height )
    local wrapper = display.newGroup()
    wrapper.anchorX = 0.5
    local textField5 = native.newTextField(0, 0, width, height)
    textField5.font = native.newFont( native.systemFont, 8 )
    --textField5.align = "center"
    wrapper:insert(textField5)
    wrapper.x = xPos
    wrapper.y = yPos
    
    return wrapper
end
return CT
