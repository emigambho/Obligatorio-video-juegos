package gameObjects.level;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Door extends FlxSprite 
{

	public function new(aX:Float, aY:Float) 
	{
		super(aX, aY);
		
		makeGraphic(16, 16);
		alpha = 0;
	}
	
}