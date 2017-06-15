package states;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import GlobalGameData;

class WinSubState extends FlxSubState 
{

	override public function create():Void 
	{
		super.create();
		
		var txtScore:FlxText = new FlxText(FlxG.width/2 -70 , FlxG.height/2 -55, 0, "You Win!", 32);
		txtScore.color = FlxColor.WHITE;
		add(txtScore);
		
		var quitBtn:FlxButton = new FlxButton(0, 0, "Quit", clickQuit); 
		quitBtn.screenCenter();
		quitBtn.y += 60;
		add(quitBtn);		
		
		FlxG.mouse.visible = true;
	}
	
	private function clickQuit()
	{
		GGD.goToMainMenu();
	}	
}