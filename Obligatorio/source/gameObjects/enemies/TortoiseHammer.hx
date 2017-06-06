package gameObjects.enemies;

import flash.geom.Point;
import flixel.FlxObject;
import flixel.FlxSprite;
import gameObjects.Player;
import gameObjects.projectiles.ProjectileFactory.ProjectileType;
import helpers.FiniteStateMachine.FSM;
import interfaces.Enemy;
import interfaces.InteractWithBlocks;
import GlobalGameData;

class TortoiseHammer extends FlxSprite implements Enemy implements InteractWithBlocks
{
	static inline var TIME_BETWEEN_CHANGES_DIRECTION = .8;
	static inline var TIME_BETWEEN_THROWING:Float = 1;
	static inline var TIME_THROWING:Float = .15;
	static inline var GRAVITY:Int = 560;
	static inline var WALK_SPEED:Int = 35;
	
	var timerChangeDirection:Float;
	var timer:Float;
	var frameWithBlockImmunity:Int = 0;
	var brain:FSM;	
	
	public function new()
	{
		super();

		loadGraphic(AssetPaths.tortoise_hammer__png, true, 16, 33);

		animation.add("walk", [1, 0], 3, true);
		animation.add("throw", [2], 6, false);

		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		
		brain = new FSM();
		
		setSize(14, 24);
		offset.set(0, 9);		
	}
	
	override public function update(elapsed:Float):Void
	{
		if (frameWithBlockImmunity > 0)
		{
			frameWithBlockImmunity--;
		}		
		
		brain.update(elapsed);
		super.update(elapsed);
	}	
	
	function walkState(elapsed:Float)
	{
		animation.play("walk");	
		move(elapsed);
		
		timer -= elapsed;
		
		if (timer <= 0)
		{
			timer = TIME_THROWING;
			brain.activeState = throwingState;
		}
	}
	
	inline function move(elapsed:Float)
	{
		timerChangeDirection -= elapsed;
		
		if (timerChangeDirection <= 0)
		{
			changeDirection();
		}		
		
		if (GGD.player.x >= x)
		{
			facing = FlxObject.RIGHT;
		}
		else
		{
			facing = FlxObject.LEFT;
		}
	}
	
	inline function changeDirection()
	{
		timerChangeDirection = TIME_BETWEEN_CHANGES_DIRECTION;
		velocity.x *= -1;
	}
	
	function throwingState(elapsed:Float)
	{
		animation.play("throw");
		move(elapsed);
		
		timer -= elapsed;
		
		if (timer <= 0)
		{
			var startX:Float;
			var directionX:Float;
			
			if (facing == FlxObject.RIGHT)
			{
				startX = x;
				directionX = 1;
			} else
			{
				startX = x + width -3;
				directionX = -1;
			}			
			
			GGD.projectileFactory.shoot(startX, y + 2, directionX, 0, ProjectileType.HAMMER);
			
			timer = TIME_BETWEEN_THROWING;
			brain.activeState = walkState;			
		}		
	}
	
	public function deathState(elapsed:Float):Void
	{
		timer -= elapsed;

		if (timer <= 0)
		{
			kill();
		}
	}	
	
	function death()
	{
		GGD.addPoints(x +2, y -8, 100);
		kill();		
	}
	
	function deathByBlock()
	{
		alive = false;
		acceleration.set(0, GRAVITY);
		velocity.x *= 2;
		velocity.y = -100;
		scale.y = -1;
		allowCollisions = FlxObject.NONE;

		timer = 1.5;
		brain.activeState = deathState;

		GGD.addPoints(x +2, y -8, 100);
	}
	
	/* INTERFACE interfaces.Enemy */

	public function spawn(aX:Float, aY:Float, spawnMode:SpawnMode)
	{
		reset(aX, aY);

		timerChangeDirection = TIME_BETWEEN_CHANGES_DIRECTION;
		velocity.x = WALK_SPEED;
		
		timer = TIME_BETWEEN_THROWING;
		brain.activeState = walkState;

		frameWithBlockImmunity = 0;
		//start.setTo(x, y);
		//end.setTo(x+30, y);
		//myPath.set(start, end);
		//pathWalker.reset();
	}	
	
	public function touchThePlayer(aPlayer:Player):Void 
	{
		if (alive)
		{
			if ((aPlayer.y +10) <= y)
			{
				death();
				aPlayer.bounce();
			}
			else
			{
				aPlayer.death();
			}
		}
	}
	
	
	/* INTERFACE interfaces.InteractWithBlocks */
	
	public function hitByBlock(blockPosition:Int):Void 
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
	
}