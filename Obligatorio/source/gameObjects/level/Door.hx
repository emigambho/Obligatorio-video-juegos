package gameObjects.level;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import gameObjects.Player;

class Door extends FlxSprite 
{
	public function new(aX:Float, aY:Float) 
	{
		super(aX, aY);
		
		makeGraphic(16, 16);
		alpha = 0;
	}
	
	public function playerTouch(aPlayer:Player)
	{
		if (FlxG.keys.pressed.DOWN)
		{
			trace("ir a mini-juego ...");			
		}
	}
	
}