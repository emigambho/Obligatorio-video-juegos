package gameObjects.level;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Block extends FlxSprite
{
	var yOriginal:Float;
	var _velocity:Float;
	var _acceleration:Float;
	var isABrick:Bool;
	var containsALife:Bool;

	public var coins:Int;
	var grpCoins:FlxTypedGroup<Coin>;
	var grpPowerupLife:FlxTypedGroup<PowerupLife>;

	public function new(aX:Float, aY:Float, aCoins:Int, aContainsALife:Bool, aGrpCoins:FlxTypedGroup<Coin>, aGrpPowerupLife:FlxTypedGroup<PowerupLife>, aIsABrick:Bool)
	{
		super(aX, aY);

		immovable = true;
		yOriginal = aY;
		coins = aCoins;
		containsALife = aContainsALife;
		grpCoins = aGrpCoins;
		grpPowerupLife = aGrpPowerupLife;
		isABrick = aIsABrick;

		if (isABrick)
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

				if (containsALife)
				{
					containsALife = false;
					var life:PowerupLife = grpPowerupLife.recycle(PowerupLife);
					grpPowerupLife.add(life);
					life.startAnimation(x, y);

					if (coins == 0 && !isABrick)
					{
						animation.play("empty");
					}
				}
			}
		}

		super.update(elapsed);
	}

	public function hit():Void
	{
		_velocity = -200;
		_acceleration = 1700;

		if (containsALife)
		{
			// Acá no hago nada, al terminar la animación sale la vida.
		}
		else if (coins > 0)
		{
			coins--;
			var coin:Coin = grpCoins.recycle(Coin);
			coin.spawn(x, y - 8);
			coin.jumpInTheAir();
		}
	}

}