package gameObjects.enemies;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.text.FlxText;
import haxe.Timer;
import util.GlobalGameData;

class Mushroom extends FlxSprite
{
	static inline var GRAVITY:Int = 400;
	static inline var SPEED:Float = 55;

	var direction:Int = -1;

	public function new()
	{
		super(0, 0);

		loadGraphic(AssetPaths.mushroom__png, true, 16, 16);

		animation.add("idle", [0]);
		animation.add("walk", [0, 1], 6,true);
		animation.add("death", [2]);
		
		acceleration.y = GRAVITY;
		maxVelocity.y = GRAVITY;
	}
	
	public function spawn(aX:Float, aY:Float, walkToTheRight:Bool)
	{
		reset(aX, aY);
		
		direction = (walkToTheRight) ? 1 : -1;

		animation.play("walk");
		velocity.x = SPEED * direction;
	}

	public function stop()
	{
		velocity.x = 0;
		animation.play("idle");		
	}
	
	override public function update(elapsed:Float):Void
	{
		if (y >= 610) // Se cayó de la pantalla, lo reciclo.
		{
			trace ("Muere un Hongo!");
			kill();
			return;
		}
		
		if (velocity.x == 0 && alive && isTouching(FlxObject.FLOOR))
		{
			// Esto es para el nivel del jefe. En este nivel los enemigos caen del techo sin velocidad en X
			// y empiezan a caminar al tocar el piso. 
			
			animation.play("walk");
			velocity.x = SPEED * direction;			
		}
		
		if (isTouching(FlxObject.LEFT) || isTouching(FlxObject.RIGHT))
		{
			direction *= -1;
			velocity.x = SPEED * direction;
		}

		super.update(elapsed);		
	}

	public function death()
	{
		animation.play("death");
		alive = false;
		velocity.x = 0;

		GGD.addPoints(x +2, y -8, 100);

		Timer.delay(finishKill, 800);
	}

	function finishKill():Void
	{
		kill();
	}
}