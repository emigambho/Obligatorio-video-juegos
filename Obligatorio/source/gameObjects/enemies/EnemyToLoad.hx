package gameObjects.enemies;
import gameObjects.enemies.EnemyFactory.EnemyType;
import interfaces.Enemy.SpawnMode;

class EnemyToLoad 
{
	public var enemyType:EnemyType;
	public var x:Float;
	public var y:Float;	
	public var spawnMode:SpawnMode;
	
	public function new(aEnemyType:EnemyType, aX:Float, aY:Float, aSpawnMode:SpawnMode) 
	{
		enemyType = aEnemyType;
		x = aX;
		y = aY;
		spawnMode = aSpawnMode;
	}
	
}