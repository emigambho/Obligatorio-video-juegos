package gameObjects.enemies;

import gameObjects.Player;
import helpers.FiniteStateMachine;
import helpers.path.Linear;
import interfaces.Enemy;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import helpers.FiniteStateMachine.FSM;
import GlobalGameData;
import gameObjects.projectiles.ProjectileFactory.ProjectileType;

class Flower extends FlxSprite implements Enemy
{
	static inline var SPEED:Float = 44;
	static inline var WAIT_TIME_OUTSIDE:Float = 2;
	static inline var WAIT_TIME_INSIDE:Float = 3.5;

	var brain:FSM;
	var yInitial:Float;
	var yFinal:Float;
	var waitTime:Float;

	public function new()
	{
		super();

		loadGraphic(AssetPaths.flower__png, true, 32, 48);
		animation.add("Biting", [0, 1], 6, true);
		
		brain = new FSM();
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
			shootFireball();
			
			waitTime = WAIT_TIME_OUTSIDE;
			brain.activeState = waitUp;
		}
	}
	
	inline function shootFireball() 
	{
		var deltaX:Float = (GGD.player.x + GGD.player.width/2) -x;
		var deltaY:Float = (GGD.player.y + GGD.player.height / 2) -y;
		var length:Float = Math.sqrt(deltaX * deltaX + deltaY * deltaY);
		deltaX /= length;
		deltaY /= length;
		
		GGD.projectileFactory.shoot(x, y, deltaX, deltaY, ProjectileType.FIREBALL);
	}

	public function waitUp(elapsed:Float):Void
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
			brain.activeState = waitDown;
		}
	}

	public function waitDown(elapsed:Float):Void
	{
		waitTime -= elapsed;

		if (waitTime <= 0)
		{
			brain.activeState = upState;
		}
	}
	
	
	/* INTERFACE interfaces.Enemy */

	public function spawn(aX:Float, aY:Float, spawnMode:SpawnMode):Void 
	{
		aX += 16;
		//aY += 16;
		
		reset(aX, aY);
		
		animation.play("Biting");

		yInitial = aY;
		yFinal = yInitial - height + 1;
		brain.activeState = upState;
	}	
	
	public function touchThePlayer(aPlayer:Player):Void 
	{
		aPlayer.death();
	}
	
}