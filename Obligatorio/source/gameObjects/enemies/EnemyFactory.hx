package gameObjects.enemies;

import flixel.group.FlxGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import interfaces.Enemy;

enum EnemyType
{
	MUSHROOM;
	TORTOISE;
	TORTOISE_HAMMER;
	FLOWER;
	BOSS;
}

class EnemyFactory
{
	public var grpEnemies:FlxGroup;
	public var grpEnemiesApplyPhysics:FlxGroup;
	
	var grpMushroom:FlxTypedGroup<Mushroom>;
	var grpTortoise:FlxTypedGroup<Tortoise>;	
	var grpTortoiseHammer:FlxTypedGroup<TortoiseHammer>;
	var grpFlower:FlxTypedGroup<Flower>;
	var grpBoss:FlxTypedGroup<Boss>;

	public function new(aState:FlxGroup)
	{
		
		grpMushroom = new FlxTypedGroup<Mushroom>();
		grpTortoise = new FlxTypedGroup<Tortoise>();
		grpTortoiseHammer = new FlxTypedGroup<TortoiseHammer>();
		grpFlower = new FlxTypedGroup<Flower>();
		grpBoss = new FlxTypedGroup<Boss>();

		aState.add(grpMushroom);
		aState.add(grpTortoise);
		aState.add(grpTortoiseHammer);
		aState.add(grpFlower);
		aState.add(grpBoss);

		grpEnemies = new FlxGroup();
		grpEnemies.add(grpMushroom);
		grpEnemies.add(grpTortoise);
		grpEnemies.add(grpTortoiseHammer);
		grpEnemies.add(grpFlower);
		grpEnemies.add(grpBoss);

		grpEnemiesApplyPhysics = new FlxGroup();
		grpEnemiesApplyPhysics.add(grpMushroom);
		grpEnemiesApplyPhysics.add(grpTortoise);
		grpEnemiesApplyPhysics.add(grpBoss);
	}

	public function spawn(aX:Float, aY:Float, aEnemyType:EnemyType, spawnMode:SpawnMode):Enemy
	{
		var enemy:Enemy = null;

		switch aEnemyType {
			case EnemyType.MUSHROOM:
				enemy = grpMushroom.recycle(Mushroom);

			case EnemyType.TORTOISE:
				enemy = grpTortoise.recycle(Tortoise);

			case EnemyType.TORTOISE_HAMMER:
				enemy = grpTortoiseHammer.recycle(TortoiseHammer);
				
			case EnemyType.FLOWER:
				enemy = grpFlower.recycle(Flower);
				
			case EnemyType.BOSS:
				enemy = grpBoss.recycle(Boss);
		}

		enemy.spawn(aX, aY, spawnMode);

		return enemy;
	}
}