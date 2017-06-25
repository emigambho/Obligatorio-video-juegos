package helpers;
import flixel.FlxObject;
import flixel.FlxSprite;
import GlobalGameData;

class Helper
{

	public static function getRelativePosition(obj1:FlxSprite, obj2:FlxSprite):Int
	{
		var deltaX = (obj2.x + obj2.width/2) - (obj1.x + obj1.width/2);
		var deltaY = (obj2.y + obj2.height/2) - (obj1.y + obj1.height/2);

		if (Math.abs(deltaX) >= Math.abs(deltaY))
		{
			if (deltaX > 0)
			{
				trace('RIGHT');
				return FlxObject.RIGHT;
			}
			else
			{
				trace('LEFT');
				return FlxObject.LEFT;
			}
		}
		else {
			if (deltaY > 0)
			{
				trace('DOWN');
				return FlxObject.DOWN;
			}
			else
			{
				trace('UP');
				return FlxObject.UP;
			}
		}
	}	
	
	public static inline function getTileFromXY(x:Float, y:Float):Int
	{
		return GGD.level.tileMap.getTile(Math.floor(x/32), Math.floor(y/32));
	}
	
	public static inline function setTileFromXY(x:Float, y:Float, tileId:Int):Void
	{
		GGD.level.tileMap.setTile(Math.floor(x/32), Math.floor(y/32), tileId, true);
	}
	
}