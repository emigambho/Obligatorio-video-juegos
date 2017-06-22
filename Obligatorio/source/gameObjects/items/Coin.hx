package gameObjects.items;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.system.FlxSound;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import helpers.FiniteStateMachine.FSM;
import interfaces.InteractWithBlocks;
import interfaces.Item;
import GlobalGameData;

class Coin extends FlxSprite implements Item implements InteractWithBlocks
{
	static inline var JUMP_SPEED:Float = 1000;
	static inline var GRAVITY:Int = 3200;

	var yTarget:Float;
	var status:FSM;

	var sndCoin:FlxSound;
	
	public function new()
	{
		super(0, 0);

		loadGraphic(AssetPaths.coin__png, true, 32, 32);

		animation.add("idle", [0, 1, 2, 3, 4, 5], 12, true);
		animation.add("jumpInTheAir", [6, 7, 8, 9], 8, true);
		
		status = new FSM();
		
		sndCoin = FlxG.sound.load(AssetPaths.snd_coin__wav);	
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

		sndCoin.play();
		
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
			sndCoin.play();
			
			alive = false;
			GGD.addCoin();
			FlxTween.tween(this, { alpha: 0, y: y - 32 }, .33, { ease: FlxEase.circOut, onComplete: finishPicksUpAnimation });
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