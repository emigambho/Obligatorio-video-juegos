package gameObjects.projectiles;

import flixel.group.FlxGroup;
import interfaces.Projectile;

enum ProjectileType
{
	HAMMER;
	FIREBALL;
	CANNONBALL;
}

class ProjectileFactory
{
	public var grpProjectile:FlxGroup;
	
	var grpHammer:FlxTypedGroup<Hammer>;
	var grpFireball:FlxTypedGroup<Fireball>;
	var grpCannonball:FlxTypedGroup<Cannonball>;

	

	public function new(aState:FlxGroup)
	{
		grpHammer =  new FlxTypedGroup<Hammer>();
		grpFireball = new FlxTypedGroup<Fireball>();
		grpCannonball = new FlxTypedGroup<Cannonball>();

		aState.add(grpHammer);
		aState.add(grpFireball);
		aState.add(grpCannonball);

		grpProjectile = new FlxGroup();
		grpProjectile.add(grpHammer);
		grpProjectile.add(grpFireball);
		grpProjectile.add(grpCannonball);
	}

	public function shoot(aX:Float, aY:Float, directionX: Float, directionY:Float, aProjectileType:ProjectileType):Void
	{
		var projectile:Projectile = null;

		switch aProjectileType {
		case ProjectileType.HAMMER:
			projectile = grpHammer.recycle(Hammer);

			case ProjectileType.FIREBALL:
				projectile = grpFireball.recycle(Fireball);

			case ProjectileType.CANNONBALL:
				projectile = grpCannonball.recycle(Cannonball);
		}

		projectile.shoot(aX, aY, directionX, directionY);
	}
}