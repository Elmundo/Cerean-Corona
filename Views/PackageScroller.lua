local widget      = require "widget"
local display     = require "display"
local PackageView = require "Views.PackageView"
-- Module PacakgeScroller
local PackageScroller = {}

-- CONSTANTS
local cPACKAGE_Y_DIFF = 150
local cPACKAGE_LEFT_X_POS = 10
local cPACKAGE_RIGHT_X_POS = 330

-- options
--[[
    Number   x, y
    Number   width, height
    Number   scrollWidth, scrollHeight
    Boolean  horizontalScrollDisabled
    Boolean  verticalScrollDisabled
    Listener listener
    RGB+A    backgroundColor = {0.8, 0.8, 0.8}
--]]
function PackageScroller.new(packageDataList, options)
    
    local packageScroller = widget.newScrollView(options)
    
    packageScroller.yPos = 10
    packageScroller.packageDataList = packageDataList
    packageScroller.delegate = options.delegate
    
    function packageScroller:setMyScroller(list)
        
        for i=1,#list do
            
            productData = list[i]
            
            if (i-1)%2 == 0 then -- Left
                packageView = PackageView.new({
                    x = cPACKAGE_LEFT_X_POS,
                    y = self.yPos,
                    width = 290,
                    height = 120,
                    product = nil,
                    delegate = self,
                    
                })
            else -- Right
                packageView = PackageView.new({
                    x = cPACKAGE_RIGHT_X_POS,
                    y = self.yPos,
                    width = 290,
                    height = 120,
                    product = nil,
                    delegate = self,
                    
                })
                self.yPos = self.yPos + cPACKAGE_Y_DIFF
            end
            
            self:insert(packageView)
        end
               
        self:setScrollHeight(self.yPos)
    end
    
    -- Package Delegate
    function packageScroller:didPackageSelect(package)
        self.delegate:didPackageSelect(package)
    end
    
    return packageScroller
    
end

return PackageScroller
