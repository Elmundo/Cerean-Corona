local display = require "display"

local PackageDetail = {}

function PackageDetail.new()
    
    local packageDetail = display.newGroup()
    
    local indexLabel  = display.newText(packageDetail, "Default", 0 , 0, 100, 50, native.systemFont, 16)
    local dateLabel   = display.newText(packageDetail, "Default", 0 , 0, 100, 50 ,native.systemFont, 16)
    local detailLabel = display.newText(packageDetail, "Default", 0 , 0, 100, 50, native.systemFont, 16)
    
    local unselectedBG = display.newImage("Assets/VisualSelectTariff.png", 0, 0)
    local selectedBG   = display.newImage("Assets/VisualSelectedTariff.png", 0, 0)
    
    packageDetail:insert(selectedBG)
    packageDetail:insert(unselectedBG)
    
    function packageDetail:hideMask()
        unselectedBG.isVisible = false
    end
    
    return packageDetail
end

return PackageDetail

