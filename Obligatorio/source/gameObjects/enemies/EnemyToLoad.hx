package gameObjects.enemies;
import gameObjects.enemies.EnemyFactory.EnemyType;

class EnemyToLoad 
{
	public var enemyType:EnemyType;
	public var x:Float;
	public var y:Float;	
	
	public function new(aEnemyType:EnemyType, aX:Float, aY:Float) 
	{
		enemyType = aEnemyType;
		x = aX;
		y = aY;
	}
	
}