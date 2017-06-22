package gameObjects.level;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.tile.FlxBaseTilemap.FlxTilemapAutoTiling;
import flixel.tile.FlxTilemap;
import GlobalGameData;

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

		totalGrass();

	}
	
	private function totalGrass()
	{
		var totalGrass:Int = 0;
		var tileId:Int = 0;
		
		for (y in 0...tileMap.heightInTiles)
		{
			for (x in 0...tileMap.widthInTiles)
			{
				tileId = tileMap.getTile(x, y);
				
				if (21 <= tileId && tileId <= 23)
				{
					totalGrass++;
				}
			}
		}
		
		GGD.currentGrass = 0;
		GGD.totalGrass = totalGrass;
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
		//addDirtBackground();

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

		loadFromTiled(AssetPaths.level_3__tmx);
	}

	function level_4()
	{
		addDirtBackground();

		loadFromTiled(AssetPaths.level_4__tmx);
	}

	function loadFromTiled(level:String)
	{
		tiledMap = new TiledMap(level);

		entities = cast (tiledMap.getLayer("GameObjects"), TiledObjectLayer).objects;

		loadLayer(tileMap, "Background");

		state.add(tileMap);
	}

	inline function loadLayer(aTileMap:FlxTilemap, layerName:String)
	{
		aTileMap.loadMapFromArray(cast(tiledMap.getLayer(layerName), TiledTileLayer).tileArray, tiledMap.width, tiledMap.height, AssetPaths.tilesheet2__png, tiledMap.tileWidth, tiledMap.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 21);
	}

	function addMountainBackground()
	{
		var bg1:FlxBackdrop = new FlxBackdrop(AssetPaths.bg_1__png, 0.2, 0, true, false);
		//var bg2:FlxBackdrop = new FlxBackdrop(AssetPaths.bg_2__png, 0.6, 0, true, false);

		state.add(bg1);
		//state.add(bg2);
	}

	function addDirtBackground()
	{
		//var background:FlxBackdrop = new FlxBackdrop(AssetPaths.bg_dirt__png, 0.3, 0, true, true);

		//state.add(background);
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