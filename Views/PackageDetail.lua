local display = require "display"

local PackageDetail = {}

function PackageDetail.new()
    
    local packageDetail = display.newGroup()
    
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

