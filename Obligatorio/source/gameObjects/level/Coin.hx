package gameObjects.level;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Coin extends FlxSprite
{
	static inline var JUMP_SPEED:Float = 500;
	static inline var GRAVITY:Int = 1700;
	
	var yTarget:Float;	
	
	public function new()
	{
		super(0, 0);

		loadGraphic(AssetPaths.coin__png, true, 16, 16);

		animation.add("idle", [0, 1, 2, 3, 4, 5], 12, true);
		animation.add("jumpInTheAir", [6, 7, 8, 9], 8, true);
	}

	override public function update(elapsed:Float):Void
	{
		if (animation.curAnim.name =="jumpInTheAir" && y > yTarget)
		{
			trace("Mato la moneda");
			// Ya hice el salto y volví a la posición inicial, reciclo la moneda.
			kill();
		}		
		
		super.update(elapsed);
	}	
	
	public function spawn(aX:Float, aY:Float)
	{
		reset(aX, aY);
		
		alpha = 1;
		animation.play("idle");
	}

	public function jumpInTheAir()
	{
		animation.play("jumpInTheAir");
		
		yTarget = y;
		acceleration.y = GRAVITY;
		velocity.y = -JUMP_SPEED;			
	}

	override public function kill():Void
	{
		alive = false;

		if (animation.curAnim.name == "idle")
		{
			// El personaje recogió la moneda, reproduzco una animación.
			FlxTween.tween(this, { alpha: 0, y: y - 16 }, .33, { ease: FlxEase.circOut, onComplete: finishKill });
		}
		else{
			// La moneda está en el aire, no hay animación simplemente la reciclo.
			exists = false;
		}
	}

	private function finishKill(_):Void
	{
		exists = false;
	}

}