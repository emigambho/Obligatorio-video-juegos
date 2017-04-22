package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;

class PlayStateBall extends FlxState
{

	override public function create():Void
	{
		super.create();

		FlxG.camera.bgColor = FlxColor.WHITE;
	}

}