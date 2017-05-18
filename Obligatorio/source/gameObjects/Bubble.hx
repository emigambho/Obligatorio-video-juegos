package gameObjects;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Bubble extends FlxSprite 
{
	static inline var SPEED:Float = 40;
	
	public function new() 
	{
		super();
		
		loadGraphic(AssetPaths.bubble__png, false, 4, 4);
		
	}
	
	override public function update(elapsed:Float):Void
	{
		if (isTouching(FlxObject.UP))
		{
			kill();
		}
		
		super.update(elapsed);		
	}	
	
	public function spawn(aX:Float, aY:Float)
	{
		reset(aX, aY);
		
		velocity.y = -SPEED;
	}
	
}