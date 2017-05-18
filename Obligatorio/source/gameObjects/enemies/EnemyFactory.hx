package gameObjects.enemies;

import flixel.group.FlxGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import gameObjects.enemies.Boss;
import gameObjects.enemies.Octopus;
import interfaces.Enemy;

enum EnemyType
{
	MUSHROOM;
	TORTOISE;
	FLOWER;
	BOSS;
	FISH;
	OCTOPUS;
}

class EnemyFactory
{
	var grpMushroom:FlxTypedGroup<Mushroom>;
	var grpTortoise:FlxTypedGroup<Tortoise>;
	var grpFlower:FlxTypedGroup<Flower>;
	var grpBoss:FlxTypedGroup<Boss>;
	var grpFishes:FlxTypedGroup<Fish>;
	var grpOctopuses:FlxTypedGroup<Octopus>;

	public var grpEnemies:FlxGroup;
	public var grpEnemiesApplyPhysics:FlxGroup;

	public function new(aState:FlxGroup)
	{
		grpMushroom = new FlxTypedGroup<Mushroom>();
		grpTortoise = new FlxTypedGroup<Tortoise>();
		grpFlower = new FlxTypedGroup<Flower>();
		grpBoss = new FlxTypedGroup<Boss>();
		grpFishes = new FlxTypedGroup<Fish>();
		grpOctopuses = new FlxTypedGroup<Octopus>();

		aState.add(grpMushroom);
		aState.add(grpTortoise);
		aState.add(grpFlower);
		aState.add(grpBoss);
		aState.add(grpFishes);
		aState.add(grpOctopuses);

		grpEnemies = new FlxGroup();
		grpEnemies.add(grpMushroom);
		grpEnemies.add(grpTortoise);
		grpEnemies.add(grpFlower);
		grpEnemies.add(grpBoss);
		grpEnemies.add(grpFishes);
		grpEnemies.add(grpOctopuses);

		grpEnemiesApplyPhysics = new FlxGroup();
		grpEnemiesApplyPhysics.add(grpMushroom);
		grpEnemiesApplyPhysics.add(grpTortoise);
		grpEnemiesApplyPhysics.add(grpBoss);
	}

	public function spawn(aX:Float, aY:Float, aEnemyType:EnemyType):Enemy
	{
		var enemy:Enemy = null;

		switch aEnemyType {
			case EnemyType.MUSHROOM:
				enemy = grpMushroom.recycle(Mushroom);

			case EnemyType.TORTOISE:
				enemy = grpTortoise.recycle(Tortoise);

			case EnemyType.FLOWER:
				enemy = grpFlower.recycle(Flower);
				
			case EnemyType.BOSS:
				enemy = grpBoss.recycle(Boss);
				
			case EnemyType.FISH:
				enemy = grpFishes.recycle(Fish);
				
			case EnemyType.OCTOPUS:
				enemy = grpOctopuses.recycle(Octopus);
		}

		enemy.spawn(aX, aY);

		return enemy;
	}
	
	public function spawn2(enemyToLoad:EnemyToLoad):Enemy
	{	
		return spawn(enemyToLoad.x, enemyToLoad.y, enemyToLoad.enemyType);
	}
}