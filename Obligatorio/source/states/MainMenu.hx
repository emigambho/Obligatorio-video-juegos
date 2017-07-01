package states;

import flash.system.System;
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

		GGD.playMusic();

		var bg = new FlxSprite(0, 0, AssetPaths.menu_background__png);
		add(bg);

		var btnPlay:FlxButton = new FlxButton(0, 100, "Play Mario", clickPlay);
		setButton(btnPlay);

		var btnMiniGames:FlxButton = new FlxButton(0, 160, "Mini Juegos", clickMiniGames);
		setButton(btnMiniGames);

		var btnBoss:FlxButton = new FlxButton(0, 220, "Play vs Boss", clickBoss);
		setButton(btnBoss);

		var btnExit:FlxButton = new FlxButton(0, 280, "Exit", clickExit);
		setButton(btnExit);

		FlxG.camera.fade(FlxColor.BLACK, .6, true);
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
		GGD.currentLevel = 7;
		FlxG.switchState(new PlayStateMario());
	}

	private function clickExit():Void
	{
		System.exit(0);		
	}

	
	override public function destroy():Void
	{
		FlxG.sound.music.stop();
		super.destroy();
	}	
	
	
}
