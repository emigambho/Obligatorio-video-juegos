package gameObjects.items;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import helpers.FiniteStateMachine.FSM;
import interfaces.InteractWithBlocks;
import interfaces.Item;
import GlobalGameData;

class Coin extends FlxSprite implements Item implements InteractWithBlocks
{
	static inline var JUMP_SPEED:Float = 500;
	static inline var GRAVITY:Int = 1700;

	var yTarget:Float;

	var status:FSM;
	
	public function new()
	{
		super(0, 0);

		loadGraphic(AssetPaths.coin__png, true, 16, 16);

		animation.add("idle", [0, 1, 2, 3, 4, 5], 12, true);
		animation.add("jumpInTheAir", [6, 7, 8, 9], 8, true);
		
		status = new FSM();
	}

	override public function update(elapsed:Float):Void
	{
		status.update(elapsed);
		super.update(elapsed);
	}

	function staticState(elapsed:Float) { }
	
	function jumpState(elapsed:Float) 
	{
		if (y > yTarget)
		{
			// Ya hice el salto y volví a la posición inicial, reciclo la moneda.
			kill();
		}
	}
	
	public function jumpInTheAir()
	{
		animation.play("jumpInTheAir");

		yTarget = y;
		acceleration.y = GRAVITY;
		velocity.y = -JUMP_SPEED;
		allowCollisions = FlxObject.NONE;
		
		status.activeState = jumpState;
	}

	/* INTERFACE interfaces.Item */

	public function deploy(aX:Float, aY:Float):Void
	{
		reset(aX, aY);

		alpha = 1;
		animation.play("idle");
		allowCollisions = FlxObject.ANY;
		
		status.activeState = staticState;
	}

	public function deployFromBlock(aX:Float, aY:Float):Void
	{
		deploy(aX, aY);

		jumpInTheAir();
	}

	public function pickUp():Void
	{
		if (alive && exists)
		{
			alive = false;
			GGD.addCoin();
			FlxTween.tween(this, { alpha: 0, y: y - 16 }, .33, { ease: FlxEase.circOut, onComplete: finishPicksUpAnimation });
		}
	}

	private function finishPicksUpAnimation(_):Void
	{
		exists = false;
	}

	/* INTERFACE interfaces.InteractWithBlocks */

	public function hitByBlock(blockPosition:Int):Void
	{
		if (blockPosition == FlxObject.DOWN)
		{
			jumpInTheAir();	
		}		
	}

}