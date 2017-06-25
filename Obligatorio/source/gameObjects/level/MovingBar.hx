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
		body.allowRotation = true;
		body.allowMovement = true;
		body.angularVel = velocity;
		this.setDrag(1, 1);
		this.setBodyMaterial(1, 0.2, 0.01, 0.0001);
		this.antialiasing = true;

	}
	
	override public function update(elapsed:Float):Void
	{
		this.body.rotation += 5;
	}

}