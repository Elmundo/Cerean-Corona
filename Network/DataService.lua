local math = require "math"
local os   = require "os"
local json = require "json"

-- Data Service Module
local CereanServer = require "Network.CereanServer"
local Utils        = require "libs.Util.Utils"

-- GLOBAL Phase Enum
Phase = {

	ApplicationPhase = 0,
	CallPhase = 1,
	RegistryPhase = 2,
}


local baseRequest =   {
		bsqn = "5",
		reqs = {
				    {
					sqn = "1",
					svc = "clientsvc",
					params = nil, -- will be changed with array
					method = nil, -- will be changed as name of the current server method name
	                },	
				},

}

local request = baseRequest.reqs[1]

local DataService = {

	-- Cached Datas
	addressIdContact = "",
	addressIdInvoice = "",
	addressIdVisiting = "",
	appointmentId = "",

	customerEmail = "",
	customerId = "",
	customerName = "",
	customerNumber = "",
	customerPhone = "",
	customerWebFormCity = "",

	meterId = "",
	primaryContactId = "",
	productId = "",
	quoteId = "",

	userBusinessUnitName = "",
	userId = "",
	userName = "",

	verificationCode = "",
	webFormPage = "",
	meterSerialNumber = "",

	-- Parameters Cached Data List
	cities           = {},
	companies        = {},
	suppliers        = {},
	membershipgroups = {},
	meterList        = {},
	products         = {},
	timeIntervals    = {},

	-- Phase Data
	phase = -1,	

	-- For registry phase
	customer = nil,
	selectedCity = nil,
}

-- Methods
function DataService:generateVerificationCode( )
	local val = 0
	local temp = -1
	math.randomseed(os.time())
	for i=1,4 do
		val = val * 10
		temp = math.random(1, 9)
		val = val + temp
	end

	local verificationCode = val .. ""
	return verificationCode
end

function DataService:resetCachedData( )	
	self.addressIdContact = ""
	self.addressIdInvoice = ""
	self.addressIdVisiting = ""
	self.appointmentId = ""
	self.customerEmail = ""
	self.customerId = ""
	self.customerName = ""
	self.customerNumber = ""
	self.customerPhone = ""
	self.customerWebFormCity = ""
	self.meterId = ""
	self.primaryContactId = ""
	self.productId = ""
	self.quoteId = ""
	self.userBusinessUnitName = ""
	self.userId = ""
	self.userName = ""
	self.webFormPage = ""
	self.meterSerialNumber = ""

	self.cities = nil
	self.companies = nil
	self.suppliers = nil
	self.membershipgroups = nil
	self.meterList = nil
	self.products = nil
	self.timeIntervals = nil

	self.sellectedCity = nil
	self.phase = -1
	self.customer = nil

	self.verificationCode = self:generateVerificationCode()
end

function DataService:findCompanyForCity( cityCode )
	local companies = self.companies
	for i,company in ipairs(companies) do
		local cities = Utils:componentSeperatedByString(company.cityList, ",")
		for i,city in ipairs(cities) do
			if (city == cityCode) then
				return company
			end
		end

	end

	return nil
end

function DataService:findCityForCityID( cityCode )
	local cities = self.cities
	for i,city in ipairs(cities) do
		if (city.ID == cityCode) then
			return city
		end
	end

	return nil
end

function DataService:completeRequest( params )
	local jsonFormat = json.encode( params )
	local completedData = "d=" .. jsonFormat
	return completedData
end

------------------------
-- Networking Methods --
------------------------
function DataService:saveContent( params, callback, failure )
	
	request.params = {params}
	request.method = "savecontent"

	CereanServer:request(self:completeRequest(baseRequest), callback, failure)
end

function DataService:login( username, password, callback, failure  )

	request.params = {username, password}
	request.method = "login"
	
	CereanServer:request(self:completeRequest(baseRequest), callback, failure)
end

function DataService:isCustomer( customerId, callback, failure  )
	
	request.params = {customerId, self.userId}
	request.method = "iscustomer"
	
	CereanServer:request(self:completeRequest(baseRequest), callback, failure)
end

function DataService:getParameters( key, parentAsInt, callback, failure )
	
	request.params = {key, json.null, json.null}
	request.method = "getparameters"
	
	CereanServer:request(self:completeRequest(baseRequest), callback, failure)
end

function DataService:getParametersWithGuid(	key, guid, parentAsInt, callback, failure  )
	
	request.params = {key, guid, json.null}
	request.method = "getparameters"
	
	CereanServer:request(self:completeRequest(baseRequest), callback, failure)
end

function DataService:sendMail( mailType, params, callback, failure  )
	
	request.params = {mailType, params}
	request.method = "sendmail"
	
	CereanServer:request(self:completeRequest(baseRequest), callback, failure)
end

function DataService:getProduct( callback, failure  )
	
	request.params = {self.customerId, self.meterId}
	request.method = "getproducts"
	
	CereanServer:request(self:completeRequest(baseRequest), callback, failure)
end

return DataService
