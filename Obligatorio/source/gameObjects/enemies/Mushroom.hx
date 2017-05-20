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

	var facingDirection:Int;
	var timeoutDeathAnimation:Float;
	var brain:FSM;

	public function new()
	{
		super();

		loadGraphic(AssetPaths.mushroom__png, true, 16, 16);

		animation.add("idle", [0]);
		animation.add("walk", [0, 1], 6, true);
		animation.add("death", [2]);
		animation.add("burn", [3]);
		
		maxVelocity.y = GRAVITY;
		
		brain = new FSM();
	}
	
	public function walkState(elapsed:Float):Void
	{
		if (isTouching(FlxObject.WALL))
		{
			facingDirection *= -1;
			velocity.x = SPEED * facingDirection;
		}
	}
	
	public function deathState(elapsed:Float):Void
	{
		timeoutDeathAnimation -= elapsed;
		
		if (timeoutDeathAnimation <= 0){
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
			velocity.x = SPEED * facingDirection;
			brain.activeState = walkState;
		}		
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
		velocity.x = 0;	
		
		timeoutDeathAnimation = .8;
		brain.activeState = deathState;
	}
	
	
	/* INTERFACE interfaces.Enemy */

	public function spawn(aX:Float, aY:Float)
	{
		reset(aX, aY);
		
		facingDirection = -1;
		animation.play("walk");		
		acceleration.y = GRAVITY;
		velocity.x = -SPEED;		
		brain.activeState = walkState;
	}
	
	public function touchThePlayer(aPlayer:Player):Void 
	{
		if (alive)
		{
			if ((aPlayer.y +10) <= y)
			{
				animation.play("death");
				death();
				GGD.addPoints(x +2, y -8, 100);
				aPlayer.bounce();
			}
			else
			{
				aPlayer.death();
			}
		}		
	}
	
	public function burnedByLava() 
	{
		if (alive){
			animation.play("burn");
			acceleration.set();
			velocity.set();
			death();	
		}
	}
}