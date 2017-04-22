package util;

import gameObjects.HUD;
import gameObjects.Player;

typedef GGD = GlobalGameData;
class GlobalGameData
{
	public static var score:Float = 0;
	public static var coins:Int = 0;
	
	public static var hud(get, null):HUD;
	public static var player(get, null):Player;

	public function new() 
	{
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
	}
	
	
	static function get_hud():HUD 
	{
		if (hud == null){
			hud = new HUD();
		} 
		
		return hud;
	}
	

	static function get_player():Player 
	{
		if (player == null){
			player = new Player();
		} 
		return player;
	}
	
	
}