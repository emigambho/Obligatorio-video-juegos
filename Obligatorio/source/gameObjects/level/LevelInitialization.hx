package gameObjects.level;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.tile.FlxBaseTilemap.FlxTilemapAutoTiling;
import flixel.tile.FlxTilemap;

class LevelInitialization
{
	public var tileMap(get, null):FlxTilemap;
	public var entities(get, null):Array<TiledObject>;

	var state:FlxState;
	var tiledMap:TiledMap;
	var tileMapPipelines:FlxTilemap;
	var hasPipes:Bool = false;

	public var isSea:Bool = false;

	public function new(aState:FlxState, nroLevel:Int)
	{
		state = aState;

		tileMap = new FlxTilemap();

		switch nroLevel
		{
			case 0:
				level_0();
			case 1:
				level_1();
			case 2:
				level_2();
			case 3:
				level_3();
			case 4:
				level_4();
			default:
				throw "Invalid level";
		}
	}

	public function addPipelines()
	{
		if (hasPipes)
		{
			tileMapPipelines = new FlxTilemap();

			loadLayer(tileMapPipelines, "PipeLayer");
			state.add(tileMapPipelines);
		}
	}
	
	function level_0()
	{
		addMountainBackground();

		hasPipes = true;

		loadFromTiled(AssetPaths.level_0__tmx);
	}	

	function level_1()
	{
		addMountainBackground();

		hasPipes = true;

		loadFromTiled(AssetPaths.level_1__tmx);
	}

	function level_2()
	{
		isSea = true;
		hasPipes = true;

		loadFromTiled(AssetPaths.level_2__tmx);
	}
	
	function level_3()
	{
		addMountainBackground();
	
		hasPipes = true;

		//loadFromTiled(AssetPaths.level_1__tmx);		
	}

	function level_4()
	{
		addDirtBackground();

		loadFromTiled(AssetPaths.level_boss2__tmx);
	}

	function loadFromTiled(level:String)
	{
		tiledMap = new TiledMap(level);

		entities = cast (tiledMap.getLayer("GameObjects"), TiledObjectLayer).objects;

		loadLayer(tileMap, "Background");
		//tileMap.follow();

		state.add(tileMap);
	}

	inline function loadLayer(aTileMap:FlxTilemap, layerName:String)
	{
		aTileMap.loadMapFromArray(cast(tiledMap.getLayer(layerName), TiledTileLayer).tileArray, tiledMap.width, tiledMap.height, AssetPaths.tilesheet__png, tiledMap.tileWidth, tiledMap.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 25);
	}

	function addMountainBackground()
	{
		var bg1:FlxBackdrop = new FlxBackdrop(AssetPaths.bg_1__png, 0.1, 0, true, false);
		var bg2:FlxBackdrop = new FlxBackdrop(AssetPaths.bg_2__png, 0.4, 0, true, false);

		state.add(bg1);
		state.add(bg2);
	}

	function addDirtBackground()
	{
		var background:FlxBackdrop = new FlxBackdrop(AssetPaths.bg_dirt__png, 0.3, 0, true, true);

		state.add(background);
	}

	function get_tileMap():FlxTilemap
	{
		return tileMap;
	}

	function get_entities():Array<TiledObject>
	{
		return entities;
	}

}