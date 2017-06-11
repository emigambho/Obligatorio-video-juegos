package gameObjects.enemies;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.text.FlxText;
import haxe.Timer;
import helpers.FiniteStateMachine.FSM;
import interfaces.Enemy;
import interfaces.InteractWithBlocks;
import interfaces.InteractWithLava;
import GlobalGameData;

class Mushroom extends FlxSprite implements Enemy implements InteractWithBlocks implements InteractWithLava
{
	static inline var GRAVITY:Int = 400;
	static inline var SPEED:Float = 45;

	var facingDirection:Int;
	var timeoutDeathAnimation:Float;
	var brain:FSM;

	var frameWithBlockImmunity:Int = 0;
	
	public function new()
	{
		super();

		loadGraphic(AssetPaths.mushroom__png, true, 16, 16);

		animation.add("idle", [0]);
		animation.add("walk", [0, 1], 6, true);
		animation.add("death", [2]);
		animation.add("burn", [3]);

		maxVelocity.y = GRAVITY;

		brain = new FSM();
	}

	public function walkState(elapsed:Float):Void
	{
		if (isTouching(FlxObject.WALL))
		{
			changeDirection();
		}
	}

	inline function changeDirection()
	{
		facingDirection *= -1;
		velocity.x = SPEED * facingDirection;
	}

	public function deathState(elapsed:Float):Void
	{
		timeoutDeathAnimation -= elapsed;

		if (timeoutDeathAnimation <= 0)
		{
			kill();
		}
	}

	// Es para el nivel del jefe. En este nivel los enemigos caen del techo sin velocidad en X
	// y empiezan a caminar al tocar el piso.
	public function stopState(elapsed:Float):Void
	{
		if (velocity.x == 0 && alive && isTouching(FlxObject.FLOOR))
		{
			animation.play("walk");
			velocity.x = SPEED * facingDirection;
			brain.activeState = walkState;
		}
	}

	public function stop()
	{
		velocity.x = 0;
		animation.play("idle");
		brain.activeState = stopState;
	}

	override public function update(elapsed:Float):Void
	{
		if (y >= GGD.Y_SCREEN_OUT) 
		{
			trace("Se callo un hongo");
			kill();
		}
		
		if (frameWithBlockImmunity > 0) frameWithBlockImmunity--;
		
		brain.update(elapsed);
		super.update(elapsed);
	}

	private function death()
	{
		alive = false;
		acceleration.set();
		velocity.set();

		timeoutDeathAnimation = .8;
		brain.activeState = deathState;

		GGD.addPoints(x +2, y -8, 100);
	}

	public function deathByBlock()
	{
		alive = false;
		acceleration.set(0, GRAVITY*1.4);
		velocity.y = -100;
		scale.y = -1;
		allowCollisions = FlxObject.NONE;

		timeoutDeathAnimation = 1.5;
		brain.activeState = deathState;

		GGD.addPoints(x +2, y -8, 100);
	}

	/* INTERFACE interfaces.Enemy */

	public function spawn(aX:Float, aY:Float, spawnMode:SpawnMode)
	{
		reset(aX, aY);

		frameWithBlockImmunity = 0;
		allowCollisions = FlxObject.ANY;
		scale.y = 1;
		facingDirection = -1;
		animation.play("walk");
		acceleration.y = GRAVITY;
		velocity.x = -SPEED;
		brain.activeState = walkState;
	}

	public function touchThePlayer(aPlayer:Player):Void
	{
		if (alive)
		{
			if ((aPlayer.y +10) <= y)
			{
				aPlayer.bounce();
				animation.play("death");
				death();
			}
			else
			{
				aPlayer.death();
			}
		}
	}

	/* INTERFACE interfaces.InteractWithBlocks */

	public function hitByBlock(blockPosition:Int)
	{
		if (alive && frameWithBlockImmunity == 0)
		{
			frameWithBlockImmunity = 4;
			
			if (blockPosition == FlxObject.DOWN)
			{
				deathByBlock();
			}

			if (blockPosition == FlxObject.LEFT || blockPosition == FlxObject.RIGHT)
			{
				changeDirection();
			}
		}
	}

	/* INTERFACE interfaces.InteractWithLava */

	public function burnedByLava():Void
	{
		if (alive)
		{
			animation.play("burn");
			death();
		}
	}
}