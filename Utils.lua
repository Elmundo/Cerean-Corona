-- Util Helper
local Utils = {}

function Utils.printTable( table )
	for k,v in pairs(table) do
		if (type(v) == "table") then
			print(k .. " = {")
			printTableRecursive(v)
			print( "}" )
		else
			print(k,v)	
		end
		
	end
end

return Utils