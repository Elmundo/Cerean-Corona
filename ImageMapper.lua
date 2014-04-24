
-- ImageMapper Module
local ImageMapper = {}

--Properties
local imageGroup1 = nil
local imageGroup2 = nil
local imageGroup3 = nil
local imageGroup4 = nil
local imageGroup5 = nil

-- Private inline function
local function init()
    
    -- Akdeniz, AKDENIZ, Akedas, ArasEdas, Aydem, Bedas, DicleEdas, 
    -- Gediz, Medas, Osmangazi, Toroslar, Upesas, Vangolu, CalikYedas
    imageGroup1 = {
        customerName            = {16,318,477,79},
        meterParameter          = {16,460,232,21},
        meterSerialNumber       = {16,420,233,20},
        companyCode             = {18,211,229,25},
        membershipNumber        = {17,239,230,25},
        membershipGroup         = {17,291,478,28},
        brand                   = {17,440,229,19},
        meterType               = {17,440,229,19},
        billAmount              = {18,1174,477,19},
        tariffCode              = {16,264,233,28},
        meterSerialNumberAgain  = {248,399,128,40},
    }
    
    -- Enerjisa
    imageGroup2 = {
        customerName            = {16,303,479,114},
        meterParameter          = {16,579,479,21},
        meterSerialNumber       = {16,539,477,21},
        companyCode             = {16,416,480,38},
        membershipNumber        = {16,416,480,38},
        membershipGroup         = {16,479,478,36},
        brand                   = {16,559,478,22},
        meterType               = {16,559,478,22},
        billAmount              = {16,1293,477,21},
        tariffCode              = {0,0,0,0},
        meterSerialNumberAgain  = {248,399,128,40},
    }
    
    -- Cedas, Aesas, Kcetas
    imageGroup3 = {
        customerName            = {16,292,478,80},
        meterParameter          = {16,433,479,21},
        meterSerialNumber       = {16,391,478,20},
        companyCode             = {16,237,232,28},
        membershipNumber        = {16,183,232,28},
        membershipGroup         = {248,184,247,26},
        brand                   = {16,413,478,20},
        meterType               = {16,413,478,20},
        billAmount              = {247,1126,248,21},
        tariffCode              = {16,265,231,26},
        meterSerialNumberAgain  = {248,371,128,40},
    }
    
    -- AksaCoruhEdas, AksaFedas, Kcetas
    imageGroup4 = {
        customerName            = {16,347,478,80},
        meterParameter          = {141,265,78,54},
        meterSerialNumber       = {16,467,478,20},
        companyCode             = {376,183,118,54},
        membershipNumber        = {14,153,161,23},
        membershipGroup         = {16,237,264,25},
        brand                   = {16,446,477,20},
        meterType               = {16,446,477,20},
        billAmount              = {247,1120,246,40},
        tariffCode              = {278,238,216,27},
        meterSerialNumberAgain  = {248,427,128,40},
    }
    
    -- Sepas
    imageGroup5 = {
        customerName            = {16,318,477,79},
        meterParameter          = {16,460,480,21},
        meterSerialNumber       = {16,420,480,21},
        companyCode             = {18,211,229,25},
        membershipNumber        = {249,211,245,26},
        membershipGroup         = {16,292,478,28},
        brand                   = {17,440,479,19},
        meterType               = {17,440,479,19},
        billAmount              = {6,1174,477,19},
        tariffCode              = {247,264,247,27},
        meterSerialNumberAgain  = {248,399,128,40},
    }
    
end

local function getRectFromGroup(group, fieldName)
    
    return group[fieldName]

end

function ImageMapper:findFieldRect(imageName, fieldName)
    
    --// Akdeniz gelmiyor, onun yerine AKDENIZ datası geliyo Cities Response'unda 
    local rectValue = nil
    if (imageName == "Akdeniz"   or  imageName == "AKDENIZ"  or imageName == "Akedas" or
        imageName == "ArasEdas"  or  imageName == "Aydem"    or imageName == "Bedas"  or
        imageName == "DicleEdas" or  imageName == "Gediz"    or imageName == "Medas"  or
        imageName == "Osmangazi" or  imageName == "Toroslar" or imageName == "Tredas" or
        imageName == "Upesas"    or  imageName == "VanGolu"  or imageName == "CalikYedas" ) then
        
        rectValue = getRectFromGroup(imageGroup1, fieldName)
    
    elseif (imageName == "Enerjisa") then
        
        rectValue = getRectFromGroup(imageGroup2, fieldName)
        
    elseif (imageName == "Cedas" or imageName == "Aesas" or imageName == "Kcetas") then
        
        rectValue = getRectFromGroup(imageGroup3, fieldName)
        
    elseif (imageName == "AksaCoruhEdas" or imageName == "AksaFedas") then
        
        rectValue = getRectFromGroup(imageGroup4, fieldName)
        
    elseif (imageName == "Sepas") then    
        
        rectValue = getRectFromGroup(imageGroup5, fieldName)
    end
    
    return rectValue
    
end
init()
return ImageMapper
