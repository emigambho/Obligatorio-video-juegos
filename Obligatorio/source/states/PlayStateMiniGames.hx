package states;

import flash.geom.Point;
import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.addons.editors.tiled.TiledPropertySet;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.editors.tiled.TiledTilePropertySet;
import flixel.addons.nape.FlxNapeSpace;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxBaseTilemap.FlxTilemapAutoTiling;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import gameObjects.Ball;
import GlobalGameData;
import gameObjects.HUD;
import gameObjects.items.Coin;
import gameObjects.level.Bar;
import gameObjects.level.LinearMovingBar;
import gameObjects.level.SpinningBar;
import GlobalGameData.GGD;
import nape.geom.Vec2;

class PlayStateMiniGames extends FlxState
{
	
	static var LEVEL_MIN_X;
	static var LEVEL_MAX_X;
	static var LEVEL_MIN_Y;
	static var LEVEL_MAX_Y;

	private var ball:Ball;
	private var tileMap:FlxTilemap;
	private var tiledMap:TiledMap;
	var grpMovingBars:FlxTypedGroup<Bar>;
	private var coin:Coin;

	override public function create():Void
	{
		super.create();
		FlxG.camera.bgColor = FlxColor.WHITE;
		
		FlxNapeSpace.init();
		
		FlxG.mouse.visible = false;
		
		FlxNapeSpace.velocityIterations = 5;
		FlxNapeSpace.positionIterations = 5;
		
		var bg1:FlxBackdrop = new FlxBackdrop(AssetPaths.bg_cave__jpg, 0, 0, true, true);
		add(bg1);
		
		selectLevel();
		initCoin();
		
		// Walls border
		FlxNapeSpace.createWalls(0 + 28, 0 + 28, tiledMap.width*32 - 28, tiledMap.height*32 - 28);
		
		grpMovingBars = new FlxTypedGroup<Bar>();
		add(grpMovingBars);
		
		GGD.hud = new HUD();
		GGD.miniGameTime = FlxG.random.int(15, 30);
		GGD.miniGameLevel = true;
		GGD.hud.updateHUD();

		var tmpMap:TiledObjectLayer = cast tiledMap.getLayer("GameObjects");
		for (e in tmpMap.objects)
		{
			placeEntities(e.type, e.xmlData.x,e.properties);
		}
		
		add(tileMap);
		add(GGD.hud);
		FlxG.camera.fade(FlxColor.BLACK, .6, true);
	}
	
	inline function initCoin()
	{
		coin = new Coin();
		coin.deploy(FlxG.random.int(1 + 32, tiledMap.width*32 - 32*2),FlxG.random.int(1 + 32, tiledMap.height*32 - 32 * 2));
		add(coin);
	}

	inline function selectLevel()
	{
		var nroLevel = 2;
		
		switch nroLevel
		{
			case 1:
				loadFromTiled(AssetPaths.mini_game_1__tmx);
			case 2:
				loadFromTiled(AssetPaths.mini_game_2__tmx);
			case 3:
				loadFromTiled(AssetPaths.mini_game_3__tmx);
			case 4:
				loadFromTiled(AssetPaths.mini_game_4__tmx);
			case 5:	
				loadFromTiled(AssetPaths.mini_game_5__tmx);
			case 6:	
				loadFromTiled(AssetPaths.mini_game_6__tmx);
			case 7:	
				loadFromTiled(AssetPaths.mini_game_7__tmx);
			case 8:	
				loadFromTiled(AssetPaths.mini_game_8__tmx);
			case 9:	
				loadFromTiled(AssetPaths.mini_game_9__tmx);
			default:
				throw "Invalid level";
		}
		
	}
	
	function loadFromTiled(level:String)
	{
		tiledMap = new TiledMap(level);
		tileMap = new FlxTilemap();
		tileMap.loadMapFromArray(cast(tiledMap.getLayer("Wall"), TiledTileLayer).tileArray, tiledMap.width, tiledMap.height, AssetPaths.tilesheet2__png, tiledMap.tileWidth, tiledMap.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 1);
		tileMap.follow();
	}
	
	function placeEntities(entityName:String, entityData:Xml,properties:TiledPropertySet):Void
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		var height:Int = Std.parseInt(entityData.get("height"));
		var width:Int = Std.parseInt(entityData.get("width"));
		
		switch (entityName)
		{
			case "Ball":
				ball = new Ball(x, y);
				add(ball);

			case "SpinningBar":
				var velocity:Int = Std.parseInt(properties.get("velocity"));
				var m:SpinningBar = new SpinningBar(x,y,width,height,velocity);
				grpMovingBars.add(m);
			case "LinearMovingBar":
				var speed:Int = Std.parseInt(properties.get("speed"));
				var initialX:Int = Std.parseInt(properties.get("initialX"));
				var finalX:Int = Std.parseInt(properties.get("finalX"));
				var initialY:Int = Std.parseInt(properties.get("initialY"));
				var finalY:Int = Std.parseInt(properties.get("finalY"));
				
				var start:Point = new Point();
				var end:Point = new Point();
				start.setTo(initialX, initialY);
				end.setTo(finalX, finalY);
				
				var m:LinearMovingBar = new LinearMovingBar(x,y,width,height,speed,start,end);
				grpMovingBars.add(m);
		}
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		//FlxG.overlap(ball, grpMovingBars, ballVsMovingBar);
        FlxG.overlap(ball, coin, ballVsCoin);
		
		GGD.miniGameTime -= elapsed; 
		if (GGD.miniGameTime <= 0){
			FlxG.switchState(new PlayStateMario());
			//FlxG.camera.fade(FlxColor.BLACK, .6, false, function()
			//{
				//FlxG.switchState(new PlayStateMario());
			//});
		}
		GGD.hud.updateHUD();
		
		var speed = 20;
		if (FlxG.keys.anyPressed([A, LEFT]))
			ball.body.applyImpulse(new Vec2(-speed, 0));
		if (FlxG.keys.anyPressed([S, DOWN]))
			ball.body.applyImpulse(new Vec2(0, speed));
		if (FlxG.keys.anyPressed([D, RIGHT]))
			ball.body.applyImpulse(new Vec2(speed, 0));
		if (FlxG.keys.anyPressed([W, UP]))
			ball.body.applyImpulse(new Vec2(0, -speed));
		
	}

	function ballVsCoin(ball:Ball, coin:Coin)
	{
		coin.deploy(FlxG.random.int(1 + 32, 640 - 32*2),FlxG.random.int(1 + 32, 480 - 32 * 2));
		GGD.addCoin();
		GGD.hud.updateHUD();
	}
	
	function ballVsMovingBar(ball:Ball, mBar:SpinningBar)
	{
		GGD.removeCoin();
		GGD.hud.updateHUD();
	}

}