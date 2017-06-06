package gameObjects.enemies;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import helpers.FiniteStateMachine;
import GlobalGameData;
import interfaces.Enemy;
import interfaces.InteractWithBlocks;

class Tortoise extends FlxSprite implements Enemy implements InteractWithBlocks
{
	static inline var GRAVITY:Int = 400;
	static inline var SPEED:Float = 45;
	static inline var SLIDING_SPEED:Float = 185;

	var brain:FSM;
	var timeToStartRevive:Float;
	var timeToRevive:Float;

	var frameWithPlayerImmunity:Int = 0;
	var frameWithBlockImmunity:Int = 0;

	public function new()
	{
		super();

		loadGraphic(AssetPaths.tortoise__png, true, 16, 23);

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
			velocity.y = -230;
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
			timeToStartRevive = 2;
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

	public function spawn(aX:Float, aY:Float, spawnMode:SpawnMode):Void
	{
		reset(aX, aY);

		facing = FlxObject.LEFT;
		velocity.x = -SPEED;
		
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

			// ¿Los "pies" de Mario están en la parte superior de la tortuga?
			var belowThePlayer = ((aPlayer.y + aPlayer.height) <= (y + height /2));
			var curAnim:String = animation.curAnim.name;

			if (curAnim == "walk" || curAnim == "slide" || curAnim == 'fly')
			{
				if (belowThePlayer)
				{
					hit();					
					aPlayer.bounce();
					GGD.addPoints(x +2, y -8, 500);
				}
				else
				{
					aPlayer.death();
				}
			}
			else if (curAnim == "shell" || curAnim == "revive")
			{
				var slideToTheRight:Bool = (aPlayer.x <= x);

				if (belowThePlayer)
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
				//deathByBlock();
				kill();
			}

			if (blockPosition == FlxObject.LEFT || blockPosition == FlxObject.RIGHT)
			{
				changeDirection();
			}
		}		
	}

}