
// Project: create-object 
// Created: 2017-11-05

// show all errors
SetErrorMode(2)

// set window properties
SetWindowTitle( "move object toward position" )
SetWindowSize( 1024, 768, 0 )
SetWindowAllowResize( 1 ) // allow the user to resize the window

// set display properties
SetVirtualResolution( 1024, 768 ) // doesn't have to match the window
SetOrientationAllowed( 1, 1, 1, 1 ) // allow both portrait and landscape on mobile devices
SetSyncRate( 30, 0 ) // 30fps instead of 60 to save battery
SetScissor( 0,0,0,0 ) // use the maximum available screen space, no black borders
UseNewDefaultFonts( 1 ) // since version 2.0.22 we can use nicer default fonts

//Initialize physics
SetPhysicsGravity(0,0) 

//load coin image
coinImg = LoadImage("coinGold.png")

//load kenney image
kenneyImg = LoadImage("p1_jump.png")

//create kenney
kenneySpr = CreateSprite(kenneyImg)
SetSpritePosition(kenneySpr, GetDeviceWidth() / 2, GetDeviceHeight() / 2)
speed = 3

//prepare key codes
global KEY_LEFT as integer = 37
global KEY_UP as integer = 38
global KEY_RIGHT as integer = 39
global KEY_DOWN as integer = 40


do
	Print("Click anywhere or use the arrow keys to move kenney around")
    
    //if the mouse is pressed
    if(GetPointerPressed())
		
		//if there is no coin, create one
		if coin_count = 0
			coinSpr = CreateSprite(coinImg)
			SetSpritePosition(coinSpr, GetPointerX(), GetPointerY())
			coin_count = 1
		else
			//if there is a coin, just change it position to the pointer
			SetSpritePosition(coinSpr, GetPointerX(), GetPointerY())
		endif
		
	endif
	
	//if there is a coin and no key is pressed
	if (coin_count = 1 and anyKeyIsPressed() = 0)
		
		//move kenney toward the coin
		moveTowardPosition(kenneySpr, speed, coinSpr)
		
		//if kenney is in collision with the coin, delete the coin
		if(GetSpriteCollision(kenneySpr, coinSpr))
			DeleteSprite(coinSpr)
			coin_count = 0
		endif
			 
	endif
	
	//move kenney with the arrow keys
	moveSpriteWithArrowKeys(kenneySpr,speed)
	
	
	Sync()
loop


//function to move a sprite toward an other sprite
function moveTowardPosition(kenneySpr, speed, coinSpr)
	
	
	//if the two sprite is not in collision
	if (NOT GetSpriteCollision(kenneySpr, coinSpr))
	
		//move kenney toward the destination
		x1 = GetSpriteX(coinSpr)
		y1 = GetSpriteY(coinSpr)
	
		x2 = GetSpriteX(kenneySpr)
		y2 = GetSpriteY(kenneySpr)
	
		angle = ATan2(y1 - y2, x1 - x2)
	
		forceX = cos(angle) * speed
		forceY = sin(angle) * speed
	
		SetSpriteX(kenneySpr, GetSpriteX(kenneySpr) + forceX)
		SetSpriteY(kenneySpr, GetSpriteY(kenneySpr) + forceY)

	endif
	

endfunction

//function to move kenney using the arrow keys
function moveSpriteWithArrowKeys(kenneySpr,speed)

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
	
endfunction


//function to check if any key is pressed
function anyKeyIsPressed()
 if(GetRawKeyState(KEY_DOWN) = 0 and GetRawKeyState(KEY_LEFT) = 0 and GetRawKeyState(KEY_RIGHT) = 0 and GetRawKeyState(KEY_UP) = 0)
	 pressed = 0
 else
	 pressed = 1
 endif
 
endfunction pressed
