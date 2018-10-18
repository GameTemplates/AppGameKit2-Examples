
// Project: create-object 
// Created: 2017-11-05

// show all errors
SetErrorMode(2)

// set window properties
SetWindowTitle( "delete-object-on-collision" )
SetWindowSize( 1024, 768, 0 )
SetWindowAllowResize( 1 ) // allow the user to resize the window

// set display properties
SetVirtualResolution( 1024, 768 ) // doesn't have to match the window
SetOrientationAllowed( 1, 1, 1, 1 ) // allow both portrait and landscape on mobile devices
SetSyncRate( 30, 0 ) // 30fps instead of 60 to save battery
SetScissor( 0,0,0,0 ) // use the maximum available screen space, no black borders
UseNewDefaultFonts( 1 ) // since version 2.0.22 we can use nicer default fonts

//initialize variables
global kenneyImg as integer
global kenneySpr as integer
global bulletImg as integer
global bulletSpr as integer[0]
global bullet_speed as integer
global barrelImg as integer
global barrelSpr as integer[0]
global initialTime as float
global bulletCount as integer


//load kenney image
kenneyImg = LoadImage("manBlue_machine.png")

//load bullet image
bulletImg = LoadImage("laserBlue07.png")

//load barrel image
barrelImg = LoadImage("barrelBlack_top.png")

//create kenney
kenneySpr = CreateSprite(kenneyImg)
SetSpritePosition(kenneySpr, GetDeviceWidth() / 2, GetDeviceHeight() - 100)
SetSpriteDepth(kenneySpr, 0)
speed = 2

//create a bunch of barrels on the top portion of the screen and store them inside an array
For i = 1 to 50 
	barrelSpr.insert(CreateSprite(barrelImg))
	SetSpritePosition(barrelSpr[i], Random2(100,700), Random2(100, 300))
Next i 

//turn physics gravity and borders off
SetPhysicsGravity(0,0)
SetPhysicsWallBottom(0)
SetPhysicsWallLeft(0)
SetPhysicsWallRight(0)
SetPhysicsWallTop(0)

//initialize bullet speed
bullet_speed = 2000

//Initilialize keys
KEY_SPACE as integer = 32

do
	Print("Press left mouse button or space key to shoot bullets and destroy the barrels")

	//calculate angle between two points
    x = GetPointerX()
    y = GetPointerY()
    angle = ATanFull(x - GetSpriteXByOffset(kenneySpr), y - GetSpriteYByOffset(kenneySpr))
    
    //rotate kenney toward angle
    SetSpriteAngle(kenneySpr, angle)
    
    //if the left mouse button or the space key is down shoot a bullet every 0.3 seconds
    if(GetPointerState() = 1 or GetRawKeyState(KEY_SPACE) = 1)
		
		if(Timer() >= initialTime + 0.3)
			createBullet()
			initialTime = Timer()
		endif
		  
	endif
	
	//check collision between all existing bullets and barrels
	for ibullet = 1 to bulletSpr.length
		for ibarrel = 1 to barrelSpr.length
			if(GetSpriteExists(bulletSpr[ibullet]) and GetSpriteExists(barrelSpr[ibarrel]))
				if(GetSpriteCollision(bulletSpr[ibullet], barrelSpr[ibarrel]))
					DeleteSprite(barrelSpr[ibarrel])
					DeleteSprite(bulletSpr[ibullet])
				endif
			endif
		next ibarrel
	next ibullet
	
	//delete bullets if outside the screen to free up memory
	for i = 1 to bulletSpr.length
		if(GetSpriteExists(bulletSpr[i]))
			if(GetSpriteX(bulletSpr[i]) > GetDeviceWidth() or GetSpriteX(bulletSpr[i]) < 0 or GetSpriteY(bulletSpr[i]) > GetDeviceHeight() or GetSpriteY(bulletSpr[i]) < 0)
				DeleteSprite(bulletSpr[i])
			endif
		endif
	next i
	
	
	
	Sync()
loop


//function to create bullet and store them inside an array
function createBullet()
	bulletCount = bulletCount + 1
	
	bulletSpr.insert(CreateSprite(bulletImg))
	SetSpriteX(bulletSpr[bulletCount], GetSpriteXByOffset(kenneySpr))
	SetSpriteY(bulletSpr[bulletCount], GetSpriteYByOffset(kenneySpr))
	SetSpriteAngle(bulletSpr[bulletCount],GetSpriteAngle(kenneySpr))
	SetSpriteDepth(bulletSpr[bulletCount], 10)
	SetSpriteScale(bulletSpr[bulletCount], 0.8,0.8)
	SetSpriteGroup(kenneySpr, bulletSpr[bulletCount])
	SetSpritePhysicsOn(bulletSpr[bulletCount],2)
		
	forceX = cos(GetSpriteAngle(bulletSpr[bulletCount]) - 90) * bullet_speed
	forceY = sin(GetSpriteAngle(bulletSpr[bulletCount]) - 90) * bullet_speed
		
	SetSpritePhysicsImpulse(bulletSpr[bulletCount], GetSpriteXByOffset(bulletSpr[bulletCount]), GetSpriteYByOffset(bulletSpr[bulletCount]), forceX, forceY)
endfunction
