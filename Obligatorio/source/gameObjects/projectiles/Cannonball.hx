package gameObjects.projectiles;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import interfaces.Projectile;

class Cannonball extends FlxSprite implements Projectile
{

	public function new() 
	{
		super();
		
	}
	
	
	/* INTERFACE interfaces.Projectile */
	
	public function shoot(aX:Float, aY:Float, directionX: Float, directionY:Float):Void 
	{
		
	}
	
	public function touchThePlayer(aPlayer:Player):Void 
	{
		aPlayer.death();
	}
	
}