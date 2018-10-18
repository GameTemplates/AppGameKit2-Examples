
// Project: create-object 
// Created: 2017-11-05

// show all errors
SetErrorMode(2)

// set window properties
SetWindowTitle( "rotate-toward-position" )
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

//load kenney image
kenneyImg = LoadImage("p1_jump.png")

//create kenney
kenneySpr = CreateSprite(kenneyImg)
SetSpritePosition(kenneySpr, GetDeviceWidth() / 2, GetDeviceHeight() / 2)
speed = 2

//create a coin
coinSpr = CreateSprite(coinImg)
SetSpritePosition(coinSpr, GetSpriteX(kenneySpr) + 100, GetSpriteY(kenneySpr))

do
	Print("Click anywhere to change the position of the coin, kenney will follow")

	//calculate angle between two points
    x = GetSpriteX(coinSpr)
    y = GetSpriteY(coinSpr)
    angle = ATanFull(x - GetSpriteXByOffset(kenneySpr), y - GetSpriteYByOffset(kenneySpr))
    
    if(angle = 0) then angle = 1 //only a safety check, the below formula does not work if the angle is 0
    
    // make kenney rotate toward the position of the coin at speed 2 pixels per frame
    if(GetSpriteAngle(kenneySpr) <= angle)
		SetSpriteAngle(kenneySpr, GetSpriteAngle(kenneySpr) + speed)
	endif
	if(GetSpriteAngle(kenneySpr) >= angle )
		SetSpriteAngle(kenneySpr, GetSpriteAngle(kenneySpr) - speed)
	endif
    
    //change position of coin if the mouse is clicked
    if(GetPointerPressed())
		SetSpritePosition(coinSpr, GetPointerX(), GetPointerY())
	endif
	
	Sync()
loop
