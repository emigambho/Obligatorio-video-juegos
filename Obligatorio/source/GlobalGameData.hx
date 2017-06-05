package;

import gameObjects.HUD;
import gameObjects.Player;
import gameObjects.level.LevelInitialization;
import gameObjects.projectiles.ProjectileFactory;

typedef GGD = GlobalGameData;
class GlobalGameData
{
	public static var score(get, null):Float = 0;
	public static var coins(get, null):Int = 0;
	public static var hud(get, null):HUD;
	//public static var player(get, null):Player;
	public static var player:Player;
	
	public static var projectileFactory:ProjectileFactory;

	public static var levelName:String;
	
	public static var miniGame:String;
	
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
	
	/*static function get_player():Player 
	{
		if (player == null){
			player = new Player();
		} 
		return player;
	}*/
	
	static function get_score():Float 
	{
		return score;
	}	
	
	static function get_coins():Int 
	{
		return coins;
	}
	
}