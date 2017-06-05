package gameObjects.enemies;

import flash.geom.Point;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import gameObjects.Player;
import gameObjects.projectiles.Hammer;
import gameObjects.projectiles.ProjectileFactory.ProjectileType;
import helpers.FiniteStateMachine.FSM;
import helpers.path.Linear;
import helpers.path.PathWalker;
import interfaces.Enemy;
import GlobalGameData;

class TortoiseHammer extends FlxSprite implements Enemy
{
	static private inline var TIME_BETWEEN_THROWING:Float = 1.1;
	static private inline var TIME_THROWING:Float = .15;
	
	var start:Point = new Point();
	var end:Point = new Point();
	var myPath:Linear;	
	var pathWalker:PathWalker;

	var timer:Float;
	var brain:FSM;
	
	public function new()
	{
		super();

		loadGraphic(AssetPaths.tortoise_hammer__png, true, 16, 33);

		animation.add("walk", [1, 0], 3, true);
		animation.add("throw", [2], 6, false);

		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		
		myPath = new Linear(start, end);
		pathWalker = new PathWalker(myPath, .9, PlayMode.Pong);
		
		brain = new FSM();
		
		setSize(14, 24);
		offset.set(0, 9);		
	}
	
	override public function update(elapsed:Float):Void
	{
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
	
	inline function move(elapsed:Float)
	{
		pathWalker.update(elapsed);
		x = pathWalker.x;
		
		if (GGD.player.x >= x)
		{
			facing = FlxObject.RIGHT;
		}
		else
		{
			facing = FlxObject.LEFT;
		}
	}
	
	function death()
	{
		GGD.addPoints(x +2, y -8, 100);
		kill();		
	}
	
	/* INTERFACE interfaces.Enemy */

	public function spawn(aX:Float, aY:Float)
	{
		reset(aX, aY);

		timer = TIME_BETWEEN_THROWING;
		brain.activeState = walkState;

		start.setTo(x, y);
		end.setTo(x+30, y);
		myPath.set(start, end);
		pathWalker.reset();
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
	
}