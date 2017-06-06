package;

import flixel.FlxG;
import flixel.util.FlxColor;
import gameObjects.HUD;
import gameObjects.Player;
import gameObjects.level.LevelInitialization;
import gameObjects.projectiles.ProjectileFactory;

typedef GGD = GlobalGameData;
class GlobalGameData
{
	public static inline var Y_SCREEN_OUT = 250;
	
	public static var score(get, null):Float = 0;
	public static var coins(get, null):Int = 0;
	public static var hud(get, null):HUD;
	public static var player:Player;
	
	public static var projectileFactory:ProjectileFactory;

	public static var currentLevel:Int;
	
	 public function new() {	}
	
	public static function addCoin():Void
	{
		coins++;
		hud.updateHUD();
	}
	
	public static function addPoints(aX:Float, aY:Float, aPoints:Int)
	{
		score += aPoints;
		hud.updateHUD();
		hud.showPoints(aX, aY, aPoints);
	}
	
	public static function clear():Void
	{
		hud = null;
		player = null;
		projectileFactory = null;
	}	
	
	static function get_hud():HUD 
	{
		if (hud == null){
			hud = new HUD();
		} 
		
		return hud;
	}
	
	static function get_score():Float 
	{
		return score;
	}	
	
	static function get_coins():Int 
	{
		return coins;
	}
	
	
	public static function nextLevel()
	{
		currentLevel++;
		
		FlxG.camera.fade(FlxColor.BLACK, .6, false, function()
		{
			FlxG.resetState();
		});
	}	
}