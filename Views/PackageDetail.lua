local display = require "display"

local PackageDetail = {}

function PackageDetail.new()
    
    local packageDetail = display.newGroup()
    
    local unselectedBG = display.newImage("Assets/VisualSelectTariff.png", 0, 0)
    local selectedBG   = display.newImage("Assets/VisualSelectedTariff.png", 0, 0)
    packageDetail:insert(selectedBG)
    
    -- Headers
    local indexLabelHeader  = display.newText(packageDetail, "Seçilen Paket", packageDetail.width/2 , 21, 0, 0, native.systemFont, 13)
    indexLabelHeader.anchorX = 0.5
    local dateLabelHeader   = display.newText(packageDetail, "BAŞLANGIÇ & BİTİŞ TARİHLERİ", packageDetail.width/2 , 84, 0, 0, native.systemFont, 13)
    dateLabelHeader.anchorX = 0.5
    local detailLabelHeader = display.newText(packageDetail, "DETAYLAR", packageDetail.width/2 , 148, 0, 0, native.systemFont, 13)
    detailLabelHeader.anchorX = 0.5
    
    -- Graphics
    local lineTop = display.newRect(packageDetail, 20, 74, 250, 2)
    lineTop:setFillColor(1,1,1)
    local lineBottom = display.newText(packageDetail, "---------------------------------", 20, 119, 0, 0, native.systemFont, 13)
    
    local indexLabel  = display.newText(packageDetail, "Default", packageDetail.width/2 , 36, 0, 0, native.systemFont, 15)
    indexLabel.anchorX = 0.5
    local dateLabel   = display.newText(packageDetail, "Default", packageDetail.width/2 , 101, 0, 0 ,native.systemFont, 15)
    dateLabel.anchorX = 0.5
    local detailLabel = display.newText(packageDetail, "Default", 10, 190, 280, 0, native.systemFont, 15)
    detailLabel.anchorX = 0.0
    
    packageDetail:insert(unselectedBG)
    
    function packageDetail:hideMask()
        unselectedBG.isVisible = false
    end
    
    function packageDetail:setPackageDetail(options)
        indexLabel.text  = options.Name
        --TODO: Baris Open this line when working real data, not dummy ones
        --dateLabel.text   = options.CombinedDate
        dateLabel.text   = options.StartDate .. " - " .. options.EndDate
        detailLabel.text = options.Detail
    end
    
    return packageDetail
end

return PackageDetail

