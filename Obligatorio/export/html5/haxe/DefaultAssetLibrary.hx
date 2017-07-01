package;


import haxe.Timer;
import haxe.Unserializer;
import lime.app.Future;
import lime.app.Preloader;
import lime.app.Promise;
import lime.audio.AudioSource;
import lime.audio.openal.AL;
import lime.audio.AudioBuffer;
import lime.graphics.Image;
import lime.net.HTTPRequest;
import lime.system.CFFI;
import lime.text.Font;
import lime.utils.Bytes;
import lime.utils.UInt8Array;
import lime.Assets;

#if sys
import sys.FileSystem;
#end

#if flash
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.media.Sound;
import flash.net.URLLoader;
import flash.net.URLRequest;
#end


class DefaultAssetLibrary extends AssetLibrary {
	
	
	public var className (default, null) = new Map <String, Dynamic> ();
	public var path (default, null) = new Map <String, String> ();
	public var type (default, null) = new Map <String, AssetType> ();
	
	private var lastModified:Float;
	private var timer:Timer;
	
	
	public function new () {
		
		super ();
		
		#if (openfl && !flash)
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		
		
		#end
		
		#if flash
		
		className.set ("assets/data/level_0.tmx", __ASSET__assets_data_level_0_tmx);
		type.set ("assets/data/level_0.tmx", AssetType.TEXT);
		className.set ("assets/data/level_01.tmx", __ASSET__assets_data_level_01_tmx);
		type.set ("assets/data/level_01.tmx", AssetType.TEXT);
		className.set ("assets/data/level_02.tmx", __ASSET__assets_data_level_02_tmx);
		type.set ("assets/data/level_02.tmx", AssetType.TEXT);
		className.set ("assets/data/level_03.tmx", __ASSET__assets_data_level_03_tmx);
		type.set ("assets/data/level_03.tmx", AssetType.TEXT);
		className.set ("assets/data/level_04.tmx", __ASSET__assets_data_level_04_tmx);
		type.set ("assets/data/level_04.tmx", AssetType.TEXT);
		className.set ("assets/data/level_05.tmx", __ASSET__assets_data_level_05_tmx);
		type.set ("assets/data/level_05.tmx", AssetType.TEXT);
		className.set ("assets/data/level_06.tmx", __ASSET__assets_data_level_06_tmx);
		type.set ("assets/data/level_06.tmx", AssetType.TEXT);
		className.set ("assets/data/level_07.tmx", __ASSET__assets_data_level_07_tmx);
		type.set ("assets/data/level_07.tmx", AssetType.TEXT);
		className.set ("assets/data/mini_game_1.tmx", __ASSET__assets_data_mini_game_1_tmx);
		type.set ("assets/data/mini_game_1.tmx", AssetType.TEXT);
		className.set ("assets/data/mini_game_2.tmx", __ASSET__assets_data_mini_game_2_tmx);
		type.set ("assets/data/mini_game_2.tmx", AssetType.TEXT);
		className.set ("assets/data/mini_game_3.tmx", __ASSET__assets_data_mini_game_3_tmx);
		type.set ("assets/data/mini_game_3.tmx", AssetType.TEXT);
		className.set ("assets/data/tilesheet2.tsx", __ASSET__assets_data_tilesheet2_tsx);
		type.set ("assets/data/tilesheet2.tsx", AssetType.TEXT);
		className.set ("assets/data/Tilesheet3.tsx", __ASSET__assets_data_tilesheet3_tsx);
		type.set ("assets/data/Tilesheet3.tsx", AssetType.TEXT);
		className.set ("assets/data/_borrar/level_0xx.tmx", __ASSET__assets_data__borrar_level_0xx_tmx);
		type.set ("assets/data/_borrar/level_0xx.tmx", AssetType.TEXT);
		className.set ("assets/data/_borrar/level_1.tmx", __ASSET__assets_data__borrar_level_1_tmx);
		type.set ("assets/data/_borrar/level_1.tmx", AssetType.TEXT);
		className.set ("assets/data/_borrar/level_2.tmx", __ASSET__assets_data__borrar_level_2_tmx);
		type.set ("assets/data/_borrar/level_2.tmx", AssetType.TEXT);
		className.set ("assets/data/_borrar/level_3.tmx", __ASSET__assets_data__borrar_level_3_tmx);
		type.set ("assets/data/_borrar/level_3.tmx", AssetType.TEXT);
		className.set ("assets/images/Ball.png", __ASSET__assets_images_ball_png);
		type.set ("assets/images/Ball.png", AssetType.IMAGE);
		className.set ("assets/images/bonus.png", __ASSET__assets_images_bonus_png);
		type.set ("assets/images/bonus.png", AssetType.IMAGE);
		className.set ("assets/images/boss.png", __ASSET__assets_images_boss_png);
		type.set ("assets/images/boss.png", AssetType.IMAGE);
		className.set ("assets/images/brick.png", __ASSET__assets_images_brick_png);
		type.set ("assets/images/brick.png", AssetType.IMAGE);
		className.set ("assets/images/canon.png", __ASSET__assets_images_canon_png);
		type.set ("assets/images/canon.png", AssetType.IMAGE);
		className.set ("assets/images/canonball.png", __ASSET__assets_images_canonball_png);
		type.set ("assets/images/canonball.png", AssetType.IMAGE);
		className.set ("assets/images/coin.png", __ASSET__assets_images_coin_png);
		type.set ("assets/images/coin.png", AssetType.IMAGE);
		className.set ("assets/images/fireball.png", __ASSET__assets_images_fireball_png);
		type.set ("assets/images/fireball.png", AssetType.IMAGE);
		className.set ("assets/images/flower.png", __ASSET__assets_images_flower_png);
		type.set ("assets/images/flower.png", AssetType.IMAGE);
		className.set ("assets/images/hammer.png", __ASSET__assets_images_hammer_png);
		type.set ("assets/images/hammer.png", AssetType.IMAGE);
		className.set ("assets/images/hud_coin.png", __ASSET__assets_images_hud_coin_png);
		type.set ("assets/images/hud_coin.png", AssetType.IMAGE);
		className.set ("assets/images/lava.png", __ASSET__assets_images_lava_png);
		type.set ("assets/images/lava.png", AssetType.IMAGE);
		className.set ("assets/images/mario_icon.png", __ASSET__assets_images_mario_icon_png);
		type.set ("assets/images/mario_icon.png", AssetType.IMAGE);
		className.set ("assets/images/menu_background.png", __ASSET__assets_images_menu_background_png);
		type.set ("assets/images/menu_background.png", AssetType.IMAGE);
		className.set ("assets/images/mushroom.png", __ASSET__assets_images_mushroom_png);
		type.set ("assets/images/mushroom.png", AssetType.IMAGE);
		className.set ("assets/images/player.png", __ASSET__assets_images_player_png);
		type.set ("assets/images/player.png", AssetType.IMAGE);
		className.set ("assets/images/powerupLife.png", __ASSET__assets_images_poweruplife_png);
		type.set ("assets/images/powerupLife.png", AssetType.IMAGE);
		className.set ("assets/images/spark.png", __ASSET__assets_images_spark_png);
		type.set ("assets/images/spark.png", AssetType.IMAGE);
		className.set ("assets/images/Tiled_32x32.png", __ASSET__assets_images_tiled_32x32_png);
		type.set ("assets/images/Tiled_32x32.png", AssetType.IMAGE);
		className.set ("assets/images/tilesheet.png", __ASSET__assets_images_tilesheet_png);
		type.set ("assets/images/tilesheet.png", AssetType.IMAGE);
		className.set ("assets/images/tilesheet2.png", __ASSET__assets_images_tilesheet2_png);
		type.set ("assets/images/tilesheet2.png", AssetType.IMAGE);
		className.set ("assets/images/tortoise.png", __ASSET__assets_images_tortoise_png);
		type.set ("assets/images/tortoise.png", AssetType.IMAGE);
		className.set ("assets/images/tortoise_hammer.png", __ASSET__assets_images_tortoise_hammer_png);
		type.set ("assets/images/tortoise_hammer.png", AssetType.IMAGE);
		className.set ("assets/images/Trees1.png", __ASSET__assets_images_trees1_png);
		type.set ("assets/images/Trees1.png", AssetType.IMAGE);
		className.set ("assets/images/Trees2.png", __ASSET__assets_images_trees2_png);
		type.set ("assets/images/Trees2.png", AssetType.IMAGE);
		className.set ("assets/images/Trees3.png", __ASSET__assets_images_trees3_png);
		type.set ("assets/images/Trees3.png", AssetType.IMAGE);
		className.set ("assets/images/Trees4.png", __ASSET__assets_images_trees4_png);
		type.set ("assets/images/Trees4.png", AssetType.IMAGE);
		className.set ("assets/sounds/snd_bump.wav", __ASSET__assets_sounds_snd_bump_wav);
		type.set ("assets/sounds/snd_bump.wav", AssetType.SOUND);
		className.set ("assets/sounds/snd_coin.wav", __ASSET__assets_sounds_snd_coin_wav);
		type.set ("assets/sounds/snd_coin.wav", AssetType.SOUND);
		className.set ("assets/sounds/snd_game_over.wav", __ASSET__assets_sounds_snd_game_over_wav);
		type.set ("assets/sounds/snd_game_over.wav", AssetType.SOUND);
		className.set ("assets/sounds/snd_hurt_boss.wav", __ASSET__assets_sounds_snd_hurt_boss_wav);
		type.set ("assets/sounds/snd_hurt_boss.wav", AssetType.SOUND);
		className.set ("assets/sounds/snd_hurt_boss2.aiff", __ASSET__assets_sounds_snd_hurt_boss2_aiff);
		type.set ("assets/sounds/snd_hurt_boss2.aiff", AssetType.BINARY);
		className.set ("assets/sounds/snd_jump_small.wav", __ASSET__assets_sounds_snd_jump_small_wav);
		type.set ("assets/sounds/snd_jump_small.wav", AssetType.SOUND);
		className.set ("assets/sounds/snd_jump_super.wav", __ASSET__assets_sounds_snd_jump_super_wav);
		type.set ("assets/sounds/snd_jump_super.wav", AssetType.SOUND);
		className.set ("assets/sounds/snd_kill_boss.wav", __ASSET__assets_sounds_snd_kill_boss_wav);
		type.set ("assets/sounds/snd_kill_boss.wav", AssetType.SOUND);
		className.set ("assets/sounds/snd_level_complete.wav", __ASSET__assets_sounds_snd_level_complete_wav);
		type.set ("assets/sounds/snd_level_complete.wav", AssetType.SOUND);
		className.set ("assets/sounds/snd_life.wav", __ASSET__assets_sounds_snd_life_wav);
		type.set ("assets/sounds/snd_life.wav", AssetType.SOUND);
		className.set ("assets/sounds/snd_life_appears.wav", __ASSET__assets_sounds_snd_life_appears_wav);
		type.set ("assets/sounds/snd_life_appears.wav", AssetType.SOUND);
		className.set ("assets/sounds/snd_mario_die.wav", __ASSET__assets_sounds_snd_mario_die_wav);
		type.set ("assets/sounds/snd_mario_die.wav", AssetType.SOUND);
		className.set ("assets/sounds/snd_music.mp3", __ASSET__assets_sounds_snd_music_mp3);
		type.set ("assets/sounds/snd_music.mp3", AssetType.MUSIC);
		className.set ("assets/sounds/snd_stomp.wav", __ASSET__assets_sounds_snd_stomp_wav);
		type.set ("assets/sounds/snd_stomp.wav", AssetType.SOUND);
		className.set ("assets/sounds/snd_tortoise_kick.wav", __ASSET__assets_sounds_snd_tortoise_kick_wav);
		type.set ("assets/sounds/snd_tortoise_kick.wav", AssetType.SOUND);
		className.set ("flixel/sounds/beep.ogg", __ASSET__flixel_sounds_beep_ogg);
		type.set ("flixel/sounds/beep.ogg", AssetType.SOUND);
		className.set ("flixel/sounds/flixel.ogg", __ASSET__flixel_sounds_flixel_ogg);
		type.set ("flixel/sounds/flixel.ogg", AssetType.SOUND);
		className.set ("flixel/fonts/nokiafc22.ttf", __ASSET__flixel_fonts_nokiafc22_ttf);
		type.set ("flixel/fonts/nokiafc22.ttf", AssetType.FONT);
		className.set ("flixel/fonts/monsterrat.ttf", __ASSET__flixel_fonts_monsterrat_ttf);
		type.set ("flixel/fonts/monsterrat.ttf", AssetType.FONT);
		className.set ("flixel/images/ui/button.png", __ASSET__flixel_images_ui_button_png);
		type.set ("flixel/images/ui/button.png", AssetType.IMAGE);
		className.set ("flixel/images/logo/default.png", __ASSET__flixel_images_logo_default_png);
		type.set ("flixel/images/logo/default.png", AssetType.IMAGE);
		
		
		#elseif html5
		
		var id;
		id = "assets/data/level_0.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/level_01.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/level_02.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/level_03.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/level_04.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/level_05.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/level_06.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/level_07.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/mini_game_1.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/mini_game_2.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/mini_game_3.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/tilesheet2.tsx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/Tilesheet3.tsx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/_borrar/level_0xx.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/_borrar/level_1.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/_borrar/level_2.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/_borrar/level_3.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/images/Ball.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/bonus.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/boss.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/brick.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/canon.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/canonball.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/coin.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/fireball.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/flower.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/hammer.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/hud_coin.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/lava.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/mario_icon.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/menu_background.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/mushroom.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/player.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/powerupLife.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/spark.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Tiled_32x32.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tilesheet.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tilesheet2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tortoise.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tortoise_hammer.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Trees1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Trees2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Trees3.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Trees4.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/sounds/snd_bump.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/snd_coin.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/snd_game_over.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/snd_hurt_boss.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/snd_hurt_boss2.aiff";
		path.set (id, id);
		
		type.set (id, AssetType.BINARY);
		id = "assets/sounds/snd_jump_small.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/snd_jump_super.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/snd_kill_boss.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/snd_level_complete.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/snd_life.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/snd_life_appears.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/snd_mario_die.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/snd_music.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "assets/sounds/snd_stomp.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/snd_tortoise_kick.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "flixel/sounds/beep.ogg";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "flixel/sounds/flixel.ogg";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "flixel/fonts/nokiafc22.ttf";
		className.set (id, __ASSET__flixel_fonts_nokiafc22_ttf);
		
		type.set (id, AssetType.FONT);
		id = "flixel/fonts/monsterrat.ttf";
		className.set (id, __ASSET__flixel_fonts_monsterrat_ttf);
		
		type.set (id, AssetType.FONT);
		id = "flixel/images/ui/button.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/images/logo/default.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		
		
		var assetsPrefix = null;
		if (ApplicationMain.config != null && Reflect.hasField (ApplicationMain.config, "assetsPrefix")) {
			assetsPrefix = ApplicationMain.config.assetsPrefix;
		}
		if (assetsPrefix != null) {
			for (k in path.keys()) {
				path.set(k, assetsPrefix + path[k]);
			}
		}
		
		#else
		
		#if (windows || mac || linux)
		
		var useManifest = false;
		
		className.set ("assets/data/level_0.tmx", __ASSET__assets_data_level_0_tmx);
		type.set ("assets/data/level_0.tmx", AssetType.TEXT);
		
		className.set ("assets/data/level_01.tmx", __ASSET__assets_data_level_01_tmx);
		type.set ("assets/data/level_01.tmx", AssetType.TEXT);
		
		className.set ("assets/data/level_02.tmx", __ASSET__assets_data_level_02_tmx);
		type.set ("assets/data/level_02.tmx", AssetType.TEXT);
		
		className.set ("assets/data/level_03.tmx", __ASSET__assets_data_level_03_tmx);
		type.set ("assets/data/level_03.tmx", AssetType.TEXT);
		
		className.set ("assets/data/level_04.tmx", __ASSET__assets_data_level_04_tmx);
		type.set ("assets/data/level_04.tmx", AssetType.TEXT);
		
		className.set ("assets/data/level_05.tmx", __ASSET__assets_data_level_05_tmx);
		type.set ("assets/data/level_05.tmx", AssetType.TEXT);
		
		className.set ("assets/data/level_06.tmx", __ASSET__assets_data_level_06_tmx);
		type.set ("assets/data/level_06.tmx", AssetType.TEXT);
		
		className.set ("assets/data/level_07.tmx", __ASSET__assets_data_level_07_tmx);
		type.set ("assets/data/level_07.tmx", AssetType.TEXT);
		
		className.set ("assets/data/mini_game_1.tmx", __ASSET__assets_data_mini_game_1_tmx);
		type.set ("assets/data/mini_game_1.tmx", AssetType.TEXT);
		
		className.set ("assets/data/mini_game_2.tmx", __ASSET__assets_data_mini_game_2_tmx);
		type.set ("assets/data/mini_game_2.tmx", AssetType.TEXT);
		
		className.set ("assets/data/mini_game_3.tmx", __ASSET__assets_data_mini_game_3_tmx);
		type.set ("assets/data/mini_game_3.tmx", AssetType.TEXT);
		
		className.set ("assets/data/tilesheet2.tsx", __ASSET__assets_data_tilesheet2_tsx);
		type.set ("assets/data/tilesheet2.tsx", AssetType.TEXT);
		
		className.set ("assets/data/Tilesheet3.tsx", __ASSET__assets_data_tilesheet3_tsx);
		type.set ("assets/data/Tilesheet3.tsx", AssetType.TEXT);
		
		className.set ("assets/data/_borrar/level_0xx.tmx", __ASSET__assets_data__borrar_level_0xx_tmx);
		type.set ("assets/data/_borrar/level_0xx.tmx", AssetType.TEXT);
		
		className.set ("assets/data/_borrar/level_1.tmx", __ASSET__assets_data__borrar_level_1_tmx);
		type.set ("assets/data/_borrar/level_1.tmx", AssetType.TEXT);
		
		className.set ("assets/data/_borrar/level_2.tmx", __ASSET__assets_data__borrar_level_2_tmx);
		type.set ("assets/data/_borrar/level_2.tmx", AssetType.TEXT);
		
		className.set ("assets/data/_borrar/level_3.tmx", __ASSET__assets_data__borrar_level_3_tmx);
		type.set ("assets/data/_borrar/level_3.tmx", AssetType.TEXT);
		
		className.set ("assets/images/Ball.png", __ASSET__assets_images_ball_png);
		type.set ("assets/images/Ball.png", AssetType.IMAGE);
		
		className.set ("assets/images/bonus.png", __ASSET__assets_images_bonus_png);
		type.set ("assets/images/bonus.png", AssetType.IMAGE);
		
		className.set ("assets/images/boss.png", __ASSET__assets_images_boss_png);
		type.set ("assets/images/boss.png", AssetType.IMAGE);
		
		className.set ("assets/images/brick.png", __ASSET__assets_images_brick_png);
		type.set ("assets/images/brick.png", AssetType.IMAGE);
		
		className.set ("assets/images/canon.png", __ASSET__assets_images_canon_png);
		type.set ("assets/images/canon.png", AssetType.IMAGE);
		
		className.set ("assets/images/canonball.png", __ASSET__assets_images_canonball_png);
		type.set ("assets/images/canonball.png", AssetType.IMAGE);
		
		className.set ("assets/images/coin.png", __ASSET__assets_images_coin_png);
		type.set ("assets/images/coin.png", AssetType.IMAGE);
		
		className.set ("assets/images/fireball.png", __ASSET__assets_images_fireball_png);
		type.set ("assets/images/fireball.png", AssetType.IMAGE);
		
		className.set ("assets/images/flower.png", __ASSET__assets_images_flower_png);
		type.set ("assets/images/flower.png", AssetType.IMAGE);
		
		className.set ("assets/images/hammer.png", __ASSET__assets_images_hammer_png);
		type.set ("assets/images/hammer.png", AssetType.IMAGE);
		
		className.set ("assets/images/hud_coin.png", __ASSET__assets_images_hud_coin_png);
		type.set ("assets/images/hud_coin.png", AssetType.IMAGE);
		
		className.set ("assets/images/lava.png", __ASSET__assets_images_lava_png);
		type.set ("assets/images/lava.png", AssetType.IMAGE);
		
		className.set ("assets/images/mario_icon.png", __ASSET__assets_images_mario_icon_png);
		type.set ("assets/images/mario_icon.png", AssetType.IMAGE);
		
		className.set ("assets/images/menu_background.png", __ASSET__assets_images_menu_background_png);
		type.set ("assets/images/menu_background.png", AssetType.IMAGE);
		
		className.set ("assets/images/mushroom.png", __ASSET__assets_images_mushroom_png);
		type.set ("assets/images/mushroom.png", AssetType.IMAGE);
		
		className.set ("assets/images/player.png", __ASSET__assets_images_player_png);
		type.set ("assets/images/player.png", AssetType.IMAGE);
		
		className.set ("assets/images/powerupLife.png", __ASSET__assets_images_poweruplife_png);
		type.set ("assets/images/powerupLife.png", AssetType.IMAGE);
		
		className.set ("assets/images/spark.png", __ASSET__assets_images_spark_png);
		type.set ("assets/images/spark.png", AssetType.IMAGE);
		
		className.set ("assets/images/Tiled_32x32.png", __ASSET__assets_images_tiled_32x32_png);
		type.set ("assets/images/Tiled_32x32.png", AssetType.IMAGE);
		
		className.set ("assets/images/tilesheet.png", __ASSET__assets_images_tilesheet_png);
		type.set ("assets/images/tilesheet.png", AssetType.IMAGE);
		
		className.set ("assets/images/tilesheet2.png", __ASSET__assets_images_tilesheet2_png);
		type.set ("assets/images/tilesheet2.png", AssetType.IMAGE);
		
		className.set ("assets/images/tortoise.png", __ASSET__assets_images_tortoise_png);
		type.set ("assets/images/tortoise.png", AssetType.IMAGE);
		
		className.set ("assets/images/tortoise_hammer.png", __ASSET__assets_images_tortoise_hammer_png);
		type.set ("assets/images/tortoise_hammer.png", AssetType.IMAGE);
		
		className.set ("assets/images/Trees1.png", __ASSET__assets_images_trees1_png);
		type.set ("assets/images/Trees1.png", AssetType.IMAGE);
		
		className.set ("assets/images/Trees2.png", __ASSET__assets_images_trees2_png);
		type.set ("assets/images/Trees2.png", AssetType.IMAGE);
		
		className.set ("assets/images/Trees3.png", __ASSET__assets_images_trees3_png);
		type.set ("assets/images/Trees3.png", AssetType.IMAGE);
		
		className.set ("assets/images/Trees4.png", __ASSET__assets_images_trees4_png);
		type.set ("assets/images/Trees4.png", AssetType.IMAGE);
		
		className.set ("assets/sounds/snd_bump.wav", __ASSET__assets_sounds_snd_bump_wav);
		type.set ("assets/sounds/snd_bump.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/snd_coin.wav", __ASSET__assets_sounds_snd_coin_wav);
		type.set ("assets/sounds/snd_coin.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/snd_game_over.wav", __ASSET__assets_sounds_snd_game_over_wav);
		type.set ("assets/sounds/snd_game_over.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/snd_hurt_boss.wav", __ASSET__assets_sounds_snd_hurt_boss_wav);
		type.set ("assets/sounds/snd_hurt_boss.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/snd_hurt_boss2.aiff", __ASSET__assets_sounds_snd_hurt_boss2_aiff);
		type.set ("assets/sounds/snd_hurt_boss2.aiff", AssetType.BINARY);
		
		className.set ("assets/sounds/snd_jump_small.wav", __ASSET__assets_sounds_snd_jump_small_wav);
		type.set ("assets/sounds/snd_jump_small.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/snd_jump_super.wav", __ASSET__assets_sounds_snd_jump_super_wav);
		type.set ("assets/sounds/snd_jump_super.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/snd_kill_boss.wav", __ASSET__assets_sounds_snd_kill_boss_wav);
		type.set ("assets/sounds/snd_kill_boss.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/snd_level_complete.wav", __ASSET__assets_sounds_snd_level_complete_wav);
		type.set ("assets/sounds/snd_level_complete.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/snd_life.wav", __ASSET__assets_sounds_snd_life_wav);
		type.set ("assets/sounds/snd_life.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/snd_life_appears.wav", __ASSET__assets_sounds_snd_life_appears_wav);
		type.set ("assets/sounds/snd_life_appears.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/snd_mario_die.wav", __ASSET__assets_sounds_snd_mario_die_wav);
		type.set ("assets/sounds/snd_mario_die.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/snd_music.mp3", __ASSET__assets_sounds_snd_music_mp3);
		type.set ("assets/sounds/snd_music.mp3", AssetType.MUSIC);
		
		className.set ("assets/sounds/snd_stomp.wav", __ASSET__assets_sounds_snd_stomp_wav);
		type.set ("assets/sounds/snd_stomp.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/snd_tortoise_kick.wav", __ASSET__assets_sounds_snd_tortoise_kick_wav);
		type.set ("assets/sounds/snd_tortoise_kick.wav", AssetType.SOUND);
		
		className.set ("flixel/sounds/beep.ogg", __ASSET__flixel_sounds_beep_ogg);
		type.set ("flixel/sounds/beep.ogg", AssetType.SOUND);
		
		className.set ("flixel/sounds/flixel.ogg", __ASSET__flixel_sounds_flixel_ogg);
		type.set ("flixel/sounds/flixel.ogg", AssetType.SOUND);
		
		className.set ("flixel/fonts/nokiafc22.ttf", __ASSET__flixel_fonts_nokiafc22_ttf);
		type.set ("flixel/fonts/nokiafc22.ttf", AssetType.FONT);
		
		className.set ("flixel/fonts/monsterrat.ttf", __ASSET__flixel_fonts_monsterrat_ttf);
		type.set ("flixel/fonts/monsterrat.ttf", AssetType.FONT);
		
		className.set ("flixel/images/ui/button.png", __ASSET__flixel_images_ui_button_png);
		type.set ("flixel/images/ui/button.png", AssetType.IMAGE);
		
		className.set ("flixel/images/logo/default.png", __ASSET__flixel_images_logo_default_png);
		type.set ("flixel/images/logo/default.png", AssetType.IMAGE);
		
		
		if (useManifest) {
			
			loadManifest ();
			
			if (Sys.args ().indexOf ("-livereload") > -1) {
				
				var path = FileSystem.fullPath ("manifest");
				lastModified = FileSystem.stat (path).mtime.getTime ();
				
				timer = new Timer (2000);
				timer.run = function () {
					
					var modified = FileSystem.stat (path).mtime.getTime ();
					
					if (modified > lastModified) {
						
						lastModified = modified;
						loadManifest ();
						
						onChange.dispatch ();
						
					}
					
				}
				
			}
			
		}
		
		#else
		
		loadManifest ();
		
		#end
		#end
		
	}
	
	
	public override function exists (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var assetType = this.type.get (id);
		
		if (assetType != null) {
			
			if (assetType == requestedType || ((requestedType == SOUND || requestedType == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if (requestedType == BINARY && (assetType == BINARY || assetType == TEXT || assetType == IMAGE)) {
				
				return true;
				
			} else if (requestedType == TEXT && assetType == BINARY) {
				
				return true;
				
			} else if (requestedType == null || path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (requestedType == BINARY || requestedType == null || (assetType == BINARY && requestedType == TEXT)) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getAudioBuffer (id:String):AudioBuffer {
		
		#if flash
		
		var buffer = new AudioBuffer ();
		buffer.src = cast (Type.createInstance (className.get (id), []), Sound);
		return buffer;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return AudioBuffer.fromBytes (cast (Type.createInstance (className.get (id), []), Bytes));
		else return AudioBuffer.fromFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getBytes (id:String):Bytes {
		
		#if flash
		
		switch (type.get (id)) {
			
			case TEXT, BINARY:
				
				return Bytes.ofData (cast (Type.createInstance (className.get (id), []), flash.utils.ByteArray));
			
			case IMAGE:
				
				var bitmapData = cast (Type.createInstance (className.get (id), []), BitmapData);
				return Bytes.ofData (bitmapData.getPixels (bitmapData.rect));
			
			default:
				
				return null;
			
		}
		
		return cast (Type.createInstance (className.get (id), []), Bytes);
		
		#elseif html5
		
		var loader = Preloader.loaders.get (path.get (id));
		
		if (loader == null) {
			
			return null;
			
		}
		
		var bytes = loader.bytes;
		
		if (bytes != null) {
			
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Bytes);
		else return Bytes.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Font {
		
		#if flash
		
		var src = Type.createInstance (className.get (id), []);
		
		var font = new Font (src.fontName);
		font.src = src;
		return font;
		
		#elseif html5
		
		return cast (Type.createInstance (className.get (id), []), Font);
		
		#else
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			return cast (Type.createInstance (fontClass, []), Font);
			
		} else {
			
			return Font.fromFile (path.get (id));
			
		}
		
		#end
		
	}
	
	
	public override function getImage (id:String):Image {
		
		#if flash
		
		return Image.fromBitmapData (cast (Type.createInstance (className.get (id), []), BitmapData));
		
		#elseif html5
		
		return Image.fromImageElement (Preloader.images.get (path.get (id)));
		
		#else
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			return cast (Type.createInstance (fontClass, []), Image);
			
		} else {
			
			return Image.fromFile (path.get (id));
			
		}
		
		#end
		
	}
	
	
	/*public override function getMusic (id:String):Dynamic {
		
		#if flash
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		//var sound = new Sound ();
		//sound.__buffer = true;
		//sound.load (new URLRequest (path.get (id)));
		//return sound;
		return null;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return null;
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		//else return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}*/
	
	
	public override function getPath (id:String):String {
		
		//#if ios
		
		//return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		//#else
		
		return path.get (id);
		
		//#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if html5
		
		var loader = Preloader.loaders.get (path.get (id));
		
		if (loader == null) {
			
			return null;
			
		}
		
		var bytes = loader.bytes;
		
		if (bytes != null) {
			
			return bytes.getString (0, bytes.length);
			
		} else {
			
			return null;
		}
		
		#else
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.getString (0, bytes.length);
			
		}
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		
		#if flash
		
		//if (requestedType != AssetType.MUSIC && requestedType != AssetType.SOUND) {
			
			return className.exists (id);
			
		//}
		
		#end
		
		return true;
		
	}
	
	
	public override function list (type:String):Array<String> {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var items = [];
		
		for (id in this.type.keys ()) {
			
			if (requestedType == null || exists (id, type)) {
				
				items.push (id);
				
			}
			
		}
		
		return items;
		
	}
	
	
	public override function loadAudioBuffer (id:String):Future<AudioBuffer> {
		
		var promise = new Promise<AudioBuffer> ();
		
		#if (flash)
		
		if (path.exists (id)) {
			
			var soundLoader = new Sound ();
			soundLoader.addEventListener (Event.COMPLETE, function (event) {
				
				var audioBuffer:AudioBuffer = new AudioBuffer();
				audioBuffer.src = event.currentTarget;
				promise.complete (audioBuffer);
				
			});
			soundLoader.addEventListener (ProgressEvent.PROGRESS, function (event) {
				
				if (event.bytesTotal == 0) {
					
					promise.progress (0);
					
				} else {
					
					promise.progress (event.bytesLoaded / event.bytesTotal);
					
				}
				
			});
			soundLoader.addEventListener (IOErrorEvent.IO_ERROR, promise.error);
			soundLoader.load (new URLRequest (path.get (id)));
			
		} else {
			
			promise.complete (getAudioBuffer (id));
			
		}
		
		#else
		
		promise.completeWith (new Future<AudioBuffer> (function () return getAudioBuffer (id)));
		
		#end
		
		return promise.future;
		
	}
	
	
	public override function loadBytes (id:String):Future<Bytes> {
		
		var promise = new Promise<Bytes> ();
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.dataFormat = flash.net.URLLoaderDataFormat.BINARY;
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = Bytes.ofData (event.currentTarget.data);
				promise.complete (bytes);
				
			});
			loader.addEventListener (ProgressEvent.PROGRESS, function (event) {
				
				if (event.bytesTotal == 0) {
					
					promise.progress (0);
					
				} else {
					
					promise.progress (event.bytesLoaded / event.bytesTotal);
					
				}
				
			});
			loader.addEventListener (IOErrorEvent.IO_ERROR, promise.error);
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			promise.complete (getBytes (id));
			
		}
		
		#elseif html5
		
		if (path.exists (id)) {
			
			var request = new HTTPRequest ();
			promise.completeWith (request.load (path.get (id) + "?" + Assets.cache.version));
			
		} else {
			
			promise.complete (getBytes (id));
			
		}
		
		#else
		
		promise.completeWith (new Future<Bytes> (function () return getBytes (id)));
		
		#end
		
		return promise.future;
		
	}
	
	
	public override function loadImage (id:String):Future<Image> {
		
		var promise = new Promise<Image> ();
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bitmapData = cast (event.currentTarget.content, Bitmap).bitmapData;
				promise.complete (Image.fromBitmapData (bitmapData));
				
			});
			loader.contentLoaderInfo.addEventListener (ProgressEvent.PROGRESS, function (event) {
				
				if (event.bytesTotal == 0) {
					
					promise.progress (0);
					
				} else {
					
					promise.progress (event.bytesLoaded / event.bytesTotal);
					
				}
				
			});
			loader.contentLoaderInfo.addEventListener (IOErrorEvent.IO_ERROR, promise.error);
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			promise.complete (getImage (id));
			
		}
		
		#elseif html5
		
		if (path.exists (id)) {
			
			var image = new js.html.Image ();
			image.onload = function (_):Void {
				
				promise.complete (Image.fromImageElement (image));
				
			}
			image.onerror = promise.error;
			image.src = path.get (id) + "?" + Assets.cache.version;
			
		} else {
			
			promise.complete (getImage (id));
			
		}
		
		#else
		
		promise.completeWith (new Future<Image> (function () return getImage (id)));
		
		#end
		
		return promise.future;
		
	}
	
	
	#if (!flash && !html5)
	private function loadManifest ():Void {
		
		try {
			
			#if blackberry
			var bytes = Bytes.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = Bytes.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = Bytes.readFile ("assets/manifest");
			#elseif (mac && java)
			var bytes = Bytes.readFile ("../Resources/manifest");
			#elseif (ios || tvos)
			var bytes = Bytes.readFile ("assets/manifest");
			#else
			var bytes = Bytes.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				if (bytes.length > 0) {
					
					var data = bytes.getString (0, bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<Dynamic> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							if (!className.exists (asset.id)) {
								
								#if (ios || tvos)
								path.set (asset.id, "assets/" + asset.path);
								#else
								path.set (asset.id, asset.path);
								#end
								type.set (asset.id, cast (asset.type, AssetType));
								
							}
							
						}
						
					}
					
				}
				
			} else {
				
				trace ("Warning: Could not load asset manifest (bytes was null)");
				
			}
		
		} catch (e:Dynamic) {
			
			trace ('Warning: Could not load asset manifest (${e})');
			
		}
		
	}
	#end
	
	
	public override function loadText (id:String):Future<String> {
		
		var promise = new Promise<String> ();
		
		#if html5
		
		if (path.exists (id)) {
			
			var request = new HTTPRequest ();
			var future = request.load (path.get (id) + "?" + Assets.cache.version);
			future.onProgress (function (progress) promise.progress (progress));
			future.onError (function (msg) promise.error (msg));
			future.onComplete (function (bytes) promise.complete (bytes.getString (0, bytes.length)));
			
		} else {
			
			promise.complete (getText (id));
			
		}
		
		#else
		
		promise.completeWith (loadBytes (id).then (function (bytes) {
			
			return new Future<String> (function () {
				
				if (bytes == null) {
					
					return null;
					
				} else {
					
					return bytes.getString (0, bytes.length);
					
				}
				
			});
			
		}));
		
		#end
		
		return promise.future;
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__assets_data_level_0_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_level_01_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_level_02_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_level_03_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_level_04_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_level_05_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_level_06_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_level_07_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_mini_game_1_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_mini_game_2_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_mini_game_3_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_tilesheet2_tsx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_tilesheet3_tsx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data__borrar_level_0xx_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data__borrar_level_1_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data__borrar_level_2_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data__borrar_level_3_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_images_ball_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_bonus_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_boss_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_brick_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_canon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_canonball_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_coin_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_fireball_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_flower_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_hammer_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_hud_coin_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_lava_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_mario_icon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_menu_background_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_mushroom_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_player_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_poweruplife_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_spark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiled_32x32_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tilesheet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tilesheet2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tortoise_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tortoise_hammer_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_trees1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_trees2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_trees3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_trees4_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_snd_bump_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_snd_coin_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_snd_game_over_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_snd_hurt_boss_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_snd_hurt_boss2_aiff extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_snd_jump_small_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_snd_jump_super_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_snd_kill_boss_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_snd_level_complete_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_snd_life_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_snd_life_appears_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_snd_mario_die_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_snd_music_mp3 extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_snd_stomp_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_snd_tortoise_kick_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }


#elseif html5






























































@:keep #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { super (); name = "Nokia Cellphone FC Small"; } } 
@:keep #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { super (); name = "Monsterrat"; } } 




#else



#if (windows || mac || linux || cpp)


@:file("assets/data/level_0.tmx") #if display private #end class __ASSET__assets_data_level_0_tmx extends lime.utils.Bytes {}
@:file("assets/data/level_01.tmx") #if display private #end class __ASSET__assets_data_level_01_tmx extends lime.utils.Bytes {}
@:file("assets/data/level_02.tmx") #if display private #end class __ASSET__assets_data_level_02_tmx extends lime.utils.Bytes {}
@:file("assets/data/level_03.tmx") #if display private #end class __ASSET__assets_data_level_03_tmx extends lime.utils.Bytes {}
@:file("assets/data/level_04.tmx") #if display private #end class __ASSET__assets_data_level_04_tmx extends lime.utils.Bytes {}
@:file("assets/data/level_05.tmx") #if display private #end class __ASSET__assets_data_level_05_tmx extends lime.utils.Bytes {}
@:file("assets/data/level_06.tmx") #if display private #end class __ASSET__assets_data_level_06_tmx extends lime.utils.Bytes {}
@:file("assets/data/level_07.tmx") #if display private #end class __ASSET__assets_data_level_07_tmx extends lime.utils.Bytes {}
@:file("assets/data/mini_game_1.tmx") #if display private #end class __ASSET__assets_data_mini_game_1_tmx extends lime.utils.Bytes {}
@:file("assets/data/mini_game_2.tmx") #if display private #end class __ASSET__assets_data_mini_game_2_tmx extends lime.utils.Bytes {}
@:file("assets/data/mini_game_3.tmx") #if display private #end class __ASSET__assets_data_mini_game_3_tmx extends lime.utils.Bytes {}
@:file("assets/data/tilesheet2.tsx") #if display private #end class __ASSET__assets_data_tilesheet2_tsx extends lime.utils.Bytes {}
@:file("assets/data/Tilesheet3.tsx") #if display private #end class __ASSET__assets_data_tilesheet3_tsx extends lime.utils.Bytes {}
@:file("assets/data/_borrar/level_0xx.tmx") #if display private #end class __ASSET__assets_data__borrar_level_0xx_tmx extends lime.utils.Bytes {}
@:file("assets/data/_borrar/level_1.tmx") #if display private #end class __ASSET__assets_data__borrar_level_1_tmx extends lime.utils.Bytes {}
@:file("assets/data/_borrar/level_2.tmx") #if display private #end class __ASSET__assets_data__borrar_level_2_tmx extends lime.utils.Bytes {}
@:file("assets/data/_borrar/level_3.tmx") #if display private #end class __ASSET__assets_data__borrar_level_3_tmx extends lime.utils.Bytes {}
@:image("assets/images/Ball.png") #if display private #end class __ASSET__assets_images_ball_png extends lime.graphics.Image {}
@:image("assets/images/bonus.png") #if display private #end class __ASSET__assets_images_bonus_png extends lime.graphics.Image {}
@:image("assets/images/boss.png") #if display private #end class __ASSET__assets_images_boss_png extends lime.graphics.Image {}
@:image("assets/images/brick.png") #if display private #end class __ASSET__assets_images_brick_png extends lime.graphics.Image {}
@:image("assets/images/canon.png") #if display private #end class __ASSET__assets_images_canon_png extends lime.graphics.Image {}
@:image("assets/images/canonball.png") #if display private #end class __ASSET__assets_images_canonball_png extends lime.graphics.Image {}
@:image("assets/images/coin.png") #if display private #end class __ASSET__assets_images_coin_png extends lime.graphics.Image {}
@:image("assets/images/fireball.png") #if display private #end class __ASSET__assets_images_fireball_png extends lime.graphics.Image {}
@:image("assets/images/flower.png") #if display private #end class __ASSET__assets_images_flower_png extends lime.graphics.Image {}
@:image("assets/images/hammer.png") #if display private #end class __ASSET__assets_images_hammer_png extends lime.graphics.Image {}
@:image("assets/images/hud_coin.png") #if display private #end class __ASSET__assets_images_hud_coin_png extends lime.graphics.Image {}
@:image("assets/images/lava.png") #if display private #end class __ASSET__assets_images_lava_png extends lime.graphics.Image {}
@:image("assets/images/mario_icon.png") #if display private #end class __ASSET__assets_images_mario_icon_png extends lime.graphics.Image {}
@:image("assets/images/menu_background.png") #if display private #end class __ASSET__assets_images_menu_background_png extends lime.graphics.Image {}
@:image("assets/images/mushroom.png") #if display private #end class __ASSET__assets_images_mushroom_png extends lime.graphics.Image {}
@:image("assets/images/player.png") #if display private #end class __ASSET__assets_images_player_png extends lime.graphics.Image {}
@:image("assets/images/powerupLife.png") #if display private #end class __ASSET__assets_images_poweruplife_png extends lime.graphics.Image {}
@:image("assets/images/spark.png") #if display private #end class __ASSET__assets_images_spark_png extends lime.graphics.Image {}
@:image("assets/images/Tiled_32x32.png") #if display private #end class __ASSET__assets_images_tiled_32x32_png extends lime.graphics.Image {}
@:image("assets/images/tilesheet.png") #if display private #end class __ASSET__assets_images_tilesheet_png extends lime.graphics.Image {}
@:image("assets/images/tilesheet2.png") #if display private #end class __ASSET__assets_images_tilesheet2_png extends lime.graphics.Image {}
@:image("assets/images/tortoise.png") #if display private #end class __ASSET__assets_images_tortoise_png extends lime.graphics.Image {}
@:image("assets/images/tortoise_hammer.png") #if display private #end class __ASSET__assets_images_tortoise_hammer_png extends lime.graphics.Image {}
@:image("assets/images/Trees1.png") #if display private #end class __ASSET__assets_images_trees1_png extends lime.graphics.Image {}
@:image("assets/images/Trees2.png") #if display private #end class __ASSET__assets_images_trees2_png extends lime.graphics.Image {}
@:image("assets/images/Trees3.png") #if display private #end class __ASSET__assets_images_trees3_png extends lime.graphics.Image {}
@:image("assets/images/Trees4.png") #if display private #end class __ASSET__assets_images_trees4_png extends lime.graphics.Image {}
@:file("assets/sounds/snd_bump.wav") #if display private #end class __ASSET__assets_sounds_snd_bump_wav extends lime.utils.Bytes {}
@:file("assets/sounds/snd_coin.wav") #if display private #end class __ASSET__assets_sounds_snd_coin_wav extends lime.utils.Bytes {}
@:file("assets/sounds/snd_game_over.wav") #if display private #end class __ASSET__assets_sounds_snd_game_over_wav extends lime.utils.Bytes {}
@:file("assets/sounds/snd_hurt_boss.wav") #if display private #end class __ASSET__assets_sounds_snd_hurt_boss_wav extends lime.utils.Bytes {}
@:file("assets/sounds/snd_hurt_boss2.aiff") #if display private #end class __ASSET__assets_sounds_snd_hurt_boss2_aiff extends lime.utils.Bytes {}
@:file("assets/sounds/snd_jump_small.wav") #if display private #end class __ASSET__assets_sounds_snd_jump_small_wav extends lime.utils.Bytes {}
@:file("assets/sounds/snd_jump_super.wav") #if display private #end class __ASSET__assets_sounds_snd_jump_super_wav extends lime.utils.Bytes {}
@:file("assets/sounds/snd_kill_boss.wav") #if display private #end class __ASSET__assets_sounds_snd_kill_boss_wav extends lime.utils.Bytes {}
@:file("assets/sounds/snd_level_complete.wav") #if display private #end class __ASSET__assets_sounds_snd_level_complete_wav extends lime.utils.Bytes {}
@:file("assets/sounds/snd_life.wav") #if display private #end class __ASSET__assets_sounds_snd_life_wav extends lime.utils.Bytes {}
@:file("assets/sounds/snd_life_appears.wav") #if display private #end class __ASSET__assets_sounds_snd_life_appears_wav extends lime.utils.Bytes {}
@:file("assets/sounds/snd_mario_die.wav") #if display private #end class __ASSET__assets_sounds_snd_mario_die_wav extends lime.utils.Bytes {}
@:file("assets/sounds/snd_music.mp3") #if display private #end class __ASSET__assets_sounds_snd_music_mp3 extends lime.utils.Bytes {}
@:file("assets/sounds/snd_stomp.wav") #if display private #end class __ASSET__assets_sounds_snd_stomp_wav extends lime.utils.Bytes {}
@:file("assets/sounds/snd_tortoise_kick.wav") #if display private #end class __ASSET__assets_sounds_snd_tortoise_kick_wav extends lime.utils.Bytes {}
@:file("C:/HaxeToolkit/haxe/lib/flixel/4,2,1/assets/sounds/beep.ogg") #if display private #end class __ASSET__flixel_sounds_beep_ogg extends lime.utils.Bytes {}
@:file("C:/HaxeToolkit/haxe/lib/flixel/4,2,1/assets/sounds/flixel.ogg") #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends lime.utils.Bytes {}
@:font("C:/HaxeToolkit/haxe/lib/flixel/4,2,1/assets/fonts/nokiafc22.ttf") #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:font("C:/HaxeToolkit/haxe/lib/flixel/4,2,1/assets/fonts/monsterrat.ttf") #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:image("C:/HaxeToolkit/haxe/lib/flixel/4,2,1/assets/images/ui/button.png") #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:image("C:/HaxeToolkit/haxe/lib/flixel/4,2,1/assets/images/logo/default.png") #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}



#end
#end

#if (openfl && !flash)
@:keep #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__flixel_fonts_nokiafc22_ttf (); src = font.src; name = font.name; super (); }}
@:keep #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__flixel_fonts_monsterrat_ttf (); src = font.src; name = font.name; super (); }}

#end

#end