package gameObjects;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxSound;
import helpers.FiniteStateMachine.FSM;
import helpers.Helper;
import states.InfoState;
import GlobalGameData;

class Player extends FlxSprite
{
	static inline var Y_FLOOR:Float = 208;

	var runSpeed:Int;
	var jumpSpeed:Int;
	var gravity:Int;

	var timer:Float;
	var waitCallback:Void->Void;
	var brain:FSM;
	
	var isDoubleJumpAvailable:Bool;
	
	var sndJump1:FlxSound;
	var sndJump2:FlxSound;
	var sndStomp:FlxSound;

	public function new()
	{
		super();

		setPhysicsValues();

		loadGraphic(AssetPaths.player__png, true, 32, 32);

		animation.add("idle", [0]);
		animation.add("walk", [1, 2, 3], 6, true);
		animation.add("jump", [4]);
		animation.add("death", [5]);
		animation.add("swim", [6, 7, 8], 3, true);
		animation.add("sink", [9, 10], 3, true);
		animation.add("slide", [11]);

		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);

		brain = new FSM();
		brain.activeState = walkState;

		setSize(16, 32);
		offset.set(8, 0);
		
		sndJump1 = FlxG.sound.load(AssetPaths.snd_jump_super__wav);
		sndJump2 = FlxG.sound.load(AssetPaths.snd_jump_super__wav);
		sndStomp = FlxG.sound.load(AssetPaths.snd_stomp__wav);
	}

	function setPhysicsValues()
	{
		var maxVelocityX:Int;
		var maxVelocityY:Int;
		var frictionX:Int;

		runSpeed = 800;
		jumpSpeed = 640;
		gravity = 1500;
		maxVelocityX = 300;
		maxVelocityY = 840;
		frictionX = 600;

		acceleration.y = gravity;
		maxVelocity.set(maxVelocityX, maxVelocityY);
		drag.x = frictionX;
	}

	function walkState(elapsed:Float):Void
	{
		if (alive)
		{
			acceleration.x = 0;
			
			if (isTouching(FlxObject.FLOOR))
			{
				isDoubleJumpAvailable = true;
			}

			if (FlxG.keys.anyPressed([LEFT, A]))
			{
				acceleration.x = -runSpeed;
				facing = FlxObject.LEFT;
			}
			if (FlxG.keys.anyPressed([RIGHT, D]))
			{
				acceleration.x = runSpeed;
				facing = FlxObject.RIGHT;
			}
			if (FlxG.keys.anyJustPressed([SPACE, UP, W]))
			{
				if (isTouching(FlxObject.FLOOR))
				{
					sndJump1.play();
					velocity.y = -jumpSpeed;	
				}
				else if (isDoubleJumpAvailable)
				{
					sndJump2.play();
					velocity.y = -jumpSpeed;
					isDoubleJumpAvailable = false;
				}
			}

			playAnimation();
		}
	}

	function waitState(elapsed:Float):Void
	{
		timer -= elapsed;

		if (timer <= 0)
		{
			brain.activeState = null;
			waitCallback();
		}
	}

	override public function update(elapsed:Float):Void
	{
		brain.update(elapsed);
		super.update(elapsed);
	}

	function playAnimation()
	{
		if (!isTouching(FlxObject.FLOOR))
		{
			animation.play("jump");
		}
		else
		{
			if (velocity.x == 0)
			{
				animation.play("idle");
			}
			else
			{
				animation.play("walk");
			}
		}
	}

	public function bounce():Void
	{
		sndStomp.play();
		velocity.y = -jumpSpeed / 1.9;
	}

	public function death():Void
	{
		if (alive)
		{
			animation.play("death");
			alive = false;
			acceleration.set();
			velocity.set();

			// El personaje al morir esta medio segundo quieto en pantalla y despues salta.
			timer = .6;
			waitCallback = startJumpOffScreen;
			brain.activeState = waitState;
		}
	}

	function startJumpOffScreen()
	{
		acceleration.y = gravity;
		velocity.y = -jumpSpeed;
		GGD.lifes--;

		timer = 1.6;
		waitCallback = GGD.resetLevel;
		brain.activeState = waitState;
	}
}
