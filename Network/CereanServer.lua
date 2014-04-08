-- CereanServer Class
local CereanServer = require("Network.Server").new()

--No need for Response or Request descriptors; thanks to Lua tables could make data mapping with its core design
function CereanServer:setProperties( _params )
	-- Some stuff
end

return CereanServer
