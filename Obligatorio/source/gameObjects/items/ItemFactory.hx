package gameObjects.items;

import flixel.group.FlxGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import gameObjects.items.Coin;
import gameObjects.items.Life;
import interfaces.Item;

enum ItemType 
{
	COIN; 
	LIFE; 
	NOT_APPLY;
}

enum DeployType 
{
	STATIC; 
	FROM_BLOCK;
}

class ItemFactory 
{
	var grpCoin:FlxTypedGroup<Coin>;
	var grpLife:FlxTypedGroup<Life>;
	
	public var grpItems:FlxGroup;
	public var grpItemsApplyPhysics:FlxGroup;
	
	public function new(aState:FlxGroup) 
	{
		grpCoin = new FlxTypedGroup<Coin>();
		grpLife = new FlxTypedGroup<Life>();
		
		aState.add(grpCoin);
		aState.add(grpLife);
		
		grpItems = new FlxGroup();
		grpItems.add(grpCoin);
		grpItems.add(grpLife);
		
		grpItemsApplyPhysics = new FlxGroup();
		grpItemsApplyPhysics.add(grpLife);		
	}
	
	public function deployItem(aX:Float, aY:Float, aItemType:ItemType, aDeployType:DeployType):Item
	{
		var item:Item = null;
		
		switch aItemType
		{
			case ItemType.LIFE:
				item = grpLife.recycle(Life);
				
			case ItemType.COIN:
				item = grpCoin.recycle(Coin);
			default:
				throw "The item type is not valid.";	
		}
		
		if (aDeployType == DeployType.STATIC)
		{
			item.deploy(aX, aY);
		}
		else
		{
			item.deployFromBlock(aX, aY);
		}
		
		return item;
	}
	
}