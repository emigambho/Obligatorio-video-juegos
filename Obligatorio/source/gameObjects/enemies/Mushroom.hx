package gameObjects.enemies;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.text.FlxText;
import haxe.Timer;
import GlobalGameData;
import helpers.FiniteStateMachine.FSM;
import interfaces.Enemy;

class Mushroom extends FlxSprite implements Enemy
{
	static inline var GRAVITY:Int = 400;
	static inline var SPEED:Float = 55;

	var directionOfWalking:Int;
	var timeToEndAnimationDeath:Float;
	var brain:FSM;

	public function new()
	{
		super(0, 0);

		loadGraphic(AssetPaths.mushroom__png, true, 16, 16);

		animation.add("idle", [0]);
		animation.add("walk", [0, 1], 6, true);
		animation.add("death", [2]);
		
		acceleration.y = GRAVITY;
		maxVelocity.y = GRAVITY;
		
		brain = new FSM(null);
	}
	
	public function walkState(elapsed:Float):Void
	{
		if (isTouching(FlxObject.WALL))
		{
			directionOfWalking *= -1;
			velocity.x = SPEED * directionOfWalking;
		}		
	}
	
	public function deathState(elapsed:Float):Void
	{
		timeToEndAnimationDeath -= elapsed;
		
		if (timeToEndAnimationDeath <= 0){
			kill();
		}
	}	

	// Es para el nivel del jefe. En este nivel los enemigos caen del techo sin velocidad en X
	// y empiezan a caminar al tocar el piso. 
	public function stopState(elapsed:Float):Void
	{
		if (velocity.x == 0 && alive && isTouching(FlxObject.FLOOR))
		{
			animation.play("walk");
			velocity.x = SPEED * directionOfWalking;
			brain.activeState = walkState;
		}		
	}
	
	public function spawn(aX:Float, aY:Float)
	{
		reset(aX, aY);
		
		directionOfWalking = -1;
		animation.play("walk");		
		velocity.x = -SPEED;		
		brain.activeState = walkState;
	}

	public function stop()
	{
		velocity.x = 0;
		animation.play("idle");
		brain.activeState = stopState;
	}
	
	override public function update(elapsed:Float):Void
	{
		/*if (y >= 610) // Se cayó de la pantalla, lo reciclo.
		{
			kill();
			return;
		}*/		

		brain.update(elapsed);
		super.update(elapsed);		
	}

	private function death()
	{
		alive = false;
		animation.play("death");		
		velocity.x = 0;
		GGD.addPoints(x +2, y -8, 100);
		
		timeToEndAnimationDeath = .8;
		brain.activeState = deathState;
	}
	
	
	/* INTERFACE interfaces.Enemy */
	
	public function touchThePlayer(aPlayer:Player):Void 
	{
		if (alive)
		{
			if ((aPlayer.y +10) <= y)
			{
				death();
				aPlayer.jump();
			}
			else
			{
				aPlayer.death();
			}
		}		
	}
}