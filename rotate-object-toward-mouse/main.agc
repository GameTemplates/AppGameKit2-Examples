
// Project: create-object 
// Created: 2017-11-05

// show all errors
SetErrorMode(2)

// set window properties
SetWindowTitle( "rotate-toward-mouse" )
SetWindowSize( 1024, 768, 0 )
SetWindowAllowResize( 1 ) // allow the user to resize the window

// set display properties
SetVirtualResolution( 1024, 768 ) // doesn't have to match the window
SetOrientationAllowed( 1, 1, 1, 1 ) // allow both portrait and landscape on mobile devices
SetSyncRate( 30, 0 ) // 30fps instead of 60 to save battery
SetScissor( 0,0,0,0 ) // use the maximum available screen space, no black borders
UseNewDefaultFonts( 1 ) // since version 2.0.22 we can use nicer default fonts


//load kenney image
kenneyImg = LoadImage("manBlue_machine.png")

//create kenney
kenneySpr = CreateSprite(kenneyImg)
SetSpritePosition(kenneySpr, GetDeviceWidth() / 2, GetDeviceHeight() / 2)
speed = 2

do

	//calculate angle between two points
    x = GetPointerX()
    y = GetPointerY()
    angle = ATanFull(x - GetSpriteXByOffset(kenneySpr), y - GetSpriteYByOffset(kenneySpr))
    
    SetSpriteAngle(kenneySpr, angle) 
	
	Sync()
loop
