package gameObjects.level;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxAssets.FlxGraphicAsset;


class Poster extends FlxSprite 
{
	public var playerOverlap:Bool;
	
	var tip:FlxSprite;
	
	public function new(aX:Float, aY:Float, aState:FlxState) 
	{
		super(aX, aY);
		
		loadGraphic(AssetPaths.poster__png, true, 26, 28);
		
		tip = new FlxSprite(x, y, AssetPaths.tip_1__png);
		tip.x -= tip.width/2;
		tip.y -= tip.height + 20;
		tip.visible = false;
		
		aState.add(tip);
	}
	
	override public function update(elapsed:Float):Void
	{
		if (playerOverlap)
		{
			tip.visible = true;
			
			playerOverlap = false;
		}
		else
		{
			tip.visible = false;	
		}		
		
		super.update(elapsed);
	}
	
}