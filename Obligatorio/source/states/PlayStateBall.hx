package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.tile.FlxBaseTilemap.FlxTilemapAutoTiling;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import gameObjects.Ball;
import gameObjects.level.Coin;
import util.GlobalGameData.GGD;

class PlayStateBall extends FlxState
{

	private var ball:Ball;
	private var tileMap:FlxTilemap;
	private var tiledMap:TiledMap;
	private var coin:Coin;
	
	override public function create():Void
	{
		super.create();
		ball = new Ball(20, 20);
		add(ball);
		FlxG.camera.bgColor = FlxColor.WHITE;
		
		coin = new Coin();
		coin.spawn(FlxG.random.int(1 + 16, 320 - 16*2),FlxG.random.int(1 + 16, 240 - 16 * 2));
		add(coin);
		
		tiledMap = new TiledMap(AssetPaths.room_ball_1__tmx);
		tileMap = new FlxTilemap();
		tileMap.loadMapFromArray(cast(tiledMap.getLayer("Wall"), TiledTileLayer).tileArray, tiledMap.width, tiledMap.height, AssetPaths.boss_tilesheet__png, tiledMap.tileWidth, tiledMap.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 1);
		tileMap.follow();
		
		add(tileMap);
		add(GGD.hud);
	}

	
	override public function update(elapsed:Float):Void 
	{
		FlxG.collide(ball, tileMap, ballVsWall);
		FlxG.overlap(ball, coin,ballVsCoin);
		super.update(elapsed);
	}
	
	function ballVsCoin(ball:Ball, coin:Coin) 
	{
		coin.spawn(FlxG.random.int(1 + 16, 320 - 16*2),FlxG.random.int(1 + 16, 240 - 16 * 2));
		GGD.coins ++;
	}
	
	function ballVsWall(ball:Ball, obj:Dynamic) 
	{
		ball.kill();
		FlxG.switchState(new MenuState());
	}
}