package gameObjects.projectiles;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import interfaces.Projectile;

class Hammer extends FlxSprite implements Projectile
{
	static inline var GRAVITY:Int = 1200;
	static inline var Y_SPEED:Float = 600;
	static inline var X_SPEED:Float = 200;
	static inline var TIME_LIFE:Float = 2;

	var timer:Float;

	public function new()
	{
		super();

		loadGraphic(AssetPaths.hammer__png, true, 32, 32);

		animation.add("spin", [1, 2, 3, 0], 12, true);

		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);

		setSize(16, 16);
		offset.set(8, 8);
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

		velocity.y = -Y_SPEED;
		velocity.x = X_SPEED * directionX;
		acceleration.y = GRAVITY;

		animation.play("spin");
		timer = TIME_LIFE;
	}

	public function touchThePlayer(aPlayer:Player):Void
	{
		aPlayer.death();
	}

}