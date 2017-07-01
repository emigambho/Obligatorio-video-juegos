package gameObjects.level;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Lava extends FlxSprite 
{

	public function new(aX:Float, aY:Float) 
	{
		aY += 8;
		super(aX, aY);
		
		loadGraphic(AssetPaths.lava__png, true, 32,24);
		animation.add("lava", [0, 1], 2, true);
		animation.play("lava");
		
		immovable = true;
		
		//offset.set(0, 4);
		//setSize(16, 4);		
	}
	
}