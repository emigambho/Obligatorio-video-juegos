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
		
		var btnLevel2:FlxButton = new FlxButton(130, 50, "Sea level", 
			function () {  
				GGD.levelName = "level_02";
				FlxG.switchState(new PlayStateMario());			
			}
		);
		add(btnLevel2);		
		
		var _btnMiniGames:FlxButton = new FlxButton(37, 80, "Mini Juegos", clickMiniGames);
		add(_btnMiniGames);
		
		var _btnBoss:FlxButton = new FlxButton(37,110, "Play vs Boss", clickBoss);
		add(_btnBoss);
		
		var _btnExit:FlxButton = new FlxButton(37, 140, "Exit", clickExit);
		add(_btnExit);

		FlxG.camera.bgColor = FlxColor.fromRGB(146, 144, 255);
	}

	private function clickPlay():Void
	{
		GGD.levelName = "level_01";
		FlxG.switchState(new PlayStateMario());
	}

	private function clickMiniGames():Void
	{
		FlxG.switchState(new PlayStateMiniGames());
	}
	
	private function clickBoss():Void
	{
		GGD.levelName = "level_boss";
		FlxG.switchState(new PlayStateMario());
	}

	private function clickExit():Void
	{
		// EXIT GAME
	}
	
	
}
