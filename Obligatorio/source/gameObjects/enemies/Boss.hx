package gameObjects.enemies;

import flash.geom.Point;
import gameObjects.enemies.EnemyFactory.EnemyType;
import helpers.FiniteStateMachine;
import helpers.path.Linear;
import helpers.path.PathWalker;
import interfaces.Enemy;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.particles.FlxEmitter;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import GlobalGameData;
import helpers.FiniteStateMachine.FSM;
import GlobalGameData.GGD;

class Boss extends FlxSprite
{
	static inline var DETECTION_THRESHOLD:Int = 70; // Es el rango en el cual el Boss detecta al Player.
	static inline var Y_OBJETIVE:Int = 55; // Es la altura a la que sube el Boss para perseguir al Player.
	static inline var CHASE_ACCELERATION:Int = 80;
	static inline var SMASH_VELOCITY = 300;
	static inline var SLEEP_TIME = 1.2; // Tiempo que el jefe "duerme" después de atacar.

	var brain:FSM;
	var timeToWakeUp:Float;

	var emitter:FlxEmitter;
	var enemyFactory: EnemyFactory;

	var start:Point = new Point();
	var end:Point = new Point();
	var myPath:Linear;
	var pathWalker:PathWalker;

	public function new(aX:Float, aY:Float, aEmitter:FlxEmitter, aEnemyFactory:EnemyFactory)
	{
		super(aX, aY);

		emitter = aEmitter;
		enemyFactory = aEnemyFactory;

		loadGraphic(AssetPaths.boss__png, true, 50, 59);

		animation.add("onHold", [0]);
		animation.add("active", [1]);
		animation.add("damage", [2]);
		animation.add("smash", [0]);
		animation.play("onHold");

		brain = new FSM();
		brain.activeState = onHoldState;

		acceleration.y = 300;

		maxVelocity.x = 130;
		maxVelocity.y = 300;

		offset.set(9, 0);
		setSize(32, 59);

		myPath = new Linear(start, end);
		pathWalker = new PathWalker(myPath, 1.5, PlayMode.None);
	}

	public function damage()
	{
		velocity.set(0, 0);
		animation.play("damage");
		timeToWakeUp = SLEEP_TIME;
		brain.activeState = sleepState;
	}

	public function sleepState(elapsed:Float):Void
	{
		if (GGD.player.alive)
		{
			timeToWakeUp -= elapsed;

			if (timeToWakeUp <= 0)
			{
				startGoingUp();
			}
		}
	}

	override public function update(elapsed:Float):Void
	{
		brain.update(elapsed);
		super.update(elapsed);
	}

	public function onHoldState(elapsed:Float):Void
	{
		var length:Float = x - GGD.player.x;

		if (length <= DETECTION_THRESHOLD)
		{
			startGoingUp();
		}
	}

	function startGoingUp()
	{
		animation.play("active");
		
		start.setTo(x, y);
		end.setTo(x, Y_OBJETIVE);
		myPath.set(start, end);
		pathWalker.reset();
		
		velocity.set();
		acceleration.set();

		brain.activeState = goUpState;
	}

	public function goUpState(elapsed:Float):Void
	{
		pathWalker.update(FlxG.elapsed);
		x = pathWalker.x;
		y = pathWalker.y;
		
		if (pathWalker.finish())
		{
			brain.activeState = chaseState;
		}
	}

	public function chaseState(elapsed:Float):Void
	{

		var playerCenter = GGD.player.x + GGD.player.width / 2;

		if (x <= playerCenter && playerCenter <= (x + width))
		{
			// Estoy encima del Jugador.
			acceleration.x = 0;
			velocity.x = 0;
			velocity.y = SMASH_VELOCITY;
			brain.activeState = smashState;
		}
		else
		{
			var dir = (x < playerCenter) ? 1 : -1;
			acceleration.x = CHASE_ACCELERATION * dir;
		}
	}

	public function smashState(elapsed:Float):Void
	{
		animation.play("smash");

		if (isTouching(FlxObject.FLOOR))
		{
			FlxG.camera.shake(0.01, 0.2);

			emitter.x = x + width / 2;
			emitter.y = y + height;
			emitter.start(true, 0, 0);

			enemySpawn();

			animation.play("onHold");
			timeToWakeUp = SLEEP_TIME;
			brain.activeState = sleepState;
		}
	}

	// Genero 3 enemigos, uno por cada plataforma.
	function enemySpawn()
	{
		var enemy1 = enemyFactory.spawn(FlxG.random.int(0, 64), 0, EnemyType.MUSHROOM);
		cast(enemy1, Mushroom).stop();

		var enemy2 = enemyFactory.spawn(FlxG.random.int(208, 256), 0, EnemyType.MUSHROOM);
		cast(enemy2, Mushroom).stop();

		var enemy3 = enemyFactory.spawn(FlxG.random.int(400, 464), 0, EnemyType.MUSHROOM);
		cast(enemy3, Mushroom).stop();
	}
}