package;

import flixel.FlxG;
import flixel.util.FlxColor;
import gameObjects.HUD;
import gameObjects.Player;
import gameObjects.level.LevelInitialization;
import gameObjects.projectiles.ProjectileFactory;
import states.MarioInfoState;

typedef GGD = GlobalGameData;
class GlobalGameData
{
	public static inline var Y_SCREEN_OUT = 250;

	public static var lifes:Int;
	public static var score(get, null):Int;
	public static var coins(get, null):Int;
	public static var hud:HUD;
	public static var player:Player;

	public static var projectileFactory:ProjectileFactory;

	public static var currentLevel:Int;

	public function new() {	}
	public static var miniGame:String;

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

	static function get_score():Int
	{
		return score;
	}

	static function get_coins():Int
	{
		return coins;
	}

	public static function newGame()
	{
		lifes = 3;
		score = 0;
		coins = 0;
		currentLevel = 1;
		FlxG.switchState(new MarioInfoState());
	}	

	public static function resetLevel()
	{
		FlxG.camera.fade(FlxColor.BLACK, .6, false, function()
		{
			FlxG.switchState(new MarioInfoState());
		});		
	}	
	
	public static function nextLevel()
	{
		currentLevel++;

		FlxG.camera.fade(FlxColor.BLACK, .6, false, function()
		{
			FlxG.switchState(new MarioInfoState());
		});
	}

}