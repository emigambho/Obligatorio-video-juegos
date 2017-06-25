package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import GlobalGameData;

class MainMenu extends FlxState
{

	override public function create():Void
	{
		super.create();

		if (FlxG.sound.music == null)
		{
			FlxG.sound.playMusic(AssetPaths.snd_music__mp3, 0.6, true);
		}

		var bg = new FlxSprite(0, 0, AssetPaths.menu_background__jpg);
		add(bg);

		var btnPlay:FlxButton = new FlxButton(200, 100, "Play Mario", clickPlay);
		btnPlay.scale.set(2, 2);
		btnPlay.updateHitbox();
		btnPlay.label.fieldWidth *= 2;
		btnPlay.label.size = 16;
		add(btnPlay);

		var btnLevel0:FlxButton = new FlxButton(300, 300, "Level 0",
		function ()
		{
			GGD.currentLevel = 1;
			FlxG.switchState(new PlayStateMario());
		}
											   );
		add(btnLevel0);

		var btnMiniGames:FlxButton = new FlxButton(200, 200, "Mini Juegos", clickMiniGames);
		btnMiniGames.scale.set(2, 2);
		add(btnMiniGames);

		var btnBoss:FlxButton = new FlxButton(200, 300, "Play vs Boss", clickBoss);
		btnBoss.scale.set(2, 2);
		add(btnBoss);

		var btnExit:FlxButton = new FlxButton(200, 400, "Exit", clickExit);
		btnExit.scale.set(2, 2);
		add(btnExit);

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
