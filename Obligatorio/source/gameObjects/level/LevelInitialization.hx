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
	
	public var isSea:Bool = false;	
	
	public function new(aState:FlxState, levelName:String) 
	{
		state = aState;
		
		tileMap = new FlxTilemap();
		
		switch levelName {
			case 'level_01':
				level01();
			case 'level_02':
				level02();
			case 'level_boss':
				levelBoss();
			default: 
				throw "Invalid level";
		}
	}
	
	function level01()
	{
		addMountainBackground();
		
		loadFromTiled(AssetPaths.level_1__tmx, AssetPaths.tilesheet__png, 17);
	}
	
	function level02() 
	{
		isSea = true;
		
		loadFromTiled(AssetPaths.level_2__tmx, AssetPaths.tilesheet_sea__png, 3);		
	}	
	
	function levelBoss() 
	{
		addDirtBackground();
		
		loadFromTiled(AssetPaths.level_boss2__tmx, AssetPaths.tilesheet__png, 17);		
	}
	
	function loadFromTiled(level:String, tileSheet:String, collideIndex:Int)
	{
		var tiledMap:TiledMap = new TiledMap(level);

		entities = cast (tiledMap.getLayer("GameObjects"), TiledObjectLayer).objects;
		
		tileMap.loadMapFromArray(cast(tiledMap.getLayer("Background"), TiledTileLayer).tileArray, tiledMap.width, tiledMap.height, tileSheet, tiledMap.tileWidth, tiledMap.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, collideIndex);		
		tileMap.follow();
		
		state.add(tileMap);
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