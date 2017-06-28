package gameObjects.level;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Fireball extends FlxSprite 
{
	static inline var VERTICAL_SPEED:Float = 100;
	static inline var HORIZONTAL_SPEED:Float = 100;

	public function new(aX:Float, aY:Float) 
	{
		super(aX, aY);
		
		loadGraphic(AssetPaths.fireball__png, true, 16, 16);
		
		animation.add("fireball", [0, 1, 2, 3], 8, true);
		animation.play("fireball");
		
		velocity.x = HORIZONTAL_SPEED;
		velocity.y = VERTICAL_SPEED;
	}
	
}