local display = require "display"

-- Progress Bar Module
local ProgressBar = {}

function ProgressBar.new(position, imageName, maskImageName)
        
        -- PROPERTIES --
        -- Progress Bar image, mask and container
        local image
        local imageMask
        local imageBG
        local imageContainer

        -- Icon Images
        local icon1
        local icon2
        local icon3
        local icon4
        
        -- New Progress Bar
	local progressBar = display.newGroup()
            
        -- PROGRESS IMAGE
        image = display.newImageRect( imageName, 634, 94)
        image.anchorX = 0
        image.anchorY = 0

        -- IMAGE MASK
        imageMask = display.newImageRect( maskImageName, 637, 94)
        imageBG = display.newRect(0, 0, image.width, image.height)
        imageBG:setFillColor( 165/255, 161/255, 155/255 )
        
        -- IMAGE CONTAINER TO CHANGE WIDTH VALUE
        imageContainer = display.newContainer(634, 94)
        imageContainer.anchorChildren = false -- Neden false yapınca düzeldiğini anlamadım..
        imageContainer:insert(image)
        imageContainer.width = 0
        
        progressBar:insert(imageBG)
        progressBar:insert(imageContainer)
        progressBar:insert(imageMask)
        
         -- PROGRESS ICON IMAGES
        icon1 = display.newImage(progressBar, "Assets/IconProgress01.png",  system.ResourceDirectory,   10, 24, true)
        icon2 = display.newImage(progressBar, "Assets/IconProgress02.png",  system.ResourceDirectory,  206, 24, true)
        icon3 = display.newImage(progressBar, "Assets/IconProgress03A.png", system.ResourceDirectory, 401, 24, true)
        icon4 = display.newImage(progressBar, "Assets/IconProgress04.png",  system.ResourceDirectory,  598, 24, true)
        
        progressBar.x = position.x
        progressBar.y = position.y

        progressBar.image          = image
        progressBar.imageMask      = imageMask
        progressBar.imageBG        = imageBG
        progressBar.imageContainer = imageContainer
        
        -- METHODS
        function progressBar:setProgress( _width )
            transition.to(self.imageContainer, {width=_width, time=500, transition=easing.linear})
        end
        
        function progressBar:setProgressWithPercentage( value )
            local widthValue = (value * image.width) / 100 
            transition.to(self.imageContainer, {width=widthValue, time=500, transition=easing.linear})
        end
        
	return progressBar
end

return ProgressBar