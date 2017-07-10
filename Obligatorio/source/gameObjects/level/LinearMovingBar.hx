package gameObjects.level;

import flash.geom.Point;
import flixel.FlxSprite;
import flixel.addons.nape.FlxNapeSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import helpers.path.Linear;
import helpers.path.PathWalker;
import nape.geom.Vec2;
import nape.phys.BodyType;

/**
 * ...
 * @author ...
 */
class LinearMovingBar extends Bar
{
	
	var myPath:Linear;
	var pathWalker:PathWalker;
	
	public function new(?X:Float = 0, ?Y:Float = 0, width:Int, height:Int, speed:Int, start:Point , end:Point)
	{
		super(X, Y,width,height);
		this.setDrag(1, 1);
		myPath = new Linear(start, end);
		pathWalker = PathWalker.fromSpeed(myPath, speed, PlayMode.Pong);
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		pathWalker.update(elapsed);
		body.position.setxy(pathWalker.x,pathWalker.y);
	}
	
}