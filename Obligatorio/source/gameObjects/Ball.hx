package gameObjects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.nape.FlxNapeSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import nape.phys.Material;

class Ball extends FlxNapeSprite
{
	static inline var RUN_SPEED:Float = 400;

	public function new(?X:Float=0, ?Y:Float=0)
	{
		
		super(X ,Y, AssetPaths.Ball__png);
		createCircularBody(18);
		body.allowRotation = true;
		body.allowMovement = true;
		this.antialiasing = true;
		setDrag(0.96, 0.96);
		
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		if (FlxG.camera.target != null && FlxG.camera.followLead.x == 0) // target check is used for debug purposes.
		{
			x = Math.round(x); // Smooths camera and orb shadow following. Does not work well with camera lead.
			y = Math.round(y); // Smooths camera and orb shadow following. Does not work well with camera lead.
		}

	}

}