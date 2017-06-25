package states;

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
import gameObjects.level.MovingBar;
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
	var grpMovingBars:FlxTypedGroup<MovingBar>;
	private var coin:Coin;

	override public function create():Void
	{
		super.create();
		FlxG.camera.bgColor = FlxColor.WHITE;
		GGD.hud = new HUD();
		FlxNapeSpace.init();
		
		LEVEL_MIN_X = -FlxG.stage.stageWidth / 2;
		LEVEL_MAX_X = FlxG.stage.stageWidth * 1.5;
		LEVEL_MIN_Y = -FlxG.stage.stageHeight / 2;
		LEVEL_MAX_Y = FlxG.stage.stageHeight * 1.5;
		
		FlxG.mouse.visible = false;
		
		FlxNapeSpace.velocityIterations = 5;
		FlxNapeSpace.positionIterations = 5;
		
		var bg1:FlxBackdrop = new FlxBackdrop(AssetPaths.Trees1__png, 0.1, 0, true, false);
		add(bg1);
		
		var bg2:FlxBackdrop = new FlxBackdrop(AssetPaths.Trees2__png, 0.2, 0, true, false);
		add(bg2);
		
		var bg3:FlxBackdrop = new FlxBackdrop(AssetPaths.Trees3__png, 0.4, 0, true, false);
		add(bg3);
		
		var bg4:FlxBackdrop = new FlxBackdrop(AssetPaths.Trees4__png, 0.8, 0, true, false);
		add(bg4);		
		
		// Walls border.

		tiledMap = new TiledMap(AssetPaths.mini_game_3__tmx);
		tileMap = new FlxTilemap();
		tileMap.loadMapFromArray(cast(tiledMap.getLayer("Wall"), TiledTileLayer).tileArray, tiledMap.width, tiledMap.height, AssetPaths.tilesheet2__png, tiledMap.tileWidth, tiledMap.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 1);
		tileMap.follow();
		
		coin = new Coin();
		coin.deploy(FlxG.random.int(1 + 32, tiledMap.width*32 - 32*2),FlxG.random.int(1 + 32, tiledMap.height*32 - 32 * 2));
		add(coin);
		
		FlxNapeSpace.createWalls(0 + 28, 0 + 28, tiledMap.width*32 - 28, tiledMap.height*32 - 28);
		
		grpMovingBars = new FlxTypedGroup<MovingBar>();
		add(grpMovingBars);

		var tmpMap:TiledObjectLayer = cast tiledMap.getLayer("GameObjects");
		for (e in tmpMap.objects)
		{
			placeEntities(e.type, e.xmlData.x,e.properties);
		}
		
		GGD.hud.changeColor(FlxColor.BLACK, FlxColor.BLACK, FlxColor.BLACK);

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
		super.update(elapsed);
		//FlxG.overlap(ball, grpMovingBars, ballVsMovingBar);
        FlxG.overlap(ball, coin,ballVsCoin);

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
	
	function ballVsMovingBar(ball:Ball, mBar:MovingBar)
	{
		GGD.removeCoin();
		GGD.hud.updateHUD();
	}

}