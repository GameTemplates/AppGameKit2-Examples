
// Project: create-object 
// Created: 2017-11-05

// show all errors
SetErrorMode(2)

// set window properties
SetWindowTitle( "shoot-bullets" )
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
global bulletSpr as integer
global bullet_speed as integer
global initialTime as float


//load kenney image
kenneyImg = LoadImage("manBlue_machine.png")

//load bullet image
bulletImg = LoadImage("laserBlue07.png")

//create kenney
kenneySpr = CreateSprite(kenneyImg)
SetSpritePosition(kenneySpr, GetDeviceWidth() / 2, GetDeviceHeight() / 2)
SetSpriteDepth(kenneySpr, 0)
speed = 2

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
	Print("Press left mouse button or space key to shoot bullets")

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
	
	Sync()
loop


//function to create a bullet
function createBullet()
	bulletSpr = CreateSprite(bulletImg)
	SetSpriteX(bulletSpr, GetSpriteXByOffset(kenneySpr))
	SetSpriteY(bulletSpr, GetSpriteYByOffset(kenneySpr))
	SetSpriteAngle(bulletSpr, GetSpriteAngle(kenneySpr))
	SetSpriteDepth(bulletSpr, 10)
	SetSpriteScale(bulletSpr, 0.8,0.8)
	SetSpriteGroup(kenneySpr, bulletSpr)
	SetSpritePhysicsOn(bulletSpr,2)
		
	forceX = cos(GetSpriteAngle(bulletSpr) - 90) * bullet_speed
	forceY = sin(GetSpriteAngle(bulletSpr) - 90) * bullet_speed
		
	SetSpritePhysicsImpulse(bulletSpr, GetSpriteXByOffset(bulletSpr), GetSpriteYByOffset(bulletSpr), forceX, forceY)
endfunction
