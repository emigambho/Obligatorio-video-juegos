package;

import flixel.FlxG;
import flixel.util.FlxColor;
import gameObjects.HUD;
import gameObjects.Player;
import gameObjects.level.LevelInitialization;
import gameObjects.projectiles.ProjectileFactory;
import states.InfoState;
import states.MainMenu;

typedef GGD = GlobalGameData;

class GlobalGameData
{
	public static inline var Y_SCREEN_OUT = 820;

	public static var lifes:Int;
	public static var coins(get, null):Int;
	public static var hud:HUD;
	public static var player:Player;

	public static var projectileFactory:ProjectileFactory;

	public static var currentLevel:Int;
	public static var level:LevelInitialization;

	public static var totalGrass:Int;
	public static var currentGrass:Int;
	
	public function new() {	}
	public static var miniGame:String;

	public static function addCoin():Void
	{
		coins++;
		hud.updateHUD();
	}
	
	public static function removeCoin():Void
	{
		coins--;
		hud.updateHUD();
	}

	public static function clear():Void
	{
		hud = null;
		player = null;
		projectileFactory = null;
		level = null;
	}

	static function get_coins():Int
	{
		return coins;
	}

	public static function newGame()
	{
		lifes = 3;
		coins = 0;
		currentLevel = 1;
		FlxG.switchState(new InfoState());
	}	

	public static function resetLevel()
	{
		FlxG.camera.fade(FlxColor.BLACK, .6, false, function()
		{
			FlxG.switchState(new InfoState());
		});		
	}	
	
	public static function nextLevel()
	{
		currentLevel++;

		FlxG.camera.fade(FlxColor.BLACK, .6, false, function()
		{
			FlxG.switchState(new InfoState());
		});
	}
	
	public static function goToMainMenu()
	{
		FlxG.camera.fade(FlxColor.BLACK, .6, false, function()
		{
			FlxG.switchState(new MainMenu());
		});	
	}

	public static function playMusic()
	{
		FlxG.sound.playMusic(AssetPaths.snd_music__mp3, 0.6, true);
	}
	
}