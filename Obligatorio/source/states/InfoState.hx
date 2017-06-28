package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import GlobalGameData;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import gameObjects.HUD;

class InfoState extends FlxState 
{
	static inline var WAIT_TIME:Float = 1.2;

	var timer:Float;
	
	override public function create():Void
	{
		super.create();
		
		timer = WAIT_TIME;
		
		GGD.hud = new HUD();
		add(GGD.hud);
		
		if (GGD.lifes > 0)
		{
			showLifes();	
		}
		else
		{
			showGameOver();
		}		
		
		FlxG.camera.bgColor = FlxColor.BLACK;
	}
	
	function showLifes() 
	{
		var center_x = FlxG.width / 2;
		var center_y = FlxG.height / 2;
		
		var txtLevel:FlxText = new FlxText(center_x, center_y, 0, "Level: " + GGD.currentLevel, 32);
		txtLevel.x -= txtLevel.width / 2;
		txtLevel.y -= (txtLevel.height / 2) +64;
		add(txtLevel);				
		
		var imgMario:FlxSprite = new FlxSprite(center_x, center_y);
		imgMario.loadGraphic(AssetPaths.mario_icon__png);
		imgMario.x -= 96;
		imgMario.y -= imgMario.height/2 -64;
		add(imgMario);
		
		var txtLifes:FlxText = new FlxText(center_x, center_y, 0, "X   " + GGD.lifes, 32);
		txtLifes.y -= txtLifes.height / 2 -64;
		add(txtLifes);
	}
	
	function showGameOver()
	{
		var txtGameOver:FlxText = new FlxText(0, 0, 0, "GAME OVER!", 48);
		txtGameOver.screenCenter();
		add(txtGameOver);		
	}
	
	override public function update(elapsed:Float):Void
	{	
		timer -= elapsed;
		
		if (timer <= 0)
		{
			if (GGD.lifes > 0)
			{
				FlxG.switchState(new PlayStateMario());
			}
			else
			{
				FlxG.switchState(new MainMenu());
			}			
		}
	}
	
	override public function destroy():Void
	{
		GGD.clear();
		super.destroy();
	}	
}