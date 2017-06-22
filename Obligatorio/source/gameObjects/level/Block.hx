package gameObjects.level;

import enums.BlockType;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import gameObjects.items.ItemFactory;

class Block extends FlxSprite
{
	var yOriginal:Float;
	var _velocity:Float;
	var _acceleration:Float;
	var delayedItemDeploy:Bool;	
	var cantItems :Int;
	var itemFactory:ItemFactory;
	var itemType:ItemType;
	var blockType:BlockType;

	public function new(aX:Float, aY:Float, aCantItems:Int, aItemFactory:ItemFactory, aItemType:ItemType, aDelayedItemDeploy:Bool, aBlockType:BlockType)
	{
		aX += 4;
		aY += 2;
		
		super(aX, aY);

		immovable = true;
		yOriginal = aY;
		cantItems = aCantItems;
		itemFactory = aItemFactory;
		itemType = aItemType;
		delayedItemDeploy = aDelayedItemDeploy;
		blockType = aBlockType;
		
		if (aBlockType == BlockType.BRICK)
		{
			loadGraphic(AssetPaths.brick__png, true, 32, 32);
		}
		else
		{
			loadGraphic(AssetPaths.bonus__png, true, 32, 32);
			animation.add("full", [0]);
			animation.add("empty", [1]);
			animation.play("full");	
		}
		
		setSize(28, 32);
		offset.set(2, 2);
	}

	override public function update(elapsed:Float):Void
	{
		if (_acceleration > 0)
		{
			y += _velocity * elapsed;
			_velocity += _acceleration * elapsed;

			if (y >= yOriginal)
			{
				y = yOriginal;
				_velocity = 0;
				_acceleration = 0;

				if (delayedItemDeploy && cantItems >0)
				{
					releaseItem();
				}
			}
		}

		super.update(elapsed);
	}

	public function hit():Void
	{		
		_velocity = -400;
		_acceleration = 3400;

		if (!delayedItemDeploy && cantItems > 0)
		{
			releaseItem();
		}
	}
	
	inline function releaseItem():Void
	{
		cantItems--;
		itemFactory.deployItem(x, y, itemType, DeployType.FROM_BLOCK);
		
		if (blockType == BlockType.BONUS && cantItems == 0)
		{
			animation.play("empty");				
		}
	}

}