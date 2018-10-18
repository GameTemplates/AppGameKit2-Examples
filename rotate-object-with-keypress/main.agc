
// Project: create-object 
// Created: 2017-11-05

// show all errors
SetErrorMode(2)

// set window properties
SetWindowTitle( "rotate with key press" )
SetWindowSize( 1024, 768, 0 )
SetWindowAllowResize( 1 ) // allow the user to resize the window

// set display properties
SetVirtualResolution( 1024, 768 ) // doesn't have to match the window
SetOrientationAllowed( 1, 1, 1, 1 ) // allow both portrait and landscape on mobile devices
SetSyncRate( 60, 0 ) // 30fps instead of 60 to save battery
SetScissor( 0,0,0,0 ) // use the maximum available screen space, no black borders
UseNewDefaultFonts( 1 ) // since version 2.0.22 we can use nicer default fonts

//load kenney 
kenneyImg = LoadImage("p1_jump.png")

//create kenney
kenneySpr = CreateSprite(kenneyImg)
SetSpritePosition(kenneySpr, GetDeviceWidth() / 2, GetDeviceHeight() / 2)
speed = 1

//prepare key codes
KEY_LEFT as integer = 37
KEY_RIGHT as integer = 39


 

do
	Print("Use the Arrow keys to rotate kenney")

	
	//if left arrow key is down, decrease the angle by 1 pixel per frame
	if(GetRawKeyState(KEY_LEFT) = 1)
		SetSpriteAngle(kenneySpr,GetSpriteAngle(kenneySpr) - speed)
	endif
	
	//if right arrow key is down, increase angle of kenney by 1 pixel per frame
	if(GetRawKeyState(KEY_RIGHT) = 1)
		SetSpriteAngle(kenneySpr,GetSpriteAngle(kenneySpr) + speed)
	endif
	
	Sync()
loop
