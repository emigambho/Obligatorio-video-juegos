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
	var txtLevel:FlxText;
	var txtGrass:FlxText;
	
	public function new()
	{
		super();
		
		txtMoney = new FlxText(70, 30, 0, "X 0", 24);
		txtMoney.alignment = LEFT;
		txtMoney.color = FlxColor.WHITE;
		add(txtMoney);
		
		txtGrass = new FlxText(370, 30, 0, "Grass: 0/0", 24);
		txtMoney.alignment = CENTER;
		txtMoney.color = FlxColor.WHITE;
		add(txtGrass);		
		
		txtLevel = new FlxText(775, 30, 0, "Level: 1", 24);
		txtLevel.color = FlxColor.WHITE;
		add(txtLevel);
		
		var sprMoney = new FlxSprite(30, 32, AssetPaths.hud_coin__png);
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
		txtGrass.text = "Grass: "  + GGD.currentGrass + "/" + GGD.totalGrass;
		txtLevel.text = "Level: " + GGD.currentLevel;		
	}
}