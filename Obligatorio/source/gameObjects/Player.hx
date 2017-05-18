package gameObjects;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import gameObjects.Bubble;
import haxe.Timer;

class Player extends FlxSprite
{
	static inline var MINIMUM_BUBBLE_TIME:Float = 0.4;
	static inline var MAXIMUM_BUBBLE_TIME:Float = 1.5;	
	
	var runSpeed:Int;
	var jumpSpeed:Int;
	var gravity:Int;
	
	var isSeaLevel:Bool;
	var bubbleTime:Float = 0;
	var grpBubble:FlxTypedGroup<Bubble>;

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

		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);

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

	override public function update(elapsed:Float):Void
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

			//if (FlxG.keys.anyJustReleased([SPACE, UP, W]))
			//{
			//velocity.y = Math.max(velocity.y, -JUMP_SPEED/3);
			//}

			playAnimation();
		}

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
		animation.play("death");
		alive = false;

		// El personaje al morir esta medio segundo quieto en pantalla y despues salta.
		acceleration.x = 0;
		acceleration.y = 0;
		velocity.x = 0;
		velocity.y = 0;
		Timer.delay(deadAnimation, 600);
	}

	function deadAnimation():Void
	{
		acceleration.y = gravity;
		velocity.y = -jumpSpeed;

		Timer.delay( function() { FlxG.resetState(); }, 1000);
	}
}