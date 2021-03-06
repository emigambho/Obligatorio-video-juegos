package states;

import enums.BlockType;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.tiled.TiledObject;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import gameObjects.HUD;
import gameObjects.Player;
import gameObjects.enemies.Boss;
import gameObjects.enemies.EnemyFactory;
import gameObjects.items.ItemFactory;
import gameObjects.level.Block;
import gameObjects.level.Cannon;
import gameObjects.level.Door;
import gameObjects.level.Lava;
import gameObjects.level.LevelInitialization;
import gameObjects.projectiles.ProjectileFactory;
import helpers.Helper;
import interfaces.Enemy;
import interfaces.InteractWithBlocks;
import interfaces.InteractWithLava;
import interfaces.Item;
import interfaces.Projectile;
import states.PauseSubState;
import GlobalGameData;

class PlayStateMario extends FlxState
{
	static private inline var PRE_LOAD_WIDTH:Float = 40;

	var player:Player;
	var grpBlock:FlxTypedGroup<Block>;
	var grpDoor:FlxTypedGroup<Door>;
	var grpLava:FlxTypedGroup<Lava>;

	var itemFactory: ItemFactory;
	var projectileFactory: ProjectileFactory;
	var enemyFactory: EnemyFactory;

	var level:LevelInitialization;
	var tileId:Int;
	
	var isChangingState:Bool;
	var isLevelComplete:Bool;
	var levelCompleteEmitter:FlxEmitter;	
	var sndLevelComplete:FlxSound;
	var timer:Float;

	override public function create():Void
	{
		level = new LevelInitialization(this, GGD.currentLevel);
		GGD.level = level;

		grpBlock = new FlxTypedGroup<Block>();
		grpDoor = new FlxTypedGroup<Door>();
		grpLava = new FlxTypedGroup<Lava>();

		player = new Player();
		GGD.player = player;
		GGD.miniGameLevel = false;
		GGD.hud = new HUD();

		itemFactory = new ItemFactory(this);
		add(grpBlock);
		enemyFactory = new EnemyFactory(this);
		
		isChangingState = false;
		isLevelComplete = false;
		
		add(grpDoor);
		add(grpLava);

		placeEntities();
		add(player);
		add(GGD.hud);
		level.addFrontLayer();

		projectileFactory = new ProjectileFactory(this);
		GGD.projectileFactory = projectileFactory;

		sndLevelComplete = FlxG.sound.load(AssetPaths.snd_level_complete__wav);
		
		levelCompleteEmitter = createEmitter();
		
		GGD.playMusic();
		
		cameraInit();

		super.create();
	}

	inline function cameraInit()
	{
		FlxG.camera.follow(player, FlxCameraFollowStyle.PLATFORMER);
		FlxG.camera.bgColor = FlxColor.WHITE; // FlxColor.fromRGB(146, 144, 255);
		FlxG.mouse.visible = false;

		FlxG.camera.setScrollBoundsRect(32, 32, level.tileMap.width -64, level.tileMap.height -32, true);

		FlxG.camera.fade(FlxColor.BLACK, .6, true);
	}

	override public function destroy():Void
	{
		GGD.clear();
		super.destroy();
	}

	function placeEntities()
	{
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

		// Ajusto la posición a un múltiplo de 32, así no es necesario ubicarlo de forma exacta en Tiled.
		x = Math.floor(x / 32) * 32;
		y = Math.floor(y / 32) * 32;

		switch (entityName)
		{
			case "Player":
				player.x = x;
				player.y = y;

			case "Mushroom":
				enemyFactory.spawn(x, y, EnemyType.MUSHROOM, SpawnMode.WALK_LEFT);

			case "Tortoise":
				createTortoise(x, y, entity);

			case "TortoiseHammer":
				enemyFactory.spawn(x, y, EnemyType.TORTOISE_HAMMER, SpawnMode.WALK_LEFT);

			case "Flower":
				enemyFactory.spawn(x, y, EnemyType.FLOWER, SpawnMode.STATIC);

			case "Brick":
				createBlock(x, y, entity);

			case "Bonus":
				createBlock(x, y, entity);

			case "Coin":
				itemFactory.deployItem(x, y, ItemType.COIN, DeployType.STATIC);

			case "Door":
				grpDoor.add(new Door(x, y));

			case "Boss":
				var boss:Boss = cast(enemyFactory.spawn(x, y, EnemyType.BOSS, SpawnMode.STATIC), Boss);
				//boss.emitter = createEmitter();
				boss.enemyFactory = enemyFactory;

			case "Lava":
				grpLava.add(new Lava(x, y));

			case "Cannon":
				add(new Cannon(x, y));
		}
		
		if (GGD.marioPositionX > 0 && GGD.marioPositionY > 0)
		{
			player.x = GGD.marioPositionX;
			player.y = GGD.marioPositionY;			
			GGD.marioPositionX = GGD.marioPositionY = 0;			
		}
	}

	inline function createTortoise(x:Int, y:Int, entity:TiledObject)
	{
		var isWalking:Int = Std.parseInt(entity.properties.get("IsWalking"));

		var spawnMode:SpawnMode = (isWalking == 1) ? SpawnMode.WALK_LEFT : SpawnMode.FLY;

		enemyFactory.spawn(x, y-14, EnemyType.TORTOISE, spawnMode);
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
		if (isLevelComplete && !isChangingState)
		{
			timer -= elapsed;
			
			if (timer <= 0){
				isChangingState = true;
				
				if (GGD.bossLevel){
					FlxG.camera.fade(FlxColor.BLACK, .6, false, function()
					{
						FlxG.switchState(new MainMenu());
					});
				} else {
					GGD.nextLevel();
				}				
			}
		}
		
		if (FlxG.keys.pressed.ESCAPE)
		{
			openSubState(new PauseSubState(0x99808080));
		}
		if (FlxG.keys.pressed.R)
		{
			levelComplete();
			//FlxG.resetState();
		}

		if (player.alive)
		{
			FlxG.collide(player, level.tileMap);
			FlxG.collide(player, grpBlock, playerVsBlock);
			FlxG.overlap(player, enemyFactory.grpEnemies, playerVsEnemy);
			FlxG.overlap(player, itemFactory.grpItems, playerVsItem);
			FlxG.overlap(player, grpDoor, playerVsDoor);
			FlxG.overlap(player, grpLava, playerVsLava);
			FlxG.overlap(player, projectileFactory.grpProjectile, playerVsProjectile);

			if (GGD.bossLevel){
				if (GGD.currentBossLife == 0 && !isLevelComplete){
					levelComplete();
				}
			} else {
				putGrass();
			}
			
		}

		FlxG.collide(enemyFactory.grpEnemiesApplyPhysics, level.tileMap);
		FlxG.collide(itemFactory.grpItemsApplyPhysics, level.tileMap);
		FlxG.collide(enemyFactory.grpEnemies, grpLava, enemyVsLava);

		FlxG.overlap(grpBlock, enemyFactory.grpEnemies, blockOverlap);
		FlxG.overlap(grpBlock, itemFactory.grpItems, blockOverlap);

		super.update(elapsed);
	}
	
	public function levelComplete()
	{
		
		isLevelComplete = true;		
		
		FlxG.sound.music.stop();
		sndLevelComplete.play();
		
		var txt:FlxText;
		
		var fix_x = FlxG.camera.scroll.x + FlxG.camera.width / 2;
		var fix_y = FlxG.camera.scroll.y + FlxG.camera.height / 2;
		if (GGD.bossLevel){
			txt = new FlxText(fix_x, fix_y, 0, "Congratulations\n YOU WIN!!!!", 32);
			timer = 3.5;
		} else {
			txt = new FlxText(fix_x, fix_y, 0, "Level\nComplete", 32);
			timer = 2;
		}
		
		txt.color = FlxColor.WHITE;
		txt.x -= txt.width / 2;
		txt.y -= txt.height / 2;
		txt.alignment = CENTER;
		add(txt);
		
		levelCompleteEmitter.x = fix_x;
		levelCompleteEmitter.y = fix_y;
		levelCompleteEmitter.start(true);
	}
	
	
	inline function putGrass()
	{
		tileId = Helper.getTileFromXY(player.x + 16, player.y + 32);

		if (tileId >= 21 && tileId <= 23 )
		{
			GGD.currentGrass++;
			GGD.hud.updateHUD();
			Helper.setTileFromXY(player.x+16, player.y, tileId -7);
			Helper.setTileFromXY(player.x + 16, player.y + 32, tileId +3);
			if (GGD.currentGrass == GGD.totalGrass)
			{
				levelComplete();			
			}
		}
	}	

	function playerVsProjectile(aPlayer:Player, aProjectile:Projectile)
	{
		aPlayer.death();
	}

	function enemyVsLava(aEnemy:Enemy, aLava:Lava)
	{
		cast(aEnemy, InteractWithLava).burnedByLava();
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
		if (FlxG.keys.pressed.DOWN && aPlayer.isTouching(FlxObject.FLOOR) && !isChangingState)
		{
			trace('Se va al mini-juego.');
			
			isChangingState = true;
			
			aPlayer.stop();
			
			GGD.actualTileMap = GGD.level.tileMap.getData();
			GGD.marioPositionX = aDoor.x;
			GGD.marioPositionY = aDoor.y;
			
			FlxG.camera.fade(FlxColor.BLACK, 0.6, false, function()
			{
				FlxG.switchState(new PlayStateMiniGames());
			});			
		}
	}

	function playerVsBlock(aPlayer:Player, aBrick:Block):Void
	{
		aBrick.hit();
	}

	function createEmitter():FlxEmitter
	{
		var emitter:FlxEmitter = new FlxEmitter(0, 0, 100);
		emitter.makeParticles(2, 2, FlxColor.WHITE, 100);
		emitter.scale.set(1, 1, 4, 4, 8, 8);
		emitter.color.set(FlxColor.RED, FlxColor.PINK, FlxColor.BLUE, FlxColor.CYAN);

		add(emitter);

		return emitter;
	}
}