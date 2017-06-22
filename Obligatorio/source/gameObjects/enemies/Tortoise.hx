package gameObjects.enemies;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import helpers.FiniteStateMachine;
import GlobalGameData;
import helpers.Helper;
import interfaces.Enemy;
import interfaces.InteractWithBlocks;

class Tortoise extends FlxSprite implements Enemy implements InteractWithBlocks
{
	static inline var GRAVITY:Int = 800;
	static inline var SPEED:Float = 90;
	static inline var SLIDING_SPEED:Float = 370;
	static inline var TIME_TO_START_REVIVE:Float = 2;
	static inline var TIME_TO_REVIVE:Float = 3;

	var brain:FSM;
	var timer:Float;

	var frameWithPlayerImmunity:Int = 0;
	var frameWithBlockImmunity:Int = 0;
	var tileId:Int;	
	var x_fix:Int;

	public function new()
	{
		super();

		loadGraphic(AssetPaths.tortoise__png, true, 32, 46);

		animation.add("fly", [2, 3], 6, true);
		animation.add("walk", [0, 1], 6, true);
		animation.add("shell", [5]);
		animation.add("slide", [5]);
		animation.add("revive", [4, 5], 3, true);

		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);

		acceleration.y = GRAVITY;
		brain = new FSM();
	}

	public function flyState(elapsed:Float):Void
	{
		if (isTouching(FlxObject.FLOOR))
		{
			velocity.y = -400;
		}

		if (isTouching(FlxObject.WALL))
		{
			changeDirection();
		}
	}

	override public function update(elapsed:Float):Void
	{
		if (frameWithPlayerImmunity > 0) frameWithPlayerImmunity--;
		
		if (frameWithBlockImmunity > 0) frameWithBlockImmunity--;

		if (y >= GGD.Y_SCREEN_OUT) 
		{
			trace("Se callo una Tortuga");
			kill();
		}
		
		brain.update(elapsed);
		super.update(elapsed);
	}

	public function hit()
	{
		if ( animation.curAnim.name == 'fly')
		{
			velocity.y = 0;
			animation.play("walk");
			brain.activeState = walkState;
		}
		else if (animation.curAnim.name == 'walk' || animation.curAnim.name == "slide")
		{
			velocity.x = 0;
			timer = TIME_TO_START_REVIVE;
			animation.play("shell");
			brain.activeState = shellState;
		}
	}

	private function startSlide(slideToTheRight:Bool)
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
			changeDirection();
		}
	}
	
	inline function changeDirection()
	{
		var speed:Float;
			
		if (animation.curAnim.name == "slide"){
			speed = SLIDING_SPEED;
		} else{
			speed = SPEED;
		}
		
		if (facing == FlxObject.LEFT)
		{
			facing = FlxObject.RIGHT;
			velocity.x = speed;
		}
		else
		{
			facing = FlxObject.LEFT;
			velocity.x = -speed;
		}		
	}

	public function walkState(elapsed:Float):Void
	{
		if (isTouching(FlxObject.WALL))
		{
			changeDirection();
		}
		else if (isTouching(FlxObject.FLOOR))
		{
			x_fix = (facing == FlxObject.RIGHT) ? 33 : -1;
			tileId = Helper.getTileFromXY(x + x_fix, y + 47);
			
			if (tileId == 0)
			{
				changeDirection();
			}
		}
	}

	public function shellState(elapsed:Float):Void
	{
		timer -= elapsed;

		if (timer <= 0)
		{
			timer = TIME_TO_REVIVE;
			animation.play("revive");
			brain.activeState = reviveState;
		}
	}

	public function reviveState(elapsed:Float):Void
	{
		timer -= elapsed;

		if (timer <= 0)
		{
			animation.play("walk");
			velocity.x = SPEED * ((facing == FlxObject.LEFT) ? -1 : 1);
			brain.activeState = walkState;
		}
	}
	
	function deathByBlock()
	{
		alive = false;
		acceleration.set(0, GRAVITY);
		velocity.y = -200;
		scale.y = -1;
		allowCollisions = FlxObject.NONE;
		
		brain.activeState = null;
	}		

	/* INTERFACE interfaces.Enemy */

	public function spawn(aX:Float, aY:Float, spawnMode:SpawnMode):Void
	{
		reset(aX, aY);

		facing = FlxObject.LEFT;
		velocity.x = -SPEED;
		scale.y = 1;
		allowCollisions = FlxObject.ANY;		
		
		if (spawnMode == SpawnMode.FLY)
		{
			animation.play("fly");
			brain.activeState = flyState;
		}else if (spawnMode == SpawnMode.WALK_LEFT)
		{
			velocity.y = 0;
			animation.play("walk");
			brain.activeState = walkState;
		}
	}

	public function touchThePlayer(aPlayer:Player):Void
	{
		if (frameWithPlayerImmunity == 0)
		{
			frameWithPlayerImmunity = 10;

			var curAnim:String = animation.curAnim.name;

			if (curAnim == "walk" || curAnim == "slide" || curAnim == 'fly')
			{
				if (aPlayer.velocity.y > 0)
				{
					hit();					
					aPlayer.bounce();
				}
				else
				{
					aPlayer.death();
				}
			}
			else if (curAnim == "shell" || curAnim == "revive")
			{
				var slideToTheRight:Bool = (aPlayer.x <= x);

				if (aPlayer.velocity.y > 0)
				{
					aPlayer.bounce();
				}

				startSlide(slideToTheRight);
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