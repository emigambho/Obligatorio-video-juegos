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
import gameObjects.enemies.EnemyFactory;
import gameObjects.enemies.Mushroom;
import gameObjects.level.Lava;
import gameObjects.level.StoneBlock;
import GlobalGameData.GGD;
import interfaces.Enemy;

class BossState extends FlxState
{
	var tiledMap:TiledMap;
	var tileMap:FlxTilemap;

	var grpLava:FlxTypedGroup<Lava>;
	var boss:Boss;
	var emitter:FlxEmitter;

	var enemyFactory: EnemyFactory;

	override public function create():Void
	{
		super.create();

		var bg:FlxBackdrop = new FlxBackdrop(AssetPaths.bg_dirt__png, 0.3, 0, true, true);
		add(bg);

		tiledMap = new TiledMap(AssetPaths.room_boss__tmx);
		tileMap = new FlxTilemap();
		tileMap.loadMapFromArray(cast(tiledMap.getLayer("Background"), TiledTileLayer).tileArray, tiledMap.width, tiledMap.height, AssetPaths.boss_tilesheet__png, tiledMap.tileWidth, tiledMap.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 1);
		tileMap.follow();
		
		grpLava = new FlxTypedGroup<Lava>();

		add(tileMap);
		enemyFactory = new EnemyFactory(this);
		
		// Carga las "Entidades" en el mapa
		var tmpMap:TiledObjectLayer = cast tiledMap.getLayer("GameObjects");
		for (e in tmpMap.objects)
		{
			placeEntities(e.type, e.xmlData.x);
		}

		add(boss);
		add(GGD.player);
		add(grpLava);
		add(emitter);
		add(GGD.hud);

		FlxG.camera.follow(GGD.player, FlxCameraFollowStyle.PLATFORMER);
	}

	override public function destroy():Void
	{
		GGD.clear();
		super.destroy();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (FlxG.keys.pressed.X)
		{
			FlxG.resetState();
		}

		if (GGD.player.alive)
		{
			FlxG.collide(GGD.player, tileMap);
			FlxG.overlap(GGD.player, boss, playerVsBoss);
			FlxG.overlap(GGD.player, grpLava, playerVsLava);
			FlxG.overlap(GGD.player, enemyFactory.grpEnemies, playerVsEnemy);
		}

		FlxG.collide(boss, tileMap);
		FlxG.overlap(boss, grpLava, bossVsLava);
		FlxG.collide(enemyFactory.grpEnemiesApplyPhysics, tileMap);
	}

	function playerVsEnemy(aPlayer:Player, aEnemy:Enemy)
	{
		aEnemy.touchThePlayer(aPlayer);
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
				GGD.player.x = x;
				GGD.player.y = y;

			case "Boss":
				createEmitter();
				boss = new Boss(x, y, emitter, enemyFactory);

			case "Lava":
				grpLava.add(new Lava(x, y +4));
		}
	}
	
	function createEmitter():Void 
	{
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
	}
}