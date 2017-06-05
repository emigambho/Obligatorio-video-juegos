package interfaces;

import gameObjects.Player;

interface Projectile 
{
	function shoot(aX : Float, aY : Float, directionX: Float, directionY:Float):Void;
	function touchThePlayer(aPlayer: Player):Void;	
}