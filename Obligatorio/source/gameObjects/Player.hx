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
	static inline var RUN_SPEED:Int = 800;
	static inline var JUMP_SPEED:Int = 640;
	static inline var GRAVITY:Int = 1500;
	static inline var MAX_VELOCITY_X:Int = 300;
	static inline var MAX_VELOCITY_Y:Int = 840;
	static inline var FRICTION_X:Int = 600;
	static inline var OUT_SCREEN_Y:Int = 768;

	var timer:Float;
	var waitCallback:Void->Void;
	var brain:FSM;

	var isDoubleJumpAvailable:Bool;

	var sndJump1:FlxSound;
	var sndJump2:FlxSound;
	var sndStomp:FlxSound;
	var sndDie:FlxSound;

	public function new()
	{
		super();

		acceleration.y = GRAVITY;
		maxVelocity.set(MAX_VELOCITY_X, MAX_VELOCITY_Y);
		drag.x = FRICTION_X;

		loadGraphic(AssetPaths.player__png, true, 32, 32);

		animation.add("idle", [0]);
		animation.add("walk", [1, 2, 3], 6, true);
		animation.add("jump", [4]);
		animation.add("death", [5]);

		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);

		brain = new FSM();
		brain.activeState = walkState;

		setSize(16, 32);
		offset.set(8, 0);

		setSounds();
	}

	inline function setSounds()
	{
		sndJump1 = FlxG.sound.load(AssetPaths.snd_jump_super__wav);
		sndJump2 = FlxG.sound.load(AssetPaths.snd_jump_super__wav);
		sndStomp = FlxG.sound.load(AssetPaths.snd_stomp__wav);
		sndDie = FlxG.sound.load(AssetPaths.snd_mario_die__wav);
	}

	function walkState(elapsed:Float):Void
	{
		if (y >= OUT_SCREEN_Y) // El personaje se calló de la pantalla.
		{
			death();
		}
		
		if (alive)
		{
			acceleration.x = 0;

			if (isTouching(FlxObject.FLOOR))
			{
				isDoubleJumpAvailable = true;
			}

			if (FlxG.keys.anyPressed([LEFT, A]))
			{
				acceleration.x = -RUN_SPEED;
				facing = FlxObject.LEFT;
			}
			if (FlxG.keys.anyPressed([RIGHT, D]))
			{
				acceleration.x = RUN_SPEED;
				facing = FlxObject.RIGHT;
			}
			if (FlxG.keys.anyJustPressed([SPACE, UP, W]))
			{
				if (isTouching(FlxObject.FLOOR))
				{
					sndJump1.play();
					velocity.y = -JUMP_SPEED;
				}
				else if (isDoubleJumpAvailable)
				{
					sndJump2.play();
					velocity.y = -JUMP_SPEED;
					isDoubleJumpAvailable = false;
				}
			}

			playAnimation();
		}
	}

	public function stop()
	{
		animation.play("idle");
		velocity.set();
		acceleration.set();
		brain.activeState = null;
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
		velocity.y = -JUMP_SPEED / 1.9;
	}

	public function death():Void
	{
		if (alive)
		{
			sndDie.play();
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
		acceleration.y = GRAVITY;
		velocity.y = -JUMP_SPEED;
		GGD.lifes--;

		timer = 1.6;
		waitCallback = GGD.resetLevel;
		brain.activeState = waitState;
	}
}
