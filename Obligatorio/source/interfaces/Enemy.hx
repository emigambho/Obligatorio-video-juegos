package interfaces;
import gameObjects.Player;

enum SpawnMode
{
	STATIC;
	WALK_RIGHT;
	WALK_LEFT;
	FLY;
}

interface Enemy 
{
	function spawn(aX : Float, aY : Float, spawnMode:SpawnMode):Void;
	function touchThePlayer(aPlayer: Player):Void;
}