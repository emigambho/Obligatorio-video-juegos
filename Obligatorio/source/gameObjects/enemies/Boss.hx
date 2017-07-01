package gameObjects.enemies;

import flash.geom.Point;
import flixel.system.FlxSound;
import gameObjects.Player;
import gameObjects.enemies.EnemyFactory.EnemyType;
import helpers.FiniteStateMachine;
import helpers.Helper;
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
import interfaces.InteractWithLava;
import states.WinSubState;

class Boss extends FlxSprite implements Enemy implements InteractWithLava
{
	static inline var DETECTION_THRESHOLD:Int = 140; // Es el rango en el cual el Boss detecta al Player.
	static inline var Y_OBJETIVE:Int = 280; // Es la altura a la que sube el Boss para perseguir al Player.
	static inline var CHASE_ACCELERATION:Int = 160;
	static inline var SMASH_VELOCITY = 600;
	static inline var SLEEP_TIME = 1.2; // Tiempo que el jefe "duerme" después de atacar.

	public var emitter(null, set):FlxEmitter;
	public var enemyFactory(null, set): EnemyFactory;	
	
	var brain:FSM;
	var timer:Float;
	var vulnerable:Bool;
	var alreadyHitted:Bool;

	var start:Point = new Point();
	var end:Point = new Point();
	var myPath:Linear;
	var pathWalker:PathWalker;
	
	var hurtSound: FlxSound;
	var killedSound: FlxSound;

	public function new()
	{
		super();

		loadGraphic(AssetPaths.boss__png, true, 100, 118);

		animation.add("onHold", [0]);
		animation.add("active", [1]);
		animation.add("damage", [2]);
		animation.add("smash", [0]);
		animation.play("onHold");

		brain = new FSM();

		maxVelocity.x = 260;
		maxVelocity.y = 600;

		offset.set(18, 0);
		setSize(64, 118);

		myPath = new Linear(start, end);
		pathWalker = new PathWalker(myPath, 1.5, PlayMode.None);
		
		hurtSound = FlxG.sound.load(AssetPaths.snd_hurt_boss__wav);
		killedSound = FlxG.sound.load(AssetPaths.snd_kill_boss__wav);
	}

	override public function update(elapsed:Float):Void
	{
		if (GGD.player.alive)
		{
			brain.update(elapsed);
		}	
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

	public function sleepState(elapsed:Float):Void
	{
		timer -= elapsed;

		if (timer <= 0)
		{
			vulnerable = false;
			startGoingUp();
		}
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

			//emitter.x = x + width / 2;
			//emitter.y = y + height;
			//emitter.start(true, 0, 0);

			enemySpawn();

			animation.play("onHold");
			timer = SLEEP_TIME;
			brain.activeState = sleepState;
		}
	}

	// Genero 3 enemigos, uno por cada plataforma.
	function enemySpawn()
	{
		var enemy1 = enemyFactory.spawn(FlxG.random.int(0, 185), 0, EnemyType.MUSHROOM, SpawnMode.WALK_RIGHT);
		cast(enemy1, Mushroom).stop();
		cast(enemy1, Mushroom).set_dontfall(false);

		var enemy2 = enemyFactory.spawn(FlxG.random.int(385, 576), 0, EnemyType.MUSHROOM, SpawnMode.WALK_LEFT);
		cast(enemy2, Mushroom).stop();
		cast(enemy2, Mushroom).set_dontfall(false);

		var enemy3 = enemyFactory.spawn(FlxG.random.int(768, 930), 0, EnemyType.MUSHROOM, SpawnMode.WALK_LEFT);
		cast(enemy3, Mushroom).stop();
		cast(enemy3, Mushroom).set_dontfall(false);
	}
	
	public function set_emitter(value:FlxEmitter):FlxEmitter 
	{
		return emitter = value;
	}
	
	public function set_enemyFactory(value:EnemyFactory):EnemyFactory 
	{
		return enemyFactory = value;
	}
	
	/* INTERFACE interfaces.Enemy */
	
	public function spawn(aX:Float, aY:Float, spawnMode:SpawnMode):Void 
	{
		reset(aX, aY);

		acceleration.y = 300;
		GGD.currentBossLife = 1;
		GGD.totalBossLife= 1;
		
		brain.activeState = onHoldState;
		GGD.hud.updateHUD();
	}	
	
	public function touchThePlayer(aPlayer:Player):Void 
	{
		if (vulnerable)
		{
			if (!alreadyHitted) 
			{
				var posPlayer:Int = Helper.getRelativePosition(this, aPlayer);
				if (posPlayer == FlxObject.UP)
				{
					aPlayer.bounce();
					GGD.currentBossLife--;
					alreadyHitted = true;
					if (GGD.currentBossLife == 0)
					{
						killedSound.play();
						brain.activeState = null;
						// openSubState(new WinSubState(0x99808080));
					} else {
						hurtSound.play();
					}
				}	
			}
		}
		else
		{
			aPlayer.death();	
		}
		GGD.hud.updateHUD();
	}
	
	/* INTERFACE interfaces.InteractWithLava */
	
	public function burnedByLava():Void 
	{
		if (animation.curAnim.name == "smash")
		{
			velocity.set(0, 0);
			animation.play("damage");
			vulnerable = true;
			alreadyHitted = false;
			timer = SLEEP_TIME * 2.5;			
			brain.activeState = sleepState;
		}		
	}
	
}