package gameObjects.enemies;

import flash.geom.Point;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import gameObjects.Player;
import helpers.FiniteStateMachine.FSM;
import helpers.path.Linear;
import helpers.path.PathWalker;
import interfaces.Enemy;

class Octopus extends FlxSprite implements Enemy
{
	static inline var TIME_TO_SWIM:Float = 1.45;

	var start:Point = new Point();
	var end:Point = new Point();
	var myPath:Linear;	
	var pathWalker:PathWalker;
	var isSwimmingUp:Bool;

	public function new()
	{
		super();

		loadGraphic(AssetPaths.octopus__png, true, 16, 24);

		animation.add("swimUp", [0]);
		animation.add("swimDown", [1, 0], 1, false);		

		myPath = new Linear(start, end);
		pathWalker = new PathWalker(myPath, TIME_TO_SWIM, PlayMode.None);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		pathWalker.update(elapsed);
		x = pathWalker.x;
		y = pathWalker.y;

		if (pathWalker.finish())
		{
			if (isSwimmingUp)
			{
				startSwimDown();
			}
			else
			{
				startSwimUp();
			}
		}
	}
	
	function startSwimUp()
	{
		isSwimmingUp = true;
		animation.play("swimUp");

		var dir:Int = (FlxG.random.bool()) ? -1 : 1;

		start.setTo(x, y);
		end.setTo(x + (70 * dir), y - 40);
		myPath.set(start, end);
		pathWalker.reset();
	}

	function startSwimDown()
	{
		isSwimmingUp = false;
		animation.play("swimDown");
		
		start.setTo(x, y);
		end.setTo(x, y + 40);
		myPath.set(start, end);
		pathWalker.reset();		
	}	

	/* INTERFACE interfaces.Enemy */

	public function spawn(aX:Float, aY:Float, spawnMode:SpawnMode)
	{
		reset(aX, aY);

		startSwimUp();
	}	
	
	public function touchThePlayer(aPlayer:Player):Void 
	{
		aPlayer.death();
	}
	
	
}