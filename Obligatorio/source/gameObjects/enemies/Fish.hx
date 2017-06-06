package gameObjects.enemies;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import gameObjects.Player;
import interfaces.Enemy;

class Fish extends FlxSprite implements Enemy
{
	static inline var X_SPEED:Float = 20;
	static inline var Y_SPEED:Float = 5;

	var timerChangeDirection:Float = 0;

	public function new()
	{
		super();

		loadGraphic(AssetPaths.fish__png, true, 16, 16);

		animation.add("swim", [0, 1], 2, true);
	}

	override public function update(elapsed:Float):Void
	{
		timerChangeDirection -= elapsed;

		if (timerChangeDirection <= 0)
		{
			timerChangeDirection = 1.5;
			
			if (FlxG.random.bool())
			{
				velocity.y *= -1;
			}
		}		

		super.update(elapsed);
	}
	
	/* INTERFACE interfaces.Enemy */
	
	public function spawn(aX:Float, aY:Float, spawnMode:SpawnMode)
	{
		reset(aX, aY);

		animation.play("swim");
		velocity.x = -X_SPEED;
		velocity.y = Y_SPEED;
	}
	
	public function touchThePlayer(aPlayer:Player):Void 
	{
		aPlayer.death();
	}
	
	
}