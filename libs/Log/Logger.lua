-- Logger module

local Logger = {}

-- Constant Values
local DEBUG = "DEBUG" 
local WARN  = "WARN"
local ERROR = "ERROR"
local FATAL = "FATAL"

-- Variables
local logLevelTable = {
	DEBUG = 1,
	WARN  = 2,
	ERROR = 3,
	FATAL = 4,
}

local logLevel = DEBUG

local function isAvailableLevel( level)
	
	if (logLevelTable[level] == nil) then
		print( "LOG SYSTEM WARNING: [" .. level .. "] is not an available log level" )
		return false
	end

	return true
end

function Logger:setLevel( level )
	if (isAvailableLevel(level)) then
		logLevel = level
	end
end

function Logger:debug( object, method, message )
	if (logLevelTable[DEBUG] >= logLevelTable[logLevel]) then
		print( "[DEBUG] -- Object=( " .. "" .. " )   " .. "   Method=( " .. method .. " )   " .. "Message= " .. message )
	end
end

function Logger:warning( object, method, message )
	if (logLevelTable[WARN] >= logLevelTable[logLevel]) then
		print( "[WARN] -- Object=(" .. "" .. ")" .. "Method=(" .. method .. ")" .. "Message= " .. message )
	end
end

function Logger:error( object, method, message )
	if (logLevelTable[ERROR] >= logLevelTable[logLevel]) then
		print( "[ERROR] -- Object=(" .. "" .. ")" .. "Method=(" .. method .. ")" .. "Message= " .. message )
	end
end

function Logger:fatal( object, method, message )
	if (logLevelTable[FATAL] >= logLevelTable[logLevel]) then
		print( "[FATAL] -- Object=(" .. "" .. ")" .. "Method=(" .. method .. ")" .. "Message= " .. message )
	end
end

return Logger