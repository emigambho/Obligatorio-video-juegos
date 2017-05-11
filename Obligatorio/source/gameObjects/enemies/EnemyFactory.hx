package gameObjects.enemies;

import flixel.group.FlxGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import interfaces.Enemy;

enum EnemyType
{
	MUSHROOM;
	TORTOISE;
	FLOWER;
}

class EnemyFactory
{
	var grpMushroom:FlxTypedGroup<Mushroom>;
	var grpTortoise:FlxTypedGroup<Tortoise>;
	var grpFlower:FlxTypedGroup<Flower>;

	public var grpEnemies:FlxGroup;
	public var grpEnemiesApplyPhysics:FlxGroup;

	public function new(aState:FlxGroup)
	{
		grpMushroom = new FlxTypedGroup<Mushroom>();
		grpTortoise = new FlxTypedGroup<Tortoise>();
		grpFlower = new FlxTypedGroup<Flower>();

		aState.add(grpMushroom);
		aState.add(grpTortoise);
		aState.add(grpFlower);

		grpEnemies = new FlxGroup();
		grpEnemies.add(grpMushroom);
		grpEnemies.add(grpTortoise);
		grpEnemies.add(grpFlower);

		grpEnemiesApplyPhysics = new FlxGroup();
		grpEnemiesApplyPhysics.add(grpMushroom);
		grpEnemiesApplyPhysics.add(grpTortoise);
	}

	public function spawn(aX:Float, aY:Float, enemyType:EnemyType):Enemy
	{
		var enemy:Enemy = null;

		switch enemyType
	{
		case EnemyType.MUSHROOM:
			enemy = grpMushroom.recycle(Mushroom);

			case EnemyType.TORTOISE:
				enemy = grpTortoise.recycle(Tortoise);

			case EnemyType.FLOWER:
				enemy = grpFlower.recycle(Flower);
		}

		enemy.spawn(aX, aY);

		return enemy;
	}
}