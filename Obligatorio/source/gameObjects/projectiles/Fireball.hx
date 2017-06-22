package gameObjects.projectiles;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import interfaces.Projectile;

class Fireball extends FlxSprite implements Projectile
{
	static inline var SPEED:Float = 80;
	static inline var TIME_LIFE:Float = 6;

	var timer:Float;

	public function new()
	{
		super();

		loadGraphic(AssetPaths.fireball__png, true, 8, 8);

		animation.add("spin", [0, 1, 2, 3], 8, true);
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

		animation.play("spin");

		timer = TIME_LIFE;

		velocity.set(SPEED * directionX, SPEED * directionY);
	}

	public function touchThePlayer(aPlayer:Player):Void
	{
		aPlayer.death();
	}

}