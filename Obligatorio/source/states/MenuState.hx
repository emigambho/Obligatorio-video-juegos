package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class MenuState extends FlxState
{

	private var _btnPlay:FlxButton;
	private var _btnMiniGames:FlxButton;
	private var _btnBoss:FlxButton;
	private var _btnExit:FlxButton;

	override public function create():Void
	{
		super.create();
		
		var bg = new FlxSprite(0, 0, AssetPaths.Mario_Wallpaper_super_mario_bros_5429603_1024_768__jpg);
		add(bg);
		
		_btnPlay = new FlxButton(37, 50, "Play Mario", clickPlay);
		add(_btnPlay);
		
		_btnMiniGames = new FlxButton(37, 80, "Mini Juegos", clickMiniGames);
		add(_btnMiniGames);
		
		_btnBoss = new FlxButton(37,110, "Play vs Boss", clickBoss);
		add(_btnBoss);
		
		_btnExit = new FlxButton(37, 140, "Exit", clickExit);
		add(_btnExit);

		FlxG.camera.bgColor = FlxColor.fromRGB(146, 144, 255);
	}

	private function clickPlay():Void
	{
		FlxG.switchState(new PlayState());
	}

	private function clickMiniGames():Void
	{
		FlxG.switchState(new PlayStateBall());
	}
	
	private function clickBoss():Void
	{
		FlxG.switchState(new BossState());
	}

	private function clickExit():Void
	{
		// EXIT GAME
	}
	
	
	//override public function update(elapsed:Float):Void
	//{
		//super.update(elapsed);
	//}
	
}
