package gameObjects.level;

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
	var tileMapFront:FlxTilemap;

	public function new(aState:FlxState, nroLevel:Int)
	{
		state = aState;

		tileMap = new FlxTilemap();

		addBackground();
		
		switch nroLevel
		{
			case 0:	
				level_0();
			case 1:
				loadFromTiled(AssetPaths.level_01__tmx);
			case 2:
				loadFromTiled(AssetPaths.level_02__tmx);
			case 3:
				loadFromTiled(AssetPaths.level_03__tmx);
			case 4:
				loadFromTiled(AssetPaths.level_04__tmx);
			default:
				throw "Invalid level";
		}

		calculateTotalGrass();
	}
	
	private function calculateTotalGrass()
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

	public function addFrontLayer()
	{
		tileMapFront = new FlxTilemap();

		loadLayer(tileMapFront, "FrontLayer");
		state.add(tileMapFront);
	}

	function level_0()
	{
		addBackground();

		loadFromTiled(AssetPaths.level_0__tmx);
	}

	function loadFromTiled(level:String)
	{
		tiledMap = new TiledMap(level);

		entities = cast (tiledMap.getLayer("Entities"), TiledObjectLayer).objects;

		loadLayer(tileMap, "WallLayer");

		state.add(tileMap);
	}

	inline function loadLayer(aTileMap:FlxTilemap, layerName:String)
	{
		aTileMap.loadMapFromArray(cast(tiledMap.getLayer(layerName), TiledTileLayer).tileArray, tiledMap.width, tiledMap.height, AssetPaths.tilesheet2__png, tiledMap.tileWidth, tiledMap.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 21);
	}

	function addBackground()
	{
		var bg1:FlxBackdrop = new FlxBackdrop(AssetPaths.Trees1__png, 0.1, 0, true, false);
		state.add(bg1);
		
		var bg2:FlxBackdrop = new FlxBackdrop(AssetPaths.Trees2__png, 0.2, 0, true, false);
		state.add(bg2);
		
		var bg3:FlxBackdrop = new FlxBackdrop(AssetPaths.Trees3__png, 0.4, 0, true, false);
		state.add(bg3);
		
		var bg4:FlxBackdrop = new FlxBackdrop(AssetPaths.Trees4__png, 0.8, 0, true, false);
		state.add(bg4);		
		
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