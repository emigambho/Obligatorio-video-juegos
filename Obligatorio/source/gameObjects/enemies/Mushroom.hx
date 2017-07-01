package gameObjects.enemies;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.text.FlxText;
import haxe.Timer;
import helpers.FiniteStateMachine.FSM;
import helpers.Helper;
import interfaces.Enemy;
import interfaces.InteractWithBlocks;
import interfaces.InteractWithLava;
import GlobalGameData;

class Mushroom extends FlxSprite implements Enemy implements InteractWithBlocks implements InteractWithLava
{
	static inline var GRAVITY:Int = 800;
	static inline var SPEED:Float = 90;

	var facingDirection:Int;
	var timeoutDeathAnimation:Float;
	var brain:FSM;
	
	var dontfall : Bool;

	var frameWithBlockImmunity:Int = 0;
	var tileId:Int;	
	var x_fix:Int;
	
	public function new()
	{
		super();

		loadGraphic(AssetPaths.mushroom__png, true, 32, 32);

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
		else if (isTouching(FlxObject.FLOOR) && dontfall)
		{
			x_fix = (facingDirection == 1) ? 33 : -1;
			tileId = Helper.getTileFromXY(x + x_fix, y + 33);
			
			if (tileId == 0)
			{
				changeDirection();
			}
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
	}

	public function deathByBlock()
	{
		alive = false;
		acceleration.set(0, GRAVITY*1.4);
		velocity.y = -200;
		scale.y = -1;
		allowCollisions = FlxObject.NONE;

		timeoutDeathAnimation = 1.5;
		brain.activeState = deathState;
	}

	/* INTERFACE interfaces.Enemy */

	public function spawn(aX:Float, aY:Float, spawnMode:SpawnMode)
	{
		reset(aX, aY);

		if (spawnMode == SpawnMode.WALK_RIGHT)
		{
			facingDirection = 1;
		}else
		{
			facingDirection = -1;
		}
		
		frameWithBlockImmunity = 0;
		allowCollisions = FlxObject.ANY;
		scale.y = 1;		
		animation.play("walk");
		acceleration.y = GRAVITY;
		velocity.x = SPEED * facingDirection;
		brain.activeState = walkState;
		dontfall = true;
	}

	public function touchThePlayer(aPlayer:Player):Void
	{
		if (alive)
		{
			if (aPlayer.velocity.y > 0)
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
	
	public function set_dontfall(value:Bool):Bool 
	{
		return dontfall = value;
	}
}