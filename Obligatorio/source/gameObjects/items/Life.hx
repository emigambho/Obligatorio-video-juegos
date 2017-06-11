package gameObjects.items;
import GlobalGameData;
import helpers.FiniteStateMachine.FSM;
import interfaces.InteractWithBlocks;
import interfaces.Item;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import GlobalGameData.GGD;

class Life extends FlxSprite implements Item implements InteractWithBlocks
{
	static inline var GRAVITY:Int = 400;
	static inline var SPEED:Float = 75;
	static inline var UP_SPEED:Int = 13;

	var facingDirection:Int = 1;
	var yTarget:Float = 0;

	var status:FSM;

	var frameWithBlockImmunity:Int = 0;

	public function new()
	{
		super(0, 0);

		loadGraphic(AssetPaths.powerupLife__png, false, 16, 16);

		status = new FSM();
	}

	override public function update(elapsed:Float):Void
	{
		if (frameWithBlockImmunity > 0)
		{
			frameWithBlockImmunity--;
		}
		
		status.update(elapsed);
		super.update(elapsed);
	}

	public function blockOutState(elapsed:Float):Void
	{
		if (y < yTarget)
		{
			acceleration.y = GRAVITY;
			velocity.x = SPEED * facingDirection;
			status.activeState = walkState;
			allowCollisions = FlxObject.ANY;
			frameWithBlockImmunity = 3;
		}
		else
		{
			y -= UP_SPEED * elapsed;
		}
	}

	public function walkState(elapsed:Float):Void
	{
		if (isTouching(FlxObject.WALL))
		{
			changeDirection();
		}
	}

	inline function changeDirection():Void
	{
		facingDirection *= -1;
		velocity.x = SPEED * facingDirection;
	}

	/* INTERFACE interfaces.Item */

	public function deploy(aX:Float, aY:Float):Void
	{
		throw "not implemented";
	}

	public function deployFromBlock(aX:Float, aY:Float):Void
	{
		reset(aX, aY);

		yTarget = aY -17;
		facingDirection = 1;
		acceleration.y = 0;
		status.activeState = blockOutState;
		allowCollisions = FlxObject.NONE;
	}

	public function pickUp():Void
	{
		GGD.addPoints(x +2, y -8, 1000);
		kill();
	}

	/* INTERFACE interfaces.InteractWithBlocks */

	public function hitByBlock(blockPosition:Int):Void
	{
		if (frameWithBlockImmunity == 0)
		{
			frameWithBlockImmunity = 3;
			
			if (blockPosition == FlxObject.DOWN)
			{
				y -= 5;
				velocity.y = -150;
			}

			if (blockPosition == FlxObject.LEFT || blockPosition == FlxObject.RIGHT)
			{
				changeDirection();
			}
		}
	}

}