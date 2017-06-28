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
		
		var center_y = FlxG.height / 2;
		
		var resumeBtn:FlxButton = new FlxButton(0, center_y-48, "Resume", clickResume);
		setButton(resumeBtn);
		
		var quitBtn:FlxButton = new FlxButton(0, center_y+48, "Quit", clickQuit);
		setButton(quitBtn);
		
		FlxG.mouse.visible = true;
	}
	
	function setButton(button:FlxButton):Void
	{
		button.scale.set(2, 2);
		button.updateHitbox();
		button.x = FlxG.width / 2 - button.width / 2;
		button.label.offset.y = -5;
		button.label.fieldWidth *= 2;
		button.label.size = 16;
		add(button);
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