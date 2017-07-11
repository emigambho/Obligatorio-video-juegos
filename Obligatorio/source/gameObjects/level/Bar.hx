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
class Bar extends FlxNapeSprite
{
	public function new(?X:Float=0, ?Y:Float=0, width:Int,height:Int)
	{
		
		super( (X +X+width)/2 ,(Y + Y+height)/2 );
		makeGraphic(width, height, FlxColor.BLACK, false);
		createRectangularBody(width, height, BodyType.KINEMATIC);
		this.setDrag(1, 1);

	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
}