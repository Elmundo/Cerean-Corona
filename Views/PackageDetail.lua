local display = require "display"

local PackageDetail = {}

function PackageDetail.new()
    
    local packageDetail = display.newGroup()
    
    local unselectedBG = display.newImage("Assets/VisualSelectTariff.png", 0, 0)
    local selectedBG   = display.newImage("Assets/VisualSelectedTariff.png", 0, 0)
    packageDetail:insert(selectedBG)
    
    local indexLabel  = display.newText(packageDetail, "Default", 0 , 0, 200, 50, native.systemFont, 16)
    local dateLabel   = display.newText(packageDetail, "Default", 0 , 100, 300, 50 ,native.systemFont, 16)
    local detailLabel = display.newText(packageDetail, "Default", 0 , 200, 300, 100, native.systemFont, 16)
    
    packageDetail:insert(unselectedBG)
    
    function packageDetail:hideMask()
        unselectedBG.isVisible = false
    end
    
    function packageDetail:setPackageDetail(options)
        indexLabel.text  = options.name
        dateLabel.text   = options.startDate .. options.endDate
        detailLabel.text = options.detail
    end
    
    return packageDetail
end

return PackageDetail

