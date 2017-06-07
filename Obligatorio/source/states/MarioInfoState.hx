package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import GlobalGameData;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import gameObjects.HUD;

class MarioInfoState extends FlxState 
{
	static inline var WAIT_TIME:Float = 1;

	var timer:Float;
	
	override public function create():Void
	{
		super.create();
		
		timer = WAIT_TIME;
		
		GGD.hud = new HUD();
		add(GGD.hud);
		
		showLifes();	
		
		FlxG.camera.bgColor = FlxColor.BLACK;
	}
	
	function showLifes() 
	{
		var mario:FlxSprite = new FlxSprite(115, 112);
		mario.loadGraphic(AssetPaths.mario_icon__png);
		add(mario);
		
		var lifes:FlxText = new FlxText(150, 116, 0, "X         " + GGD.lifes, 8);
		add(lifes);
	}
	
	override public function update(elapsed:Float):Void
	{	
		timer -= elapsed;
		
		if (timer <= 0)
		{
			FlxG.switchState(new PlayStateMario());
		}
	}
	
	override public function destroy():Void
	{
		GGD.clear();
		super.destroy();
	}	
}