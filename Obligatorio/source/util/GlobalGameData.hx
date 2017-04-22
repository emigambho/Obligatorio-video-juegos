package util;

import gameObjects.HUD;
import gameObjects.Player;

typedef GGD = GlobalGameData;
class GlobalGameData
{
	public static var score:Float = 0;
	public static var coins:Int = 0;
	
	public static var hud:HUD;
	public static var player:Player;

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
}