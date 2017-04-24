package util;

import gameObjects.HUD;
import gameObjects.Player;

typedef GGD = GlobalGameData;
class GlobalGameData
{
	public static var score:Float = 0;
	public static var coins:Int = 0;
	
	@:isVar
	public static var hud(get, set):HUD;
	
	@:isVar
	public static var player(get, set):Player;

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
	
	static function set_hud(aHud:HUD):HUD 
	{
		return hud = aHud;
	}
	
	static function get_player():Player 
	{
		if (player == null){
			player = new Player();
		} 
		return player;
	}
	
	static function set_player(value:Player):Player 
	{
		return player = value;
	}
	

	
}