package gameObjects.level;

import enums.BlockType;
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

	public function new(aX:Float, aY:Float, aCantItems:Int, aItemFactory:ItemFactory, aItemType:ItemType, aDelayedItemDeploy:Bool, aBlockType:BlockType)
	{
		super(aX, aY);

		immovable = true;
		yOriginal = aY;
		cantItems = aCantItems;
		itemFactory = aItemFactory;
		itemType = aItemType;
		delayedItemDeploy = aDelayedItemDeploy;
		
		if (aBlockType == BlockType.BRICK)
		{
			loadGraphic(AssetPaths.brick__png, false, 16, 16);
		}
		else
		{
			loadGraphic(AssetPaths.bonus__png, true, 16, 16);
			animation.add("idle", [0, 1, 2, 1], 5, true);
			animation.add("empty", [3]);
			animation.play("idle");
		}
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
		_velocity = -200;
		_acceleration = 1700;

		if (!delayedItemDeploy && cantItems > 0)
		{
			releaseItem();
		}
	}
	
	inline function releaseItem():Void
	{
		cantItems--;
		itemFactory.deployItem(x, y, itemType, DeployType.FROM_BLOCK);
	}

}