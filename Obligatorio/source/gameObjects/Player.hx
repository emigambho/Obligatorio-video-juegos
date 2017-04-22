package gameObjects;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import haxe.Timer;

class Player extends FlxSprite
{
	static inline var RUN_SPEED:Float = 400;
	static inline var GRAVITY:Int = 750; //600;
	static inline var JUMP_SPEED:Float = 320; // 290;

	public function new()
	{
		super(0, 0);

		loadGraphic(AssetPaths.player__png, true, 16, 16);

		animation.add("idle", [0]);
		animation.add("walk", [1, 2, 3], 6, true);
		animation.add("jump", [4]);
		animation.add("death", [5]);

		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);

		acceleration.y = GRAVITY;
		maxVelocity.set(150, 420);

		drag.x = maxVelocity.x * 2;
		
		setSize(8, 16);
		offset.set(4, 0);		
	}

	override public function update(elapsed:Float):Void
	{
		if (alive)
		{
			acceleration.x = 0;

			if (FlxG.keys.anyPressed([LEFT, A]))
			{
				acceleration.x = -RUN_SPEED;
				facing = FlxObject.LEFT;
			}

			if (FlxG.keys.anyPressed([RIGHT, D]))
			{
				acceleration.x = RUN_SPEED;
				facing = FlxObject.RIGHT;
			}

			if (FlxG.keys.anyJustPressed([SPACE, UP, W]) && isTouching(FlxObject.FLOOR))
			{
				velocity.y = -JUMP_SPEED;
			}
			
			//if (FlxG.keys.anyJustReleased([SPACE, UP, W]))
			//{
				//velocity.y = Math.max(velocity.y, -JUMP_SPEED/3);
			//}			

			if (!isTouching(FlxObject.FLOOR))
			{
				animation.play("jump");
			}
			else
			{
				if (velocity.x == 0)
				{
					animation.play("idle");
				}
				else
				{
					animation.play("walk");
				}
			}
		}

		super.update(elapsed);
	}

	public function jump():Void
	{
		velocity.y = -JUMP_SPEED / 2.2;
	}
	
	public function death():Void
	{
		animation.play("death");
		alive = false;
	
		// El personaje al morir esta medio segundo quieto en pantalla y despues salta.		
		acceleration.x = 0;
		acceleration.y = 0;
		velocity.x = 0;
		velocity.y = 0;
		Timer.delay(deadAnimation, 600);
	}
	
	function deadAnimation():Void
	{
		acceleration.y = GRAVITY;
		velocity.y = -JUMP_SPEED;
		
		//FlxG.resetState();
	}
}