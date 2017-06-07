package states;

import enums.BlockType;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.tiled.TiledObject;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;
import gameObjects.Bubble;
import gameObjects.HUD;
import gameObjects.Player;
import gameObjects.enemies.Boss;
import gameObjects.enemies.EnemyFactory;
import gameObjects.enemies.EnemyToLoad;
import gameObjects.items.ItemFactory;
import gameObjects.level.Block;
import gameObjects.level.Door;
import gameObjects.level.Flag;
import gameObjects.level.Lava;
import gameObjects.level.LevelInitialization;
import gameObjects.projectiles.ProjectileFactory;
import helpers.Helper;
import interfaces.Enemy;
import interfaces.InteractWithBlocks;
import interfaces.Item;
import GlobalGameData;

class PlayStateMario extends FlxState
{
	static private inline var PRE_LOAD_WIDTH:Float = 40;

	var player:Player;
	var grpBlock:FlxTypedGroup<Block>;
	var grpDoor:FlxTypedGroup<Door>;
	var grpBubble:FlxTypedGroup<Bubble>;
	var grpEnemiesToLoad:List<EnemyToLoad>;
	var grpLava:FlxTypedGroup<Lava>;

	var itemFactory: ItemFactory;
	var projectileFactory: ProjectileFactory;
	var enemyFactory: EnemyFactory;

	var level:LevelInitialization;
	var flag:FlxSprite;

	override public function create():Void
	{
		level = new LevelInitialization(this, GGD.currentLevel);

		grpBlock = new FlxTypedGroup<Block>();
		grpDoor = new FlxTypedGroup<Door>();
		grpBubble = new FlxTypedGroup<Bubble>();
		grpLava = new FlxTypedGroup<Lava>();

		player = new Player(level.isSea, grpBubble);
		GGD.player = player;
		
		GGD.hud = new HUD();

		projectileFactory = new ProjectileFactory(this);
		GGD.projectileFactory = projectileFactory;

		enemyFactory = new EnemyFactory(this);
		itemFactory = new ItemFactory(this);

		add(grpBlock);
		add(grpDoor);
		add(grpLava);

		if (level.isSea)
		{
			add(grpBubble);
		}

		placeEntities();
		add(player);
		add(GGD.hud);
		level.addPipelines();
		
		cameraInit();

		loadEnemies(FlxG.camera.width);

		super.create();
	}

	inline function cameraInit()
	{
		FlxG.camera.follow(player, FlxCameraFollowStyle.PLATFORMER);
		FlxG.camera.bgColor = FlxColor.fromRGB(146, 144, 255);
		FlxG.mouse.visible = false;

		// En la parte izquierda del nivel hay una pared para que el jugador no se caiga, no dejo que se vea esa pared.
		FlxG.camera.setScrollBoundsRect(16, 0, level.tileMap.width - 16, level.tileMap.height, true);
		
		FlxG.camera.fade(FlxColor.BLACK, .6, true);			
	}

	override public function destroy():Void
	{
		GGD.clear();
		super.destroy();
	}

	function placeEntities()
	{
		grpEnemiesToLoad = new List<EnemyToLoad>();

		for (entity in level.entities)
		{
			placeEntity(entity);
		}
	}

	function placeEntity(entity:TiledObject)
	{
		var entityName:String = entity.type;
		var x:Int = Std.parseInt(entity.xmlData.x.get("x"));
		var y:Int = Std.parseInt(entity.xmlData.x.get("y"));

		// Ajusto la posición a un múltiplo de 16, así no es necesario ubicarlo de forma exacta en Tiled.
		x = Math.floor(x / 16) * 16;
		y = Math.floor(y / 16) * 16;

		switch (entityName)
		{
			case "Player":
				player.x = x;
				player.y = y;

			case "Mushroom":
				grpEnemiesToLoad.add(new EnemyToLoad(EnemyType.MUSHROOM, x, y, SpawnMode.WALK_LEFT));

			case "Tortoise":
				createTortoise(x, y, entity);

			case "TortoiseHammer":
				grpEnemiesToLoad.add(new EnemyToLoad(EnemyType.TORTOISE_HAMMER, x, y-8, SpawnMode.WALK_LEFT));

			case "Flower":
				grpEnemiesToLoad.add(new EnemyToLoad(EnemyType.FLOWER, x + 8, y, SpawnMode.WALK_LEFT));

			case 'Fish':
				grpEnemiesToLoad.add(new EnemyToLoad(EnemyType.FISH, x, y, SpawnMode.WALK_LEFT));

			case 'Octopus':
				grpEnemiesToLoad.add(new EnemyToLoad(EnemyType.OCTOPUS, x, y, SpawnMode.WALK_LEFT));

			case "Brick":
				createBlock(x, y, entity);

			case "Bonus":
				createBlock(x, y, entity);

			case "Coin":
				itemFactory.deployItem(x, y, ItemType.COIN, DeployType.STATIC);

			case "Door":
				createDoor(x, y, entity);
				

			case "Boss":
				var boss:Boss = cast(enemyFactory.spawn(x, y, EnemyType.BOSS, SpawnMode.STATIC), Boss);
				boss.emitter = createEmitter();
				boss.enemyFactory = enemyFactory;

			case "Lava":
				grpLava.add(new Lava(x, y +4));
			case "Flag":
				flag = new Flag(x, y);
				add(flag);
		}
	}

	function loadEnemies(xLimit:Int)
	{
		for (enemy in grpEnemiesToLoad)
		{
			if (enemy.x < xLimit)
			{
				enemyFactory.spawn2(enemy);
				grpEnemiesToLoad.remove(enemy);
			}
		}
	}

	inline function createTortoise(x:Int, y:Int, entity:TiledObject)
	{
		var isWalking:Int = Std.parseInt(entity.properties.get("IsWalking"));

		var spawnMode:SpawnMode = (isWalking == 1) ? SpawnMode.WALK_LEFT : SpawnMode.FLY;
		
		grpEnemiesToLoad.add(new EnemyToLoad(EnemyType.TORTOISE, x, y - 7, spawnMode));
	}
	
	inline function createDoor(x:Int, y:Int, entity:TiledObject)
	{
		var isMiniGameNum:Int = Std.parseInt(entity.properties.get("isMiniGame"));
		
		var isMiniGame:Bool = (isMiniGameNum == 1);
		
		grpDoor.add(new Door(x, y, isMiniGame));
	}

	function createBlock(x:Int, y:Int, entity:TiledObject)
	{
		var cantItems:Int = Std.parseInt(entity.properties.get("cantItems"));
		var propertyValue:Int = Std.parseInt(entity.properties.get("ItemType"));
		var itemType:ItemType = ItemType.NOT_APPLY;
		var delayedItemDeploy:Bool = false;
		var aBlockType:BlockType;

		if (entity.type=='Brick')
		{
			aBlockType = BlockType.BRICK;
		}
		else
		{
			aBlockType = BlockType.BONUS;
		}

		if (propertyValue == 1)
		{
			itemType = ItemType.COIN;
		}
		else if (propertyValue == 2)
		{
			itemType = ItemType.LIFE;
			delayedItemDeploy = true;
		}

		if (cantItems > 0 && itemType == ItemType.NOT_APPLY)
		{
			throw "The item type must be entered.";
		}

		var block:Block = new Block(x, y, cantItems, itemFactory, itemType, delayedItemDeploy, aBlockType);
		grpBlock.add(block);
	}

	override public function update(elapsed:Float):Void
	{
		if (FlxG.keys.pressed.R)
		{
			FlxG.resetState();
		}
		if (FlxG.keys.pressed.ESCAPE)
		{
			FlxG.switchState(new MenuState());	
		}

		if (player.alive)
		{
			FlxG.collide(player, level.tileMap);
			FlxG.collide(player, grpBlock, playerVsBlock);
			FlxG.overlap(player, enemyFactory.grpEnemies, playerVsEnemy);
			FlxG.overlap(player, itemFactory.grpItems, playerVsItem);
			FlxG.overlap(player, grpDoor, playerVsDoor);
			FlxG.overlap(player, grpLava, playerVsLava);

			if (flag!= null)
			{
				FlxG.overlap(player, flag, playerVsFlag);
			}
		}

		FlxG.collide(grpBubble, level.tileMap);
		FlxG.collide(enemyFactory.grpEnemiesApplyPhysics, level.tileMap);
		FlxG.collide(itemFactory.grpItemsApplyPhysics, level.tileMap);

		FlxG.overlap(grpBlock, enemyFactory.grpEnemies, blockOverlap);
		FlxG.overlap(grpBlock, itemFactory.grpItems, blockOverlap);
		FlxG.overlap(enemyFactory.grpEnemies, grpLava, enemyVsLava);
		//FlxG.collide(itemFactory.grpItemsApplyPhysics, grpBlock);

		loadEnemies(Std.int(FlxG.camera.scroll.x + FlxG.camera.width + PRE_LOAD_WIDTH));

		super.update(elapsed);
	}

	function playerVsFlag(aPlayer:Player, aFlag:Flag)
	{
		aPlayer.grabTheFlag(aFlag);
		aFlag.playerGrab(aPlayer);
	}

	function enemyVsLava(aEnemy:Enemy, aLava:Lava)
	{
		//aEnemy.burnedByLava();
	}

	function blockOverlap(aBlock:Block, aOther:FlxSprite)
	{
		var blockPosition:Int = Helper.getRelativePosition(aOther, aBlock);

		cast(aOther, InteractWithBlocks).hitByBlock(blockPosition);
	}

	function playerVsEnemy(aPlayer:Player, aEnemy:Enemy)
	{
		aEnemy.touchThePlayer(aPlayer);
	}

	function playerVsItem(aPlayer:Player, aItem:Item)
	{
		aItem.pickUp();
	}

	function playerVsLava(aPlayer:Player, aLava:Lava)
	{
		aPlayer.death();
	}

	function playerVsDoor(aPlayer:Player, aDoor:Door)
	{
		aDoor.playerTouch(aPlayer);
	}

	function playerVsBlock(aPlayer:Player, aBrick:Block):Void
	{
		aBrick.hit();
	}

	function createEmitter():FlxEmitter
	{
		var emitter:FlxEmitter = new FlxEmitter(0, 0);
		emitter.lifespan.min = 0.4;
		emitter.lifespan.max = 0.4;

		for (i in 0 ... 15)
		{
			var p = new FlxParticle();
			p.loadGraphic(AssetPaths.spark__png, false, 8, 8);
			p.exists = false;
			emitter.add(p);
		}

		add(emitter);

		return emitter;
	}
}