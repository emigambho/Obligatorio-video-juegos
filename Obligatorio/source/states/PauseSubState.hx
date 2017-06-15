package states;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import GlobalGameData;

class PauseSubState extends FlxSubState 
{

	override public function create():Void 
	{
		super.create();
		
		var resumeBtn:FlxButton = new FlxButton(0, 0, "Resume", clickResume);
		resumeBtn.screenCenter();
		resumeBtn.y -= 25;
		add(resumeBtn);
		
		var quitBtn:FlxButton = new FlxButton(0, 0, "Quit", clickQuit);
		quitBtn.screenCenter();
		quitBtn.y += 25;
		add(quitBtn);		
		
		FlxG.mouse.visible = true;
	}
	
	private function clickResume() 
	{
		FlxG.mouse.visible = false;
		close();
	}
	
	private function clickQuit()
	{
		GGD.goToMainMenu();
	}
	
}