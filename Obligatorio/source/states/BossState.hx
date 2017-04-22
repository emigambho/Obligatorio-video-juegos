package states;

import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxBaseTilemap.FlxTilemapAutoTiling;
import flixel.tile.FlxTilemap;
import gameObjects.HUD;
import gameObjects.Player;
import gameObjects.enemies.Boss;
import gameObjects.enemies.Mushroom;
import gameObjects.level.Lava;
import gameObjects.level.StoneBlock;
import util.GlobalGameData.GGD;

class BossState extends FlxState
{
	var tiledMap:TiledMap;
	var tileMap:FlxTilemap;

	var player:Player;
	var grpMushroom:FlxTypedGroup<Mushroom>;
	var grpLava:FlxTypedGroup<Lava>;
	var boss:Boss;
	var emitter:FlxEmitter;

	override public function create():Void
	{
		super.create();

		var bg:FlxBackdrop = new FlxBackdrop(AssetPaths.bg_dirt__png, 0.3, 0, true, true);
		add(bg);		
		
		tiledMap = new TiledMap(AssetPaths.room_boss__tmx);
		tileMap = new FlxTilemap();
		tileMap.loadMapFromArray(cast(tiledMap.getLayer("Background"), TiledTileLayer).tileArray, tiledMap.width, tiledMap.height, AssetPaths.boss_tilesheet__png, tiledMap.tileWidth, tiledMap.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 1);
		tileMap.follow();		
		
		player = GGD.player;

		grpLava = new FlxTypedGroup<Lava>();
		grpMushroom = new FlxTypedGroup<Mushroom>();
		
		emitter = new FlxEmitter(0, 0);
		emitter.lifespan.min = 0.4;
		emitter.lifespan.max = 0.4;
        for (i in 0 ... 15)
        {
        	var p = new FlxParticle();
        	p.loadGraphic(AssetPaths.spark__png, false, 8, 8);
        	p.exists = false;
        	emitter.add(p);
        }		

		// Carga las "Entidades" en el mapa
		var tmpMap:TiledObjectLayer = cast tiledMap.getLayer("GameObjects");
		for (e in tmpMap.objects)
		{
			placeEntities(e.type, e.xmlData.x);
		}
		
		add(tileMap);
		add(grpMushroom);
		if (boss != null) add(boss);
		add(player);
		add(grpLava);
		add(emitter);
		add(GGD.hud);
		
		FlxG.camera.follow(player, FlxCameraFollowStyle.PLATFORMER);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (FlxG.keys.pressed.X)
		{
			FlxG.resetState();
		}		
		
		if (player.alive)
		{
			FlxG.collide(player, tileMap);
			FlxG.overlap(player, boss, playerVsBoss);
			FlxG.overlap(player, grpLava, playerVsLava);
			FlxG.overlap(player, grpMushroom, playerVsMushroom);
		}
		
		FlxG.collide(boss, tileMap);
		FlxG.overlap(boss, grpLava, bossVsLava);
		
		FlxG.collide(grpMushroom, tileMap);
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
	
	private inline function randomRange(from:Int, to:Int):Float
	{
		return (Math.random() * (to - from) + from);
	}	
	
	function bossVsLava(aBoss:Boss, aLava:Lava)
	{
		if (aBoss.animation.curAnim.name == "smash")
		{
			aBoss.damage();
		}		
	}
	
	function playerVsLava(aPlayer:Player, aLava:Lava)
	{
		aPlayer.death();
	}	
	
	function playerVsBoss(aPlayer:Player, aBoss:Boss)
	{
		aPlayer.death();
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

			case "Boss":
				boss = new Boss(x, y, emitter, grpMushroom);		
				
			case "Lava":
				grpLava.add(new Lava(x, y +4));
		}
	}
}