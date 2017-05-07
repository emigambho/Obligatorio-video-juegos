package gameObjects;
import flixel.group.FlxGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import gameObjects.level.Coin;
import gameObjects.level.Life;

/**
 * ...
 * @author 
 */
class ItemFactory 
{
	var grpCoin:FlxTypedGroup<Coin>;
	var grpLife:FlxTypedGroup<Life>;
	
	public var itemsGroup: FlxGroup;
	
	public function new(aState:FlxGroup) 
	{
		grpCoin = new FlxTypedGroup<Coin>();
		grpLife = new FlxTypedGroup<Life>();
		
		aState.add(grpCoin);
		aState.add(grpLife);
		
		itemsGroup = new FlxGroup();
		itemsGroup.add(grpCoin);
		itemsGroup.add(grpLife);
	}
	
	public function deployItem(aX:Float, aY:Float, aItemType:BlockItemType):Void
	{
		switch aItemType
		{
			case BlockItemType.LIFE:
				var life:Life = grpLife.recycle(Life);
				life.blockActivated(aX, aY);
			case BlockItemType.COIN:
				var coin:Coin = grpCoin.recycle(Coin);
				coin.blockActivated(aX, aY);
		}
	}
	
}