package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.addons.editors.tiled.TiledPropertySet;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.editors.tiled.TiledTilePropertySet;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxBaseTilemap.FlxTilemapAutoTiling;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import gameObjects.Ball;
import GlobalGameData;
import gameObjects.items.Coin;
import gameObjects.level.MovingBar;
import GlobalGameData.GGD;

class PlayStateBall extends FlxState
{

	private var ball:Ball;
	private var tileMap:FlxTilemap;
	private var tiledMap:TiledMap;
	var grpMovingBars:FlxTypedGroup<MovingBar>;
	private var coin:Coin;

	override public function create():Void
	{
		super.create();
		FlxG.camera.bgColor = FlxColor.WHITE;

		coin = new Coin();
		coin.deploy(FlxG.random.int(1 + 16, 320 - 16*2),FlxG.random.int(1 + 16, 240 - 16 * 2));
		add(coin);

		tiledMap = new TiledMap(AssetPaths.room_ball_1__tmx);
		tileMap = new FlxTilemap();
		tileMap.loadMapFromArray(cast(tiledMap.getLayer("Wall"), TiledTileLayer).tileArray, tiledMap.width, tiledMap.height, AssetPaths.boss_tilesheet__png, tiledMap.tileWidth, tiledMap.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 1);
		tileMap.follow();

		grpMovingBars = new FlxTypedGroup<MovingBar>();
		add(grpMovingBars);

		var tmpMap:TiledObjectLayer = cast tiledMap.getLayer("GameObjects");
		for (e in tmpMap.objects)
		{
			placeEntities(e.type, e.xmlData.x,e.properties);
		}

		add(tileMap);
		add(GGD.hud);
	}

	function placeEntities(entityName:String, entityData:Xml,properties:TiledPropertySet):Void
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		var height:Int = Std.parseInt(entityData.get("height"));
		var width:Int = Std.parseInt(entityData.get("width"));

		var velocity:Int = Std.parseInt(properties.get("velocity"));

		switch (entityName)
		{
			case "Ball":
				ball = new Ball(x, y);
				add(ball);

			case "spinningBar":
				var m:MovingBar = new MovingBar(x,y,width,height,velocity);
				grpMovingBars.add(m);
		}
	}

	override public function update(elapsed:Float):Void
	{
		FlxG.collide(ball, tileMap, ballVsWall);
		FlxG.overlap(ball, grpMovingBars, ballVsMovingBar);
		FlxG.overlap(ball, coin,ballVsCoin);
		super.update(elapsed);
	}

	function ballVsCoin(ball:Ball, coin:Coin)
	{
		coin.deploy(FlxG.random.int(1 + 16, 320 - 16*2),FlxG.random.int(1 + 16, 240 - 16 * 2));
		GGD.coins ++;
		GGD.hud.updateHUD();
	}
	
	function ballVsMovingBar(ball:Ball, mBar:MovingBar)
	{
		GGD.coins--;
		GGD.hud.updateHUD();
	}

	function ballVsWall(ball:Ball, obj:Dynamic)
	{
		GGD.coins--;
		GGD.hud.updateHUD();
		if (GGD.coins == 0){
			ball.kill();
			FlxG.switchState(new MenuState());
		}
		
	}
}