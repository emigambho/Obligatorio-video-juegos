package gameObjects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Ball extends FlxSprite
{
	static inline var RUN_SPEED:Float = 400;

	public function new(?X:Float=0, ?Y:Float=0)
	{
		super(X, Y);
		
		maxVelocity.y = 500;
		maxVelocity.x = 500;
		
		drag.x = maxVelocity.x * 0.3;
		drag.y = maxVelocity.y * 0.3;
		
		
		
		loadRotatedGraphic(AssetPaths.Ball__png,300,-1,false,false);
	}

	override public function update(elapsed:Float):Void
	{
		acceleration.set(100, 120);
		
		if (FlxG.keys.anyPressed([LEFT, A]))
		{
			acceleration.x -= RUN_SPEED;
			
		}
		if (FlxG.keys.anyPressed([RIGHT, A]))
		{
			acceleration.x += RUN_SPEED;
			
		}
		if (FlxG.keys.anyPressed([UP, A]))
		{
			acceleration.y -= RUN_SPEED;
			
		}
		if (FlxG.keys.anyPressed([DOWN, A]))
		{
			acceleration.y += RUN_SPEED;
			
		}

		super.update(elapsed);
	}

}