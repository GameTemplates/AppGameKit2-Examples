
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
SetSyncRate( 60, 0 ) // 30fps instead of 60 to save battery
SetScissor( 0,0,0,0 ) // use the maximum available screen space, no black borders
UseNewDefaultFonts( 1 ) // since version 2.0.22 we can use nicer default fonts

//load kenney 
kenneyImg = LoadImage("p1_jump.png")

//create kenney
kenneySpr = CreateSprite(kenneyImg)
SetSpritePosition(kenneySpr, GetDeviceWidth() / 2, GetDeviceHeight() / 2)
speed = 2

//prepare key codes
KEY_LEFT as integer = 37
KEY_UP as integer = 38
KEY_RIGHT as integer = 39
KEY_DOWN as integer = 40

 

do
	Print("Click anywhere or use the Arrow keys to change the position of kenney")

	//if the mouse is clicked set position of kenney to be at the position of the pointer
	if(GetPointerPressed())
		SetSpritePosition(kenneySpr, GetPointerX(), GetPointerY())
	endif
	
	//if left arrow key is down, decrease the position of kenney on the X axis at speed 2 pixels per frame
	if(GetRawKeyState(KEY_LEFT) = 1)
		SetSpritePosition(kenneySpr, GetSpriteX(kenneySpr) - speed, GetSpriteY(kenneySpr))
	endif
	
	//if right arrow key is down, increase the position of kenney on the X axis at speed 2 pixels per frame
	if(GetRawKeyState(KEY_RIGHT) = 1)
		SetSpritePosition(kenneySpr, GetSpriteX(kenneySpr) + speed, GetSpriteY(kenneySpr))
	endif
	
	//if up arrow key is down, decrease the position of kenney on the Y axis at speed 2 pixels per frame
	if(GetRawKeyState(KEY_UP) = 1)
		SetSpritePosition(kenneySpr, GetSpriteX(kenneySpr), GetSpriteY(kenneySpr) - speed)
	endif
	
	//if down arrow key is down, increase the position of kenney on the X axis at speed 2 pixels per frame
	if(GetRawKeyState(KEY_DOWN) = 1)
		SetSpritePosition(kenneySpr, GetSpriteX(kenneySpr), GetSpriteY(kenneySpr) + speed)
	endif
	
	Sync()
loop
