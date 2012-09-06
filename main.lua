local widget = require "widget"
local storyboard = require "storyboard"

widget.setTheme( "theme_ios" )

display.setStatusBar( display.DefaultStatusBar )

local sbHeight = display.statusBarHeight
local tbHeight = 44
local top = sbHeight + tbHeight


-- Load an array of images to be used in the tableview
maps = {}
for i = 1, 7 do
	maps[i] = display.newImage("map"..i..".png")
	maps[i].alpha = 0 -- hide for now
end
	
-- create a gradient for the top-half of the toolbar
local toolbarGradient = graphics.newGradient( {80,80,80, 255 }, {50, 50, 50, 255}, "down" )

-- create toolbar to go at the top of the screen
local titleBar = widget.newTabBar{
	top = sbHeight,
	gradient = toolbarGradient,
	bottomFill = { 0, 0, 0, 255 },
	height = 44
}

-- create embossed text to go on toolbar
local titleText = display.newEmbossedText( "testing...", 0, 0, native.systemFontBold, 12 )
titleText:setReferencePoint( display.CenterReferencePoint )
titleText:setTextColor( 255 )
titleText.x = 160
titleText.y = titleBar.y

local list = widget.newTableView{
	top = top,
	height = 366,
	maskFile = "assets/mask-320x366.png"
}

-- handles individual row rendering
local function onRowRender( event )
	local row = event.row
	local rowGroup = event.view
	
	print("Calling onRowRender for "..row.index) -- debug
			
	if (maps[row.index])
		then
		local mygrp = display.newGroup ( )
		
		if (maps[row.index].contentWidth == nil) then  
	 		print("Houston, we have a problem!")   --- corruption?????????????
		else
			maps[row.index]:scale(0.6, 0.5) 
			maps[row.index].x = 0.5 * rowGroup.contentWidth 
			maps[row.index].y =  0.5 * rowGroup.contentHeight
			maps[row.index].alpha = 1
			mygrp:insert(maps[row.index])
		end
	 
		rowGroup:insert( mygrp )
	
	end
			
end
	
	
-- insert 100 rows into list (tableView widget)
for i=1,100 do
	list:insertRow{
		onRender = onRowRender
	}
end

local stage = display.getCurrentStage()

stage:insert( list )


