package states;


import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;


class MenuState extends FlxState
{

	private var _btnPlay:FlxButton;
	private var _btnBall:FlxButton;
	private var _btnExit:FlxButton;

	override public function create():Void
	{
		super.create();
		
		var bg = new FlxSprite(0, 0, AssetPaths.Mario_Wallpaper_super_mario_bros_5429603_1024_768__jpg);
		add(bg);
		
		_btnPlay = new FlxButton(70, 70, "Play", clickPlay);
		add(_btnPlay);
		
		_btnBall = new FlxButton(70, 100, "Ball", clickBall);
		add(_btnBall);
		
		_btnExit = new FlxButton(70, 130, "Exit", clickExit);
		add(_btnExit);

		FlxG.camera.bgColor = FlxColor.fromRGB(146, 144, 255);
	}

	private function clickPlay():Void
	{
		FlxG.switchState(new PlayState());
	}

	private function clickBall():Void
	{
		FlxG.switchState(new PlayStateBall());
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
