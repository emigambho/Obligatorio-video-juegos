package gameObjects.level;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import util.GlobalGameData.GGD;

class Life extends FlxSprite implements BlockItem
{
	static inline var GRAVITY:Int = 400;
	static inline var SPEED:Float = 75;
	static inline var UP_SPEED:Int = 13;

	var direction:Int = 1;
	var isPlayingStartAnimation:Bool = false;
	var yTarget:Float = 0;

	public function new()
	{
		super(0, 0);

		loadGraphic(AssetPaths.powerupLife__png, false, 16, 16);
	}

	override public function update(elapsed:Float):Void
	{
		if (isPlayingStartAnimation)
		{
			if (y <= yTarget)
			{
				isPlayingStartAnimation = false;
				acceleration.y = GRAVITY;
				velocity.x = SPEED * direction;
			}
			else
			{
				y -= UP_SPEED * elapsed;
			}
		}
		else if (isTouching(FlxObject.LEFT) || isTouching(FlxObject.RIGHT))
		{
			direction *= -1;
			velocity.x = SPEED * direction;
		}

		super.update(elapsed);
	}

	public function pickUp()
	{
		GGD.addPoints(x +2, y -8, 1000);
		kill();
	}
	
	/* INTERFACE gameObjects.level.BlockItem */
	
	public function blockActivated(aX:Float,aY:Float):Void 
	{
		reset(aX, aY);
		yTarget = aY -16;
		direction = 1;
		acceleration.y = 0;
		velocity.x = 0;		
		isPlayingStartAnimation = true;
	}
	
}