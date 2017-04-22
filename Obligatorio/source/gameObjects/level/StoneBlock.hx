package gameObjects.level;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class StoneBlock extends FlxSprite 
{

	public function new(aX:Float, aY:Float) 
	{
		super(aX, aY);
		
		loadGraphic(AssetPaths.stoneBlock__png, false, 16, 16);
		
		immovable = true;
	}
	
}