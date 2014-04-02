local ProgressBar = {}

local display = require "display"

function ProgressBar.new(position, imageName, maskImageName)

	local progressBar = display.newGroup()
            
        -- PROGRESS IMAGE
        local image = display.newImageRect( imageName, 634, 94)
        image.anchorX = 0
        image.anchorY = 0

        -- IMAGE MASK
        local imageMask = display.newImageRect( maskImageName, 637, 94)
        local imageBG = display.newRect(0, 0, image.width, image.height)
        imageBG:setFillColor( 165/255, 161/255, 155/255 )
        
        -- IMAGE CONTAINER TO CHANGE WIDTH VALUE
        local imageContainer = display.newContainer(634, 94)
        imageContainer.anchorChildren = false -- Neden false yapınca düzeldiğini anlamadım..
        imageContainer:insert(image)
        imageContainer.width = 0
        
        progressBar:insert(imageBG)
        progressBar:insert(imageContainer)
        progressBar:insert(imageMask)
        
         -- PROGRESS ICON IMAGES
        local icon1 = display.newImage(progressBar, "Assets/IconProgress01.png",  system.ResourceDirectory,   10, 24, YES)
        local icon2 = display.newImage(progressBar, "Assets/IconProgress02.png",  system.ResourceDirectory,  206, 24, YES)
        local icon3 = display.newImage(progressBar, "Assets/IconProgress03A.png", system.ResourceDirectory, 401, 24, YES)
        local icon4 = display.newImage(progressBar, "Assets/IconProgress04.png",  system.ResourceDirectory,  598, 24, YES)
        
        progressBar.x = position.x
        progressBar.y = position.y

        progressBar.image          = image
        progressBar.imageMask      = imageMask
        progressBar.imageBG        = imageBG
        progressBar.imageContainer = imageContainer
 
        function progressBar:setProgress( _width )
            transition.to(self.imageContainer, {width=_width, time=500, transition=easing.linear})
        end
        
        function progressBar:setProgressWithPercentage( value )
            local widthValue = (value * self.imageContainer.width) / 100 
            transition.to(self.imageContainer, {width=widthValue, time=500, transition=easing.linear})
        end
        
	return progressBar
end

return ProgressBar