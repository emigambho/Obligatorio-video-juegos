package states;

import enums.BlockType;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import gameObjects.Bubble;
import gameObjects.enemies.Boss;
import gameObjects.enemies.EnemyFactory;
import gameObjects.enemies.EnemyToLoad;
import gameObjects.items.ItemFactory;
import gameObjects.level.Block;
import gameObjects.Player;
import gameObjects.level.Door;
import GlobalGameData;
import gameObjects.HUD;
import gameObjects.level.Flag;
import gameObjects.level.Lava;
import gameObjects.level.LevelInitialization;
import gameObjects.projectiles.Hammer;
import gameObjects.projectiles.ProjectileFactory;
import interfaces.Enemy;
import interfaces.Item;

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
		level = new LevelInitialization(this, GGD.levelName);
		
		grpBlock = new FlxTypedGroup<Block>();
		grpDoor = new FlxTypedGroup<Door>();
		grpBubble = new FlxTypedGroup<Bubble>();
		grpLava = new FlxTypedGroup<Lava>();

		player = new Player(level.isSea, grpBubble);
		GGD.player = player;
		
		projectileFactory = new ProjectileFactory(this);
		GGD.projectileFactory = projectileFactory;
		
		enemyFactory = new EnemyFactory(this);
		itemFactory = new ItemFactory(this);
		
		level.addPipelines();
		
		add(grpBlock);
		add(grpDoor);
		add(grpLava);
		
		if (level.isSea){
			add(grpBubble);
		}

		placeEntities();

		add(player);
		add(GGD.hud);		

		FlxG.camera.follow(player, FlxCameraFollowStyle.PLATFORMER);
		FlxG.camera.bgColor = FlxColor.fromRGB(146, 144, 255);
		FlxG.mouse.visible = false;
		super.create();
		
		loadEnemies(FlxG.camera.width);		
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
				grpEnemiesToLoad.add(new EnemyToLoad(EnemyType.MUSHROOM, x, y));

			case "Tortoise":
				grpEnemiesToLoad.add(new EnemyToLoad(EnemyType.TORTOISE, x, y-7));

			case "TortoiseHammer":
				grpEnemiesToLoad.add(new EnemyToLoad(EnemyType.TORTOISE_HAMMER, x, y-8));
				
			case "Flower":
				grpEnemiesToLoad.add(new EnemyToLoad(EnemyType.FLOWER, x + 8, y));
				
			case 'Fish':
				grpEnemiesToLoad.add(new EnemyToLoad(EnemyType.FISH, x, y));
				
			case 'Octopus':
				grpEnemiesToLoad.add(new EnemyToLoad(EnemyType.OCTOPUS, x, y));

			case "Brick":
				createAndAddBlock(x, y, entity);

			case "Bonus":
				createAndAddBlock(x, y, entity);

			case "Coin":
				itemFactory.deployItem(x, y, ItemType.COIN, DeployType.STATIC);

			case "Door":
				grpDoor.add(new Door(x, y));
				
			case "Boss":
				var boss:Boss =  cast(enemyFactory.spawn(x, y, EnemyType.BOSS), Boss);
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
	
	function createAndAddBlock(x:Int, y:Int, entity:TiledObject)
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
		if (player.alive)
		{
			FlxG.collide(player, level.tileMap);
			FlxG.collide(player, grpBlock, playerVsBlock);			
			FlxG.overlap(player, enemyFactory.grpEnemies, playerVsEnemy);
			FlxG.overlap(player, itemFactory.grpItems, playerVsItem);
			FlxG.overlap(player, grpDoor, playerVsDoor);
			FlxG.overlap(player, grpLava, playerVsLava);
			
			if(flag!= null){
				FlxG.overlap(player, flag, playerVsFlag);
			}
		}

		FlxG.collide(grpBubble, level.tileMap);
		FlxG.overlap(enemyFactory.grpEnemies, grpLava, enemyVsLava);
		FlxG.collide(enemyFactory.grpEnemiesApplyPhysics, level.tileMap);
		FlxG.collide(enemyFactory.grpEnemiesApplyPhysics, grpBlock);
		FlxG.collide(itemFactory.grpItemsApplyPhysics, level.tileMap);
		FlxG.collide(itemFactory.grpItemsApplyPhysics, grpBlock);

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
		aEnemy.burnedByLava();
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
		if (FlxG.keys.pressed.DOWN)
		{
			FlxG.camera.fade(FlxColor.BLACK,.33, false, function()
			{
				FlxG.switchState(new PlayStateBall());
			});
		}
	}

	function playerVsBlock(aPlayer:Player, aBrick:Block):Void
	{
		// La condición valida si el player esta debajo del bloque
		if (aPlayer.y >= (aBrick.y +aBrick.height) && aPlayer.velocity.y == 0)
		{
			aBrick.hit();
		}
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
