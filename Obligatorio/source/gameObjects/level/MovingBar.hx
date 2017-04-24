package gameObjects.level;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * ...
 * @author ...
 */
class MovingBar extends FlxSprite
{
	//Convertir en un strategy
	public function new(?X:Float=0, ?Y:Float=0, width:Int,height:Int,velocity:Int)
	{
		super(X, Y);
		makeGraphic(width, height, FlxColor.BLACK, false);
		angularVelocity = velocity;

	}

}