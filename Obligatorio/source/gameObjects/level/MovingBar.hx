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
class MovingBar extends FlxNapeSprite
{
	//Convertir en un strategy
	public function new(?X:Float=0, ?Y:Float=0, width:Int,height:Int,velocity:Int)
	{
		super(X, Y);
		makeGraphic(width, height, FlxColor.BLACK, false);
		createRectangularBody(width, height, BodyType.KINEMATIC);
		body.angularVel = velocity;
		this.setDrag(1, 1);

	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
}