package interfaces;
import gameObjects.Player;

interface Enemy 
{
	function touchThePlayer(aPlayer: Player):Void;
	function spawn(aX : Float, aY : Float):Void;
}