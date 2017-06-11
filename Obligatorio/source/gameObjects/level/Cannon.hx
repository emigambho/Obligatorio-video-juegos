package gameObjects.level;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import gameObjects.projectiles.ProjectileFactory.ProjectileType;
import GlobalGameData;

class Cannon extends FlxSprite 
{
	static inline var RECHARGE_TIME:Float = 1.45;
	
	var timerShoot:Float;

	public function new(aX:Float, aY:Float) 
	{
		super(aX, aY);
		
		loadGraphic(AssetPaths.canon__png, false, 16, 32);
		
		immovable = true;
		
		timerShoot = 0;
	}
	
	
	override public function update(elapsed:Float):Void
	{
		timerShoot -= elapsed;

		if (timerShoot <= 0)
		{
			timerShoot = RECHARGE_TIME;
			
			GGD.projectileFactory.shoot(x, y, 1, 0, ProjectileType.CANNONBALL);
			GGD.projectileFactory.shoot(x, y, -1, 0, ProjectileType.CANNONBALL);
		}

		super.update(elapsed);
	}	
}