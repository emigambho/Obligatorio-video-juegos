package gameObjects.projectiles;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import interfaces.Projectile;

class Cannonball extends FlxSprite implements Projectile
{
	static inline var X_SPEED:Float = 100;
	static inline var TIME_LIFE:Float = 3;
	
	var timer:Float;
	
	public function new() 
	{
		super();
		
		loadGraphic(AssetPaths.canonball__png, false, 16, 14);
		
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
	}
	
	override public function update(elapsed:Float):Void
	{
		timer -= elapsed;

		if (timer <= 0)
		{
			kill();
		}

		super.update(elapsed);
	}	
	
	
	/* INTERFACE interfaces.Projectile */
	
	public function shoot(aX:Float, aY:Float, directionX: Float, directionY:Float):Void 
	{
		reset(aX, aY);

		if (directionX >= 0)
		{
			directionX = 1;
			facing = FlxObject.RIGHT;
		}
		else
		{
			directionX = -1;
			facing = FlxObject.LEFT;
		}

		velocity.x = X_SPEED * directionX;
		timer = TIME_LIFE;		
	}
	
	public function touchThePlayer(aPlayer:Player):Void 
	{
		aPlayer.death();
	}
	
}