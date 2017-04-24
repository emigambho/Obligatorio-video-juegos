package states;

import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tile.FlxBaseTilemap.FlxTilemapAutoTiling;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import gameObjects.level.Block;
import gameObjects.level.Coin;
import gameObjects.Player;
import gameObjects.PowerupLife;
import gameObjects.enemies.Flower;
import gameObjects.enemies.Mushroom;
import gameObjects.enemies.Tortoise;
import gameObjects.level.Door;
import util.GlobalGameData;
import gameObjects.HUD;

class PlayState extends FlxState
{
	var tiledMap:TiledMap;
	var tileMap:FlxTilemap;

	var player:Player;
	var grpMushroom:FlxTypedGroup<Mushroom>;
	var grpTortoise:FlxTypedGroup<Tortoise>;
	var grpFlower:FlxTypedGroup<Flower>;
	var grpPowerupLife:FlxTypedGroup<PowerupLife>;
	var grpBlock:FlxTypedGroup<Block>;
	var grpCoin:FlxTypedGroup<Coin>;
	var grpDoor:FlxTypedGroup<Door>;

	override public function create():Void
	{
		
	
		FlxG.log.redirectTraces = true;

		var bg1:FlxBackdrop = new FlxBackdrop(AssetPaths.bg_1__png, 0.1, 0, true, false);
		add(bg1);
		
		var bg2:FlxBackdrop = new FlxBackdrop(AssetPaths.bg_2__png, 0.4, 0, true, false);
		add(bg2);		
		
		tiledMap = new TiledMap(AssetPaths.room_02__tmx);
		tileMap = new FlxTilemap();
		tileMap.loadMapFromArray(cast(tiledMap.getLayer("Background"), TiledTileLayer).tileArray, tiledMap.width, tiledMap.height, AssetPaths.tilesheet__png, tiledMap.tileWidth, tiledMap.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 8);
		tileMap.follow();

		grpMushroom = new FlxTypedGroup<Mushroom>();
		grpTortoise = new FlxTypedGroup<Tortoise>();
		grpFlower = new FlxTypedGroup<Flower>();
		grpBlock = new FlxTypedGroup<Block>();
		grpPowerupLife = new FlxTypedGroup<PowerupLife>();
		grpCoin = new FlxTypedGroup<Coin>();
		grpDoor = new FlxTypedGroup<Door>();

		add(grpFlower);
		add(tileMap);		
		add(grpPowerupLife);
		add(grpCoin);
		add(grpBlock);		
		add(grpMushroom);
		add(grpTortoise);
		add(grpDoor);

		player = GGD.player;
		
		add(player);
		add(GGD.hud);

		// Carga las "Entidades" en el mapa
		var tmpMap:TiledObjectLayer = cast tiledMap.getLayer("GameObjects");
		for (e in tmpMap.objects)
		{
			placeEntities(e.type, e.xmlData.x);
		}

		FlxG.camera.follow(player, FlxCameraFollowStyle.PLATFORMER);
		FlxG.camera.bgColor = FlxColor.fromRGB(146, 144, 255);
		FlxG.mouse.visible = false;
		super.create();
	}

	function placeEntities(entityName:String, entityData:Xml):Void
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));

		// Ajusto la posición a un múltiplo de 16, así no es necesario ubicarlo de forma exacta en Tiled.
		x = Math.floor(x / 16) * 16;
		y = Math.floor(y / 16) * 16;

		switch (entityName)
		{
			case "Player":
				player.x = x;
				player.y = y;

			case "Mushroom":
				var m1:Mushroom = new Mushroom();
				m1.spawn(x, y, false);
				grpMushroom.add(m1);

			case "Brick":
				grpBlock.add(new Block(x, y, 5, false, grpCoin, grpPowerupLife, true));

			case "Bonus":
				grpBlock.add(new Block(x, y, 0, true, grpCoin, grpPowerupLife, false));

			case "Tortoise":
				grpTortoise.add(new Tortoise(x, y-7));

			case "Coin":
				var c1:Coin = new Coin();
				c1.spawn(x, y);
				grpCoin.add(c1);

			case "Flower":
				grpFlower.add(new Flower(x + 8, y));
				
			case "Door":
				grpDoor.add(new Door(x +8, y));
		}
	}

	override public function update(elapsed:Float):Void
	{
		

		if (FlxG.keys.pressed.B)
		{
			FlxG.switchState(new BossState());
		}

		if (player.alive)
		{
			FlxG.collide(player, tileMap);
			FlxG.collide(player, grpBlock, playerVsBlock);
			FlxG.collide(player, grpTortoise, playerVsTortoise);
			FlxG.overlap(player, grpCoin, playerVsCoin);
			FlxG.overlap(player, grpMushroom, playerVsMushroom);
			FlxG.overlap(player, grpFlower, playerVsFlower);
			FlxG.overlap(player, grpPowerupLife, playerVsPowerupLife);
			FlxG.overlap(player, grpDoor, playerVsDoor);
		}

		FlxG.collide(grpMushroom, tileMap);
		FlxG.collide(grpMushroom, grpBlock);

		FlxG.collide(grpTortoise, tileMap);
		FlxG.collide(grpTortoise, grpBlock);

		FlxG.collide(grpPowerupLife, tileMap);
		FlxG.collide(grpPowerupLife, grpBlock);
		super.update(elapsed);
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

	function playerVsPowerupLife(aPlayer:Player, aPowerupLife:PowerupLife)
	{
		aPowerupLife.pickUp();
	}

	function playerVsFlower(aPlayer:Player, aFlower:Flower):Void
	{
		aPlayer.death();
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

	private function playerVsCoin(aPlayer:Player, aCoin:Coin):Void
	{
		if (aCoin.alive && aCoin.exists)
		{
			GGD.coins++;
			GGD.hud.updateHUD();
			aCoin.kill();
		}
	}

	function playerVsMushroom(aPlayer:Player, aMushroom:Mushroom):Void
	{
		// Al morir el Mushroom está un tiempo en pantalla, por eso verifico que este "vivo"
		if (aMushroom.alive)
		{
			if ((aPlayer.y +10) <= aMushroom.y)
			{
				aMushroom.death();
				aPlayer.jump();
			}
			else
			{
				aPlayer.death();
			}
		}
	}

	function playerVsTortoise(aPlayer:gameObjects.Player, aTortoise:Tortoise):Void
	{
		var curAnim:String = aTortoise.animation.curAnim.name;

		if (curAnim == "walk" || curAnim == "slide")
		{
			if ((aPlayer.y) <= aTortoise.y) // El Player está arriba de la tortuga
			{
				aTortoise.hit();
				aPlayer.jump();
			}
			else
			{
				aPlayer.death();
			}
		}
		else if (curAnim == "shell" || curAnim == "revive")
		{
			var slideToTheRight:Bool = (aPlayer.x <= aTortoise.x);

			if ((aPlayer.y) <= aTortoise.y)
			{
				aPlayer.jump();
			}

			aTortoise.slide(slideToTheRight);
		}

	}

}
