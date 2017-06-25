package states;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import GlobalGameData;

class LevelComplete extends FlxSubState 
{
	
	override public function create():Void 
	{
		super.create();
		
		var txt:FlxText = new FlxText(FlxG.width/2 -250, FlxG.height/2 -100, 0, "Level complete!", 64);
		txt.color = FlxColor.WHITE;
		add(txt);
		
		var btnNextLevel:FlxButton = new FlxButton(0, 0, "Next Level", clickNextLevel); 
		btnNextLevel.screenCenter();
		btnNextLevel.y += 150;
		btnNextLevel.label.size = 12;
		btnNextLevel.scale.set(3, 3);
		add(btnNextLevel);		
		
		FlxG.mouse.visible = true;
	}
	
	private function clickNextLevel()
	{
		GGD.nextLevel();
	}	
	
}