package gameObjects.level;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import gameObjects.Player;

class Door extends FlxSprite 
{
	var isMiniGame:Bool;
	
	public function new(aX:Float, aY:Float, aIsMiniGame:Bool) 
	{
		super(aX, aY);
		
		isMiniGame = aIsMiniGame;
		
		makeGraphic(16, 16);
		alpha = 0;
	}
	
	public function playerTouch(aPlayer:Player)
	{
		if (!isMiniGame)
		{
			// Es una puerta de final de nivel. No es necesario que el player este presionando "Abajo".
			aPlayer.walkToTheExit();
		}
		else if (FlxG.keys.pressed.DOWN)
		{
			trace("ir a mini-juego ...");			
		}
	}
	
}