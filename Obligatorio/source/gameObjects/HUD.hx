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
	var txtMoney:FlxText;
	var txtGrass:FlxText;
	var txtLifes:FlxText;
	
	public function new()
	{
		super();
		
		txtMoney = new FlxText(70, 25, 0, "X 0", 16);
		txtMoney.color = FlxColor.WHITE;
		add(txtMoney);
		
		txtGrass = new FlxText(300, 25, 0, "Grass: 0/0", 16);
		txtMoney.color = FlxColor.WHITE;
		add(txtGrass);		
		
		txtLifes = new FlxText(600, 25, 0, "Lifes: *", 16);
		txtLifes.color = FlxColor.WHITE;
		add(txtLifes);
		
		var sprMoney = new FlxSprite(40, 27, AssetPaths.hud_coin__png);
		add(sprMoney);
		
		forEach(function(spr:FlxSprite)
		{
			spr.scrollFactor.set(0, 0);
		});
		
		updateHUD();
	}
	
	public function changeColor(txtMoneyColor:FlxColor, txtLevelColor:FlxColor, txtScoreColor:FlxColor):Void
	{
		txtLifes.color = txtLevelColor;
		txtMoney.color = txtMoneyColor;
	}

	public function updateHUD():Void
	{
		txtMoney.text = "X " + GGD.coins;
		txtGrass.text = "Grass: "  + GGD.currentGrass + "/" + GGD.totalGrass;
		txtLifes.text = "Lifes: " + GGD.lifes;		
	}
}