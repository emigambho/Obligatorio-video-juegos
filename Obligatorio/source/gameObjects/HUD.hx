package gameObjects;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import GlobalGameData;
using flixel.util.FlxSpriteUtil;


class HUD extends FlxTypedGroup<FlxSprite>
{
	var txtScore:FlxText;
	var txtMoney:FlxText;
	var txtLevel:FlxText;
	
	public function new()
	{
		super();
		
		txtScore = new FlxText(20, 10, 0, "Score:\n0", 8);
		txtScore.color = FlxColor.WHITE;
		add(txtScore);
		
		txtMoney = new FlxText(150, 12, 0, "X 0", 8);
		txtMoney.alignment = LEFT;
		txtMoney.color = FlxColor.WHITE;
		add(txtMoney);
		
		txtLevel = new FlxText(250, 12, 0, "Level: 1", 8);
		txtLevel.color = FlxColor.WHITE;
		add(txtLevel);
		
		var sprMoney = new FlxSprite(140, 14, AssetPaths.hud_coin__png);
		add(sprMoney);
		
		forEach(function(spr:FlxSprite)
		{
			spr.scrollFactor.set(0, 0);
		});
		
		updateHUD();
	}
	

	public function updateHUD():Void
	{
		txtMoney.text = "X " + GGD.coins;
		txtScore.text = "Score:\n" + GGD.score;
		txtLevel.text = "Level: " + GGD.currentLevel;
	}
	
	public function showPoints(aX:Float, aY:Float, aPoints:Int)
	{
		var txtPoints:FlxText = cast(this.recycle(FlxText), FlxText);
		
		txtPoints.setPosition(aX, aY);
		txtPoints.alpha = 1;
		txtPoints.size = 8;
		txtPoints.text = Std.string(aPoints);
		
		// No se están destruyendo, revisar!
		FlxTween.tween(txtPoints, { alpha: 0, y: aY - 50 }, 1.6, { ease: FlxEase.circOut}); //, onComplete: finishKill });
	}
}