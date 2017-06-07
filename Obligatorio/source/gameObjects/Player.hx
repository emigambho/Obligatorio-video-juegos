package gameObjects;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import gameObjects.Bubble;
import gameObjects.level.Flag;
import helpers.FiniteStateMachine.FSM;
import states.MarioInfoState;
import GlobalGameData;

class Player extends FlxSprite
{
	static inline var MINIMUM_BUBBLE_TIME:Float = 0.4;
	static inline var MAXIMUM_BUBBLE_TIME:Float = 1.5;
	static inline var Y_FLOOR:Float = 208;
	static inline var DISTANCE_TO_EXIT_GRASSLAND:Float = 100;
	static inline var DISTANCE_TO_EXIT_SEA:Float = 55;

	var runSpeed:Int;
	var jumpSpeed:Int;
	var gravity:Int;

	var isSeaLevel:Bool;
	var bubbleTime:Float = 0;
	var grpBubble:FlxTypedGroup<Bubble>;

	var timer:Float;
	var x_destination:Float;
	var waitCallback:Void->Void;
	var brain:FSM;

	public function new(aIsSeaLevel:Bool, aGrpBubble:FlxTypedGroup<Bubble>)
	{
		super();

		isSeaLevel = aIsSeaLevel;
		grpBubble = aGrpBubble;

		setPhysicsValues();

		loadGraphic(AssetPaths.player__png, true, 16, 16);

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

		setSize(8, 16);
		offset.set(4, 0);
	}

	function setPhysicsValues()
	{
		var maxVelocityX:Int;
		var maxVelocityY:Int;
		var frictionX:Int;

		if (!isSeaLevel)
		{
			runSpeed = 400;
			jumpSpeed = 320;
			gravity = 750;
			maxVelocityX = 150;
			maxVelocityY = 420;
			frictionX = 300;
		}
		else
		{
			runSpeed = 120;
			jumpSpeed = 96;
			gravity = 158;
			maxVelocityX = 45;
			maxVelocityY = 88;
			frictionX = 90;
		}

		acceleration.y = gravity;
		maxVelocity.set(maxVelocityX, maxVelocityY);
		drag.x = frictionX;
	}

	function walkState(elapsed:Float):Void
	{
		if (alive)
		{
			acceleration.x = 0;

			bubbles(elapsed);

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
			if (FlxG.keys.anyJustPressed([SPACE, UP, W]) && (isSeaLevel || isTouching(FlxObject.FLOOR)))
			{
				velocity.y = -jumpSpeed;
			}

			playAnimation();
		}
	}

	function slideMastState(elapsed:Float):Void
	{
		if (y >= Y_FLOOR -32)
		{
			velocity.set();
			y = Y_FLOOR -32;
		}
	}

	function walkToTheExitState(elapsed:Float):Void
	{
		animation.play("walk");
		acceleration.y = gravity;
		velocity.x = runSpeed/5;

		if (x >= x_destination)
		{
			// LLegue a la puerta, espero un poco y desaparesco.

			animation.play("idle");
			acceleration.set();
			velocity.set();
			x = x_destination;

			timer = .3;
			waitCallback = GGD.nextLevel;
			brain.activeState = waitState;
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

	public function grabTheFlag(aFlag:Flag)
	{
		x = aFlag.x; // Ajusto al personaje para que quede tocando el mástil

		velocity.set(0, runSpeed/5);
		acceleration.set();
		animation.play("slide");
		facing = FlxObject.RIGHT;
		brain.activeState = slideMastState;
	}

	public function walkToTheExit()
	{
		if (isSeaLevel)
		{
			x_destination = x + DISTANCE_TO_EXIT_SEA;
		} 
		else
		{
			x_destination = x + DISTANCE_TO_EXIT_GRASSLAND;	
		}

		
		brain.activeState = walkToTheExitState;
	}

	override public function update(elapsed:Float):Void
	{
		brain.update(elapsed);
		super.update(elapsed);
	}

	inline function bubbles(elapsed:Float)
	{
		if (isSeaLevel)
		{
			bubbleTime -= elapsed;
			if (bubbleTime <= 0)
			{
				var bubble:Bubble = grpBubble.recycle(Bubble);
				bubble.spawn(FlxG.random.float(x, x+width), y);
				bubbleTime = FlxG.random.float(MINIMUM_BUBBLE_TIME, MAXIMUM_BUBBLE_TIME);
			}
		}
	}

	function playAnimation()
	{
		if (!isTouching(FlxObject.FLOOR))
		{
			if (isSeaLevel)
			{
				if (velocity.y < 0)
				{
					animation.play("swim");
				}
				else
				{
					animation.play("sink");
				}
			}
			else
			{
				animation.play("jump");
			}
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
		velocity.y = -jumpSpeed / 2.2;
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