package gameObjects.level;

import flixel.FlxSprite;
import flixel.addons.nape.FlxNapeSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import nape.phys.BodyType;

/**
 * ...
 * @author ...
 */
class SpinningBar extends Bar
{

	public function new(?X:Float=0, ?Y:Float=0, width:Int,height:Int,velocity:Int)
	{
		super(X, Y,width,height);
		body.angularVel = velocity;
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
}