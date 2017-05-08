package gameObjects.enemies;
import enums.EnemyType;
import flixel.group.FlxGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import interfaces.Enemy;


class EnemyFactory 
{
	var grpMushroom:FlxTypedGroup<Mushroom>;
	var grpTortoise:FlxTypedGroup<Tortoise>;
	//var grpFlower:FlxTypedGroup<Flower>;	
	
	public var enemiesGroup:FlxGroup;
	
	public function new(aState:FlxGroup) 
	{
		grpMushroom = new FlxTypedGroup<Mushroom>();
		grpTortoise = new FlxTypedGroup<Tortoise>();
		//grpFlower = new FlxTypedGroup<Flower>();
		
		aState.add(grpMushroom);
		aState.add(grpTortoise);
		//aState.add(grpFlower);
		
		enemiesGroup = new FlxGroup();
		enemiesGroup.add(grpMushroom);
		enemiesGroup.add(grpTortoise);
		//enemiesGroup.add(grpFlower);
	}
	
	public function spawn(aX:Float, aY:Float, enemyType:EnemyType):Void
	{
		var enemy:Enemy = null;
		
		switch enemyType
		{
			case EnemyType.MUSHROOM:
				enemy = grpMushroom.recycle(Mushroom);
				
			case EnemyType.TORTOISE:
				enemy = grpTortoise.recycle(Tortoise);

			case EnemyType.FLOWER:
				//enemy = grpFlower.recycle(Flower);
		}
		
		enemy.spawn(aX, aY);		
	}	
}