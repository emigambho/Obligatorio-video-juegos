package gameObjects.enemies;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import helpers.FiniteStateMachine;
import GlobalGameData;
import interfaces.Enemy;

class Tortoise extends FlxSprite implements Enemy
{
	static inline var GRAVITY:Int = 400;
	static inline var SPEED:Float = 45;
	static inline var SLIDING_SPEED:Float = 185;

	var brain:FSM;
	var timeToStartRevive:Float;
	var timeToRevive:Float;

	public function new(X:Float, Y:Float)
	{
		super(X, Y);

		loadGraphic(AssetPaths.tortoise__png, true, 16, 23);

		animation.add("fly", [2, 3], 6, true);
		animation.add("walk", [0, 1], 6, true);
		animation.add("shell", [5]);
		animation.add("slide", [5]);
		animation.add("revive", [4, 5], 3, true);

		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);

		acceleration.y = GRAVITY;

		brain = new FSM(walkState);
	}

	override public function update(elapsed:Float):Void
	{
		brain.update(elapsed);
		super.update(elapsed);
	}

	public function hit()
	{
		velocity.x = 0;
		timeToStartRevive = 2;
		animation.play("shell");

		GGD.addPoints(x +2, y -8, 500);

		brain.activeState = shellState;
	}

	public function slide(slideToTheRight:Bool)
	{
		if (slideToTheRight) 
		{
			facing = FlxObject.RIGHT;
			velocity.x = SLIDING_SPEED;
		}
		else 
		{
			facing = FlxObject.LEFT;
			velocity.x = -SLIDING_SPEED;
		}		

		animation.play("slide");
		brain.activeState = slideState;
	}
	
	public function slideState(elapsed:Float):Void
	{
		if ( (facing == FlxObject.LEFT && isTouching(FlxObject.LEFT)) || (facing == FlxObject.RIGHT && isTouching(FlxObject.RIGHT)) )
		{
			if (facing == FlxObject.LEFT)
			{
				facing = FlxObject.RIGHT;
				velocity.x = SLIDING_SPEED;
			}
			else
			{
				facing = FlxObject.LEFT;
				velocity.x = -SLIDING_SPEED;
			}
		}
	}	

	public function walkState(elapsed:Float):Void
	{
		if (isTouching(FlxObject.LEFT) || isTouching(FlxObject.RIGHT))
		{
			if (facing == FlxObject.LEFT)
			{
				facing = FlxObject.RIGHT;
				velocity.x = SPEED;
			}
			else
			{
				facing = FlxObject.LEFT;
				velocity.x = -SPEED;
			}
		}
	}

	public function shellState(elapsed:Float):Void
	{
		timeToStartRevive -= elapsed;

		if (timeToStartRevive <= 0)
		{
			timeToRevive = 3;
			animation.play("revive");
			brain.activeState = reviveState;
		}
	}

	public function reviveState(elapsed:Float):Void
	{
		timeToRevive -= elapsed;

		if (timeToRevive <= 0)
		{
			animation.play("walk");
			velocity.x = SPEED * ((facing == FlxObject.LEFT) ? -1 : 1);
			brain.activeState = walkState;
		}
	}
	
	
	/* INTERFACE interfaces.Enemy */
	
	
	public function spawn(aX:Float, aY:Float):Void 
	{
		reset(aX, aY);
		
		facing = FlxObject.LEFT;
		animation.play("walk");
		velocity.x = -SPEED;	

		brain.activeState = walkState;
	}
	
	public function touchThePlayer(aPlayer:Player):Void 
	{
		
	}
	
	/*function playerVsTortoise(aPlayer:gameObjects.Player, aTortoise:Tortoise):Void
	{
		var curAnim:String = aTortoise.animation.curAnim.name;

		if (curAnim == "walk" || curAnim == "slide")
		{
			if ((aPlayer.y) <= aTortoise.y) // El Player está arriba de la tortuga
			{
				aTortoise.hit();
				aPlayer.jump();
			}
			else
			{
				aPlayer.death();
			}
		}
		else if (curAnim == "shell" || curAnim == "revive")
		{
			var slideToTheRight:Bool = (aPlayer.x <= aTortoise.x);

			if ((aPlayer.y) <= aTortoise.y)
			{
				aPlayer.jump();
			}

			aTortoise.slide(slideToTheRight);
		}

	}*/	

}