package gameObjects.level;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import gameObjects.Player;

class Flag extends FlxSprite
{
	static inline var Y_FLOOR:Float = 208;
	static inline var DOWN_SPEED:Float = 80;

	var isComingDown:Bool = false;
	var player:Player;

	public function new(aX:Float, aY:Float)
	{
		super(aX, aY);

		loadGraphic(AssetPaths.flag__png, false, 16, 16);

		// La caja de colisión llega hasta el piso, así detecto si el jugador "toca" la bandera.
		setSize(8, Y_FLOOR - y);
		offset.set(8, 0);
	}

	override public function update(elapsed:Float):Void
	{
		if (isComingDown)
		{
			if (y >= Y_FLOOR -32)
			{
				isComingDown = false;
				y = Y_FLOOR -32;
				velocity.y = 0;
				player.walkToTheExit();
			}
		}
		super.update(elapsed);
	}
	
	public function playerGrab(aPlayer:Player):Void
	{
		player = aPlayer;
		velocity.y = DOWN_SPEED;
		isComingDown = true;
		allowCollisions = FlxObject.NONE;
	}

}