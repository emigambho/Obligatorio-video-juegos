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
		
		txtGrass = new FlxText(300, 25, 0, "middletext", 16);
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
	
	public function updateHUD():Void
	{
		txtMoney.text = "X " + GGD.coins;
		
		if (GGD.bossLevel){
			txtGrass.text = "Boss: "  + GGD.currentBossLife + "/" + GGD.totalBossLife;
		} else  if(GGD.miniGameLevel){
			txtGrass.text = "Time left: "  +  Math.round(GGD.miniGameTime);
		} else {
			txtGrass.text = "Grass: "  + GGD.currentGrass + "/" + GGD.totalGrass;
		}

		
		txtLifes.text = "Lifes: " + GGD.lifes;		
	}
	
}