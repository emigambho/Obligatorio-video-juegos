package states;

import enums.BlockType;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.addons.editors.tiled.TiledPropertySet;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tile.FlxBaseTilemap.FlxTilemapAutoTiling;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import gameObjects.enemies.EnemyFactory;
import gameObjects.items.ItemFactory;
import gameObjects.level.Block;
import gameObjects.items.Coin;
import gameObjects.Player;
import gameObjects.items.Life;
import gameObjects.enemies.Flower;
import gameObjects.enemies.Mushroom;
import gameObjects.enemies.Tortoise;
import gameObjects.level.Door;
import GlobalGameData;
import gameObjects.HUD;
import interfaces.Enemy;
import interfaces.Item;

class PlayState extends FlxState
{
	var tiledMap:TiledMap;
	var tileMap:FlxTilemap;

	var player:Player;
	var grpBlock:FlxTypedGroup<Block>;
	var grpDoor:FlxTypedGroup<Door>;

	var itemFactory: ItemFactory;
	var enemyFactory: EnemyFactory;

	override public function create():Void
	{
		//FlxG.log.redirectTraces = true;

		var bg1:FlxBackdrop = new FlxBackdrop(AssetPaths.bg_1__png, 0.1, 0, true, false);
		var bg2:FlxBackdrop = new FlxBackdrop(AssetPaths.bg_2__png, 0.4, 0, true, false);

		tiledMap = new TiledMap(AssetPaths.room_01__tmx);
		tileMap = new FlxTilemap();
		tileMap.loadMapFromArray(cast(tiledMap.getLayer("Background"), TiledTileLayer).tileArray, tiledMap.width, tiledMap.height, AssetPaths.tilesheet__png, tiledMap.tileWidth, tiledMap.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 8);
		tileMap.follow();

		grpBlock = new FlxTypedGroup<Block>();
		grpDoor = new FlxTypedGroup<Door>();

		add(bg1);
		add(bg2);

		enemyFactory = new EnemyFactory(this);
		itemFactory = new ItemFactory(this);
				
		add(tileMap);
		add(grpBlock);
		add(grpDoor);

		player = GGD.player;

		add(player);
		add(GGD.hud);

		// Carga las "Entidades" en el mapa
		var tmpMap:TiledObjectLayer = cast tiledMap.getLayer("GameObjects");
		for (entity in tmpMap.objects)
		{
			placeEntities(entity);
		}

		FlxG.camera.follow(player, FlxCameraFollowStyle.PLATFORMER);
		FlxG.camera.bgColor = FlxColor.fromRGB(146, 144, 255);
		FlxG.mouse.visible = false;
		super.create();
	}

	override public function destroy():Void
	{
		GGD.clear();
		super.destroy();
	}

	function placeEntities(entity:TiledObject)
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
				enemyFactory.spawn(x, y, EnemyType.MUSHROOM);

			case "Tortoise":
				enemyFactory.spawn(x, y-7, EnemyType.TORTOISE);

			case "Flower":
				enemyFactory.spawn(x+8, y, EnemyType.FLOWER);
				
			case "Brick":
				createAndAddBlock(x, y, entity, BlockType.BRICK);

			case "Bonus":
				createAndAddBlock(x, y, entity, BlockType.BONUS);

			case "Coin":
				itemFactory.deployItem(x, y, ItemType.COIN, DeployType.STATIC);

			case "Door":
				grpDoor.add(new Door(x +8, y));
		}
	}

	function createAndAddBlock(x:Int, y:Int, entity:TiledObject, aBlockType:BlockType)
	{
		var cantItems:Int = Std.parseInt(entity.properties.get("cantItems"));
		var propertyValue:Int = Std.parseInt(entity.properties.get("ItemType"));
		var itemType:ItemType = ItemType.NOT_APPLY;
		var delayedItemDeploy:Bool = false;
		
		if (propertyValue == 1)
		{
			itemType = ItemType.COIN;
		}
		else if (propertyValue == 2)
		{
			itemType = ItemType.LIFE;
			delayedItemDeploy = true;			
		}

		if (cantItems > 0 && itemType == ItemType.NOT_APPLY){
			throw "The item type must be entered.";
		}
		
		var block:Block = new Block(x, y, cantItems, itemFactory, itemType, delayedItemDeploy, aBlockType);
		grpBlock.add(block);
	}
	
	override public function update(elapsed:Float):Void
	{
		if (player.alive)
		{
			FlxG.collide(player, tileMap);
			FlxG.collide(player, grpBlock, playerVsBlock);
			FlxG.overlap(player, enemyFactory.grpEnemies, playerVsEnemy);
			FlxG.overlap(player, itemFactory.grpItems, playerVsItem);
			FlxG.overlap(player, grpDoor, playerVsDoor);
		}

		FlxG.collide(enemyFactory.grpEnemiesApplyPhysics, tileMap);
		FlxG.collide(enemyFactory.grpEnemiesApplyPhysics, grpBlock);
		FlxG.collide(itemFactory.grpItemsApplyPhysics, tileMap);
		FlxG.collide(itemFactory.grpItemsApplyPhysics, grpBlock);
		
		super.update(elapsed);
	}

	function playerVsEnemy(aPlayer:Player, aEnemy:Enemy)
	{
		aEnemy.touchThePlayer(aPlayer);
	}
	
	function playerVsItem(aPlayer:Player, aItem:Item)
	{
		aItem.pickUp();
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
		// hay que sumarle 16 al bloque para tomar su parte de "Abajo"
		if (aPlayer.y >= (aBrick.y +16) && aPlayer.velocity.y == 0)
		{
			aBrick.hit();
		}
	}

}
