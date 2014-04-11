-- Util Helper
local Utils = {}

function Utils:printTable( table )
	for k,v in pairs(table) do
		if (type(v) == "table") then
			print(k .. " = {")
			self:printTable(v)
			print( "}" )
		else
			if (type(v) == "userdata") then
				print("User data is not available to shown")
			elseif(type(v) == "boolean") then
				print(k .. "=")
				print( v )
			else
				print(k .. "=" .. v)	
			end
		end
		
	end
end

function Utils:componentSeperatedByString( string, pattern )
	local list = {}
	local i = 1
	for w in string.gmatch( string, pattern ) do
		list[i] = w
		i = i + 1
	end	

	return list
end

function cColor(r, g, b, a)
    local color = {r/255, g/255, b/255, (a or 1)}
    return color
end

function cColorM(r, g, b, a)
    return r/255, g/255, b/255, (a or 1)
end

return Utils