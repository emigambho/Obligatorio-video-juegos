package interfaces;
import gameObjects.Player;

interface Enemy 
{
	function spawn(aX : Float, aY : Float):Void;
	function touchThePlayer(aPlayer: Player):Void;
}