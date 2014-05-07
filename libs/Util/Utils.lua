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

function Utils:componentSeperatedByString( exp, pattern )
	local list = {}
	local i = 1
        local w = nil
        local realExp = string.sub(exp, 2, -1)
        while(realExp) do
            index = string.find(realExp, ",")
            if index == nil then
                realExp = nil
            else
                w = string.sub(realExp, 1, index-1)
                realExp = string.sub(realExp, index+1, -1)
                list[i] = w
                i = i + 1
            end
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

function addLetterToStringForPhone (_text, _addedLetter )
    local text = _text
    local addedLetter = _addedLetter
    
    if( addedLetter:match("%W") == false )then
        return addedLetter
    end
    local returnText
    
    local textLength = string.len(text)
    
    if( 0 == textLength )then
        --Need to check this
        returnText = "(" .. addedLetter
    elseif( 1 == textLength )then
        returnText = text .. addedLetter
    elseif( 2 == textLength )then
        returnText = text .. addedLetter 
    elseif( 3 == textLength )then
        returnText = text .. addedLetter .. ") "
    elseif( 4 == textLength )then
        returnText = text .. ") " .. addedLetter
    elseif( 5 == textLength )then
        returnText = " " .. text .. addedLetter
    elseif( 6 == textLength )then
        returnText = text .. addedLetter
    elseif( 7 == textLength )then
        returnText = text .. addedLetter
    elseif( 8 == textLength )then
        returnText = text .. addedLetter "-"
    elseif( 9 == textLength )then
        returnText = text .. addedLetter
    elseif( 10 == textLength )then
        returnText = text .. addedLetter
    elseif( 11 == textLength )then
        returnText = text .. addedLetter
    elseif( 12 == textLength )then
        returnText = text .. addedLetter
    elseif( 13 == textLength )then
        returnText = text .. addedLetter
    else 
        return text
    end
    
    return returnText
end

function isValidEmail(_text)
    local text = _text
    
    if (text:match("[A-Za-z0-9%.%%%+%-]+@[A-Za-z0-9%.%%%+%-]+%.%w%w%w?%w?")) then
        return true
    end
    
    return false
end

function isValidID(_text)
    local text = _text
    
    local textLength = string.len(text)
    
end

return Utils