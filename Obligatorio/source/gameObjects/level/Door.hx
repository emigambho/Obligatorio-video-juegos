package gameObjects.level;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import gameObjects.Player;

class Door extends FlxSprite 
{
	public function new(aX:Float, aY:Float) 
	{
		aX += 16;
		super(aX, aY);
		
		makeGraphic(32, 32);
		//alpha = 0;
	}
	

	
}