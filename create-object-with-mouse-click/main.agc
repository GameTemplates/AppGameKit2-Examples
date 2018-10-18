
// Project: create-object 
// Created: 2017-11-05

// show all errors
SetErrorMode(2)

// set window properties
SetWindowTitle( "create-object" )
SetWindowSize( 1024, 768, 0 )
SetWindowAllowResize( 1 ) // allow the user to resize the window

// set display properties
SetVirtualResolution( 1024, 768 ) // doesn't have to match the window
SetOrientationAllowed( 1, 1, 1, 1 ) // allow both portrait and landscape on mobile devices
SetSyncRate( 30, 0 ) // 30fps instead of 60 to save battery
SetScissor( 0,0,0,0 ) // use the maximum available screen space, no black borders
UseNewDefaultFonts( 1 ) // since version 2.0.22 we can use nicer default fonts

//load coin image
coinImg = LoadImage("coinGold.png")

do
	Print("Click anywhere to create a coin")

	//if the mouse is clicked create a coin in position of the pointer
	if(GetPointerPressed())
		coinID = CreateSprite(coinImg)
		SetSpritePosition(coinID,GetPointerX(), GetPointerY()) 
	endif
	
	Sync()
loop
