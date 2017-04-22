package gameObjects.enemies;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import util.FiniteStateMachine.FSM;

class Flower extends FlxSprite
{
	static inline var SPEED:Float = 22;
	static inline var WAIT_TIME_OUTSIDE:Float = 2;
	static inline var WAIT_TIME_INSIDE:Float = 3.5;

	var brain:FSM;
	var yInitial:Float;
	var yFinal:Float;
	var waitTime:Float;

	public function new(aX:Float, aY:Float)
	{
		super(aX, aY);

		loadGraphic(AssetPaths.flower__png, true, 16, 24);
		animation.add("Biting", [0, 1], 6, true);
		animation.play("Biting");

		yInitial = aY;
		yFinal = yInitial - height + 1;

		brain = new FSM(upState);
	}

	override public function update(elapsed:Float):Void
	{
		brain.update(elapsed);
		super.update(elapsed);
	}

	public function upState(elapsed:Float):Void
	{
		y -= SPEED * elapsed;

		if (y < yFinal)
		{
			waitTime = WAIT_TIME_OUTSIDE;
			brain.activeState = waitOutside;
		}
	}

	public function waitOutside(elapsed:Float):Void
	{
		waitTime -= elapsed;

		if (waitTime <= 0)
		{
			brain.activeState = downState;
		}
	}

	public function downState(elapsed:Float):Void
	{
		y += SPEED * elapsed;

		if ( y > yInitial)
		{
			waitTime = WAIT_TIME_INSIDE;
			brain.activeState = waitInside;
		}
	}

	public function waitInside(elapsed:Float):Void
	{
		waitTime -= elapsed;

		if (waitTime <= 0)
		{
			brain.activeState = upState;
		}
	}
}