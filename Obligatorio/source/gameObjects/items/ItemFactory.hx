package gameObjects.items;
import enums.DeployType;
import enums.ItemType;
import flixel.group.FlxGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import gameObjects.items.Coin;
import gameObjects.items.Life;
import interfaces.Item;

class ItemFactory 
{
	var grpCoin:FlxTypedGroup<Coin>;
	var grpLife:FlxTypedGroup<Life>;
	
	public var itemsGroup:FlxGroup;
	
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
	
	public function deployItem(aX:Float, aY:Float, itemType:ItemType, deployType:DeployType):Void
	{
		var item:Item = null;
		
		switch itemType
		{
			case ItemType.LIFE:
				item = grpLife.recycle(Life);
				
			case ItemType.COIN:
				item = grpCoin.recycle(Coin);
			default:
				throw "The item type is not valid.";	
		}
		
		if (deployType == DeployType.STATIC)
		{
			item.deploy(aX, aY);
		}
		else
		{
			item.deployFromBlock(aX, aY);
		}
	}
	
}