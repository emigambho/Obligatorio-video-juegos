package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import GlobalGameData;

class MenuState extends FlxState
{
	
	override public function create():Void
	{
		super.create();
		
		var bg = new FlxSprite(0, 0, AssetPaths.menu_background__jpg);
		add(bg);
		
		var _btnPlay:FlxButton = new FlxButton(37, 50, "Play Mario", clickPlay);
		add(_btnPlay);
		
		var btnLevel0:FlxButton = new FlxButton(130, 50, "Level 0", 
			function () {  
				GGD.currentLevel = 0;
				FlxG.switchState(new PlayStateMario());			
			}
		);
		add(btnLevel0);
		
		var btnLevel2:FlxButton = new FlxButton(130, 80, "Level 2", 
			function () {  
				GGD.currentLevel = 2;
				FlxG.switchState(new PlayStateMario());
			}
		);
		add(btnLevel2);
		
		var btnLevel3:FlxButton = new FlxButton(130, 110, "Level 3", 
			function () {  
				GGD.currentLevel = 3;
				FlxG.switchState(new PlayStateMario());			
			}
		);
		add(btnLevel3);		
		
		var _btnMiniGames:FlxButton = new FlxButton(37, 80, "Mini Juegos", clickMiniGames);
		add(_btnMiniGames);
		
		var _btnBoss:FlxButton = new FlxButton(37,110, "Play vs Boss", clickBoss);
		add(_btnBoss);
		
		var _btnExit:FlxButton = new FlxButton(37, 140, "Exit", clickExit);
		add(_btnExit);

		FlxG.camera.fade(FlxColor.BLACK, .6, true);
		FlxG.mouse.visible = true;
	}

	private function clickPlay():Void
	{
		GGD.newGame();		
	}

	private function clickMiniGames():Void
	{
		FlxG.switchState(new PlayStateMiniGames());
	}
	
	private function clickBoss():Void
	{
		GGD.currentLevel = 4;
		FlxG.switchState(new PlayStateMario());
	}

	private function clickExit():Void
	{
		// EXIT GAME
	}
	
	
}
