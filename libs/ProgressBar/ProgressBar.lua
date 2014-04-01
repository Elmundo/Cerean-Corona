local ProgressBar = {}

local display = require "display"

function ProgressBar.new(position, imageName, maskImageName)

	local progressBar = {}
            
        do
            local image = display.newImageRect( imageName, 634, 94)
            image.anchorX = 0
            image.anchorY = 0

            local imageMask = display.newImageRect( maskImageName, 637, 94)
            local imageBG = display.newRect(0, 0, image.width, image.height)
            imageBG:setFillColor( 165/255, 161/255, 155/255 )

            local imageContainer = display.newContainer(634, 94)
            imageContainer.anchorChildren = false -- Neden false yapınca düzeldiğini anlamadım..
            imageContainer:insert(image)

            local group = display.newGroup()
            group:insert(imageBG)
            group:insert(imageContainer)
            group:insert(imageMask)

            group.x = position.x
            group.y = position.y

            imageContainer.width = 0
            
            progressBar.image          = image
            progressBar.imageMask      = imageMask
            progressBar.imageBG        = imageBG
            progressBar.imageContainer = imageContainer
            progressBar.group          = group
        end
        
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