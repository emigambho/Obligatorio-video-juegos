package gameObjects;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import util.GlobalGameData;
using flixel.util.FlxSpriteUtil;


class HUD extends FlxTypedGroup<FlxSprite>
{
	var txtScore:FlxText;
	var txtMoney:FlxText;
	
	var grpTxtPoints:FlxTypedGroup<FlxText>;	

	public function new()
	{
		super();

		//grpTxtPoints = new FlxTypedGroup<FlxText>();
		//add(grpTxtPoints);
		
		txtScore = new FlxText(20, 10, 0, "Score:\n0", 8);
		txtScore.color = FlxColor.BLACK;
		add(txtScore);
		
		txtMoney = new FlxText(100, 12, 0, "X 0", 8);
		txtMoney.alignment = LEFT;
		txtMoney.color = FlxColor.BLACK;
		add(txtMoney);
		
		var sprMoney = new FlxSprite(90, 14, AssetPaths.hud_coin__png);
		add(sprMoney);
		
		forEach(function(spr:FlxSprite)
		{
			spr.scrollFactor.set(0, 0);
		});
	}
	

	public function updateHUD():Void
	{
		txtMoney.text = "X " + GGD.coins;
		txtScore.text = "Score:\n" + GGD.score;
	}
	
	public function showPoints(aX:Float, aY:Float, aPoints:Int)
	{
		//var txtPoints:FlxText = grpTxtPoints.recycle();
		var txtPoints:FlxText = new FlxText(aX, aY, 0, "" +aPoints, 8);
		FlxTween.tween(txtPoints, { alpha: 0, y: aY - 50 }, 1.6, { ease: FlxEase.circOut}); //, onComplete: finishKill });
		
		add(txtPoints);
	}
}