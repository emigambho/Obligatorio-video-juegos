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
		
		className.set ("assets/data/borrar/level_boss.tmx", __ASSET__assets_data_borrar_level_boss_tmx);
		type.set ("assets/data/borrar/level_boss.tmx", AssetType.TEXT);
		className.set ("assets/data/borrar/room-02.tmx", __ASSET__assets_data_borrar_room_02_tmx);
		type.set ("assets/data/borrar/room-02.tmx", AssetType.TEXT);
		className.set ("assets/data/borrar/room-boss-v1.tmx", __ASSET__assets_data_borrar_room_boss_v1_tmx);
		type.set ("assets/data/borrar/room-boss-v1.tmx", AssetType.TEXT);
		className.set ("assets/data/level_0.tmx", __ASSET__assets_data_level_0_tmx);
		type.set ("assets/data/level_0.tmx", AssetType.TEXT);
		className.set ("assets/data/level_1.tmx", __ASSET__assets_data_level_1_tmx);
		type.set ("assets/data/level_1.tmx", AssetType.TEXT);
		className.set ("assets/data/level_2.tmx", __ASSET__assets_data_level_2_tmx);
		type.set ("assets/data/level_2.tmx", AssetType.TEXT);
		className.set ("assets/data/level_boss2.tmx", __ASSET__assets_data_level_boss2_tmx);
		type.set ("assets/data/level_boss2.tmx", AssetType.TEXT);
		className.set ("assets/data/room-ball-1.tmx", __ASSET__assets_data_room_ball_1_tmx);
		type.set ("assets/data/room-ball-1.tmx", AssetType.TEXT);
		className.set ("assets/data/room-ball-2.tmx", __ASSET__assets_data_room_ball_2_tmx);
		type.set ("assets/data/room-ball-2.tmx", AssetType.TEXT);
		className.set ("assets/images/Ball.png", __ASSET__assets_images_ball_png);
		type.set ("assets/images/Ball.png", AssetType.IMAGE);
		className.set ("assets/images/bg_1.png", __ASSET__assets_images_bg_1_png);
		type.set ("assets/images/bg_1.png", AssetType.IMAGE);
		className.set ("assets/images/bg_2.png", __ASSET__assets_images_bg_2_png);
		type.set ("assets/images/bg_2.png", AssetType.IMAGE);
		className.set ("assets/images/bg_dirt.png", __ASSET__assets_images_bg_dirt_png);
		type.set ("assets/images/bg_dirt.png", AssetType.IMAGE);
		className.set ("assets/images/bonus.png", __ASSET__assets_images_bonus_png);
		type.set ("assets/images/bonus.png", AssetType.IMAGE);
		className.set ("assets/images/boss.png", __ASSET__assets_images_boss_png);
		type.set ("assets/images/boss.png", AssetType.IMAGE);
		className.set ("assets/images/brick.png", __ASSET__assets_images_brick_png);
		type.set ("assets/images/brick.png", AssetType.IMAGE);
		className.set ("assets/images/bubble.png", __ASSET__assets_images_bubble_png);
		type.set ("assets/images/bubble.png", AssetType.IMAGE);
		className.set ("assets/images/cloud.png", __ASSET__assets_images_cloud_png);
		type.set ("assets/images/cloud.png", AssetType.IMAGE);
		className.set ("assets/images/coin.png", __ASSET__assets_images_coin_png);
		type.set ("assets/images/coin.png", AssetType.IMAGE);
		className.set ("assets/images/coinInBrick.png", __ASSET__assets_images_coininbrick_png);
		type.set ("assets/images/coinInBrick.png", AssetType.IMAGE);
		className.set ("assets/images/fireball.png", __ASSET__assets_images_fireball_png);
		type.set ("assets/images/fireball.png", AssetType.IMAGE);
		className.set ("assets/images/fish.png", __ASSET__assets_images_fish_png);
		type.set ("assets/images/fish.png", AssetType.IMAGE);
		className.set ("assets/images/flag.png", __ASSET__assets_images_flag_png);
		type.set ("assets/images/flag.png", AssetType.IMAGE);
		className.set ("assets/images/flower.png", __ASSET__assets_images_flower_png);
		type.set ("assets/images/flower.png", AssetType.IMAGE);
		className.set ("assets/images/hud_coin.png", __ASSET__assets_images_hud_coin_png);
		type.set ("assets/images/hud_coin.png", AssetType.IMAGE);
		className.set ("assets/images/lava.png", __ASSET__assets_images_lava_png);
		type.set ("assets/images/lava.png", AssetType.IMAGE);
		className.set ("assets/images/menu_background.jpg", __ASSET__assets_images_menu_background_jpg);
		type.set ("assets/images/menu_background.jpg", AssetType.IMAGE);
		className.set ("assets/images/mushroom.png", __ASSET__assets_images_mushroom_png);
		type.set ("assets/images/mushroom.png", AssetType.IMAGE);
		className.set ("assets/images/octopus.png", __ASSET__assets_images_octopus_png);
		type.set ("assets/images/octopus.png", AssetType.IMAGE);
		className.set ("assets/images/player.png", __ASSET__assets_images_player_png);
		type.set ("assets/images/player.png", AssetType.IMAGE);
		className.set ("assets/images/powerupLife.png", __ASSET__assets_images_poweruplife_png);
		type.set ("assets/images/powerupLife.png", AssetType.IMAGE);
		className.set ("assets/images/spark.png", __ASSET__assets_images_spark_png);
		type.set ("assets/images/spark.png", AssetType.IMAGE);
		className.set ("assets/images/tilesheet.png", __ASSET__assets_images_tilesheet_png);
		type.set ("assets/images/tilesheet.png", AssetType.IMAGE);
		className.set ("assets/images/tortoise.png", __ASSET__assets_images_tortoise_png);
		type.set ("assets/images/tortoise.png", AssetType.IMAGE);
		className.set ("flixel/sounds/beep.mp3", __ASSET__flixel_sounds_beep_mp3);
		type.set ("flixel/sounds/beep.mp3", AssetType.MUSIC);
		className.set ("flixel/sounds/flixel.mp3", __ASSET__flixel_sounds_flixel_mp3);
		type.set ("flixel/sounds/flixel.mp3", AssetType.MUSIC);
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
		id = "assets/data/borrar/level_boss.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/borrar/room-02.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/borrar/room-boss-v1.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/level_0.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/level_1.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/level_2.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/level_boss2.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/room-ball-1.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/room-ball-2.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/images/Ball.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/bg_1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/bg_2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/bg_dirt.png";
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
		id = "assets/images/bubble.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/cloud.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/coin.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/coinInBrick.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/fireball.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/fish.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/flag.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/flower.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/hud_coin.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/lava.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/menu_background.jpg";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/mushroom.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/octopus.png";
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
		id = "assets/images/tilesheet.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tortoise.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/sounds/beep.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "flixel/sounds/flixel.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
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
		
		className.set ("assets/data/borrar/level_boss.tmx", __ASSET__assets_data_borrar_level_boss_tmx);
		type.set ("assets/data/borrar/level_boss.tmx", AssetType.TEXT);
		
		className.set ("assets/data/borrar/room-02.tmx", __ASSET__assets_data_borrar_room_02_tmx);
		type.set ("assets/data/borrar/room-02.tmx", AssetType.TEXT);
		
		className.set ("assets/data/borrar/room-boss-v1.tmx", __ASSET__assets_data_borrar_room_boss_v1_tmx);
		type.set ("assets/data/borrar/room-boss-v1.tmx", AssetType.TEXT);
		
		className.set ("assets/data/level_0.tmx", __ASSET__assets_data_level_0_tmx);
		type.set ("assets/data/level_0.tmx", AssetType.TEXT);
		
		className.set ("assets/data/level_1.tmx", __ASSET__assets_data_level_1_tmx);
		type.set ("assets/data/level_1.tmx", AssetType.TEXT);
		
		className.set ("assets/data/level_2.tmx", __ASSET__assets_data_level_2_tmx);
		type.set ("assets/data/level_2.tmx", AssetType.TEXT);
		
		className.set ("assets/data/level_boss2.tmx", __ASSET__assets_data_level_boss2_tmx);
		type.set ("assets/data/level_boss2.tmx", AssetType.TEXT);
		
		className.set ("assets/data/room-ball-1.tmx", __ASSET__assets_data_room_ball_1_tmx);
		type.set ("assets/data/room-ball-1.tmx", AssetType.TEXT);
		
		className.set ("assets/data/room-ball-2.tmx", __ASSET__assets_data_room_ball_2_tmx);
		type.set ("assets/data/room-ball-2.tmx", AssetType.TEXT);
		
		className.set ("assets/images/Ball.png", __ASSET__assets_images_ball_png);
		type.set ("assets/images/Ball.png", AssetType.IMAGE);
		
		className.set ("assets/images/bg_1.png", __ASSET__assets_images_bg_1_png);
		type.set ("assets/images/bg_1.png", AssetType.IMAGE);
		
		className.set ("assets/images/bg_2.png", __ASSET__assets_images_bg_2_png);
		type.set ("assets/images/bg_2.png", AssetType.IMAGE);
		
		className.set ("assets/images/bg_dirt.png", __ASSET__assets_images_bg_dirt_png);
		type.set ("assets/images/bg_dirt.png", AssetType.IMAGE);
		
		className.set ("assets/images/bonus.png", __ASSET__assets_images_bonus_png);
		type.set ("assets/images/bonus.png", AssetType.IMAGE);
		
		className.set ("assets/images/boss.png", __ASSET__assets_images_boss_png);
		type.set ("assets/images/boss.png", AssetType.IMAGE);
		
		className.set ("assets/images/brick.png", __ASSET__assets_images_brick_png);
		type.set ("assets/images/brick.png", AssetType.IMAGE);
		
		className.set ("assets/images/bubble.png", __ASSET__assets_images_bubble_png);
		type.set ("assets/images/bubble.png", AssetType.IMAGE);
		
		className.set ("assets/images/cloud.png", __ASSET__assets_images_cloud_png);
		type.set ("assets/images/cloud.png", AssetType.IMAGE);
		
		className.set ("assets/images/coin.png", __ASSET__assets_images_coin_png);
		type.set ("assets/images/coin.png", AssetType.IMAGE);
		
		className.set ("assets/images/coinInBrick.png", __ASSET__assets_images_coininbrick_png);
		type.set ("assets/images/coinInBrick.png", AssetType.IMAGE);
		
		className.set ("assets/images/fireball.png", __ASSET__assets_images_fireball_png);
		type.set ("assets/images/fireball.png", AssetType.IMAGE);
		
		className.set ("assets/images/fish.png", __ASSET__assets_images_fish_png);
		type.set ("assets/images/fish.png", AssetType.IMAGE);
		
		className.set ("assets/images/flag.png", __ASSET__assets_images_flag_png);
		type.set ("assets/images/flag.png", AssetType.IMAGE);
		
		className.set ("assets/images/flower.png", __ASSET__assets_images_flower_png);
		type.set ("assets/images/flower.png", AssetType.IMAGE);
		
		className.set ("assets/images/hud_coin.png", __ASSET__assets_images_hud_coin_png);
		type.set ("assets/images/hud_coin.png", AssetType.IMAGE);
		
		className.set ("assets/images/lava.png", __ASSET__assets_images_lava_png);
		type.set ("assets/images/lava.png", AssetType.IMAGE);
		
		className.set ("assets/images/menu_background.jpg", __ASSET__assets_images_menu_background_jpg);
		type.set ("assets/images/menu_background.jpg", AssetType.IMAGE);
		
		className.set ("assets/images/mushroom.png", __ASSET__assets_images_mushroom_png);
		type.set ("assets/images/mushroom.png", AssetType.IMAGE);
		
		className.set ("assets/images/octopus.png", __ASSET__assets_images_octopus_png);
		type.set ("assets/images/octopus.png", AssetType.IMAGE);
		
		className.set ("assets/images/player.png", __ASSET__assets_images_player_png);
		type.set ("assets/images/player.png", AssetType.IMAGE);
		
		className.set ("assets/images/powerupLife.png", __ASSET__assets_images_poweruplife_png);
		type.set ("assets/images/powerupLife.png", AssetType.IMAGE);
		
		className.set ("assets/images/spark.png", __ASSET__assets_images_spark_png);
		type.set ("assets/images/spark.png", AssetType.IMAGE);
		
		className.set ("assets/images/tilesheet.png", __ASSET__assets_images_tilesheet_png);
		type.set ("assets/images/tilesheet.png", AssetType.IMAGE);
		
		className.set ("assets/images/tortoise.png", __ASSET__assets_images_tortoise_png);
		type.set ("assets/images/tortoise.png", AssetType.IMAGE);
		
		className.set ("flixel/sounds/beep.mp3", __ASSET__flixel_sounds_beep_mp3);
		type.set ("flixel/sounds/beep.mp3", AssetType.MUSIC);
		
		className.set ("flixel/sounds/flixel.mp3", __ASSET__flixel_sounds_flixel_mp3);
		type.set ("flixel/sounds/flixel.mp3", AssetType.MUSIC);
		
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

@:keep @:bind #if display private #end class __ASSET__assets_data_borrar_level_boss_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_borrar_room_02_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_borrar_room_boss_v1_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_level_0_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_level_1_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_level_2_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_level_boss2_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_room_ball_1_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_room_ball_2_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_images_ball_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_bg_1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_bg_2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_bg_dirt_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_bonus_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_boss_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_brick_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_bubble_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_cloud_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_coin_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_coininbrick_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_fireball_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_fish_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_flag_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_flower_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_hud_coin_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_lava_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_menu_background_jpg extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_mushroom_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_octopus_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_player_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_poweruplife_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_spark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tilesheet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tortoise_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }


#elseif html5





































@:keep #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { super (); name = "Nokia Cellphone FC Small"; } } 
@:keep #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { super (); name = "Monsterrat"; } } 




#else



#if (windows || mac || linux || cpp)


@:file("assets/data/borrar/level_boss.tmx") #if display private #end class __ASSET__assets_data_borrar_level_boss_tmx extends lime.utils.Bytes {}
@:file("assets/data/borrar/room-02.tmx") #if display private #end class __ASSET__assets_data_borrar_room_02_tmx extends lime.utils.Bytes {}
@:file("assets/data/borrar/room-boss-v1.tmx") #if display private #end class __ASSET__assets_data_borrar_room_boss_v1_tmx extends lime.utils.Bytes {}
@:file("assets/data/level_0.tmx") #if display private #end class __ASSET__assets_data_level_0_tmx extends lime.utils.Bytes {}
@:file("assets/data/level_1.tmx") #if display private #end class __ASSET__assets_data_level_1_tmx extends lime.utils.Bytes {}
@:file("assets/data/level_2.tmx") #if display private #end class __ASSET__assets_data_level_2_tmx extends lime.utils.Bytes {}
@:file("assets/data/level_boss2.tmx") #if display private #end class __ASSET__assets_data_level_boss2_tmx extends lime.utils.Bytes {}
@:file("assets/data/room-ball-1.tmx") #if display private #end class __ASSET__assets_data_room_ball_1_tmx extends lime.utils.Bytes {}
@:file("assets/data/room-ball-2.tmx") #if display private #end class __ASSET__assets_data_room_ball_2_tmx extends lime.utils.Bytes {}
@:image("assets/images/Ball.png") #if display private #end class __ASSET__assets_images_ball_png extends lime.graphics.Image {}
@:image("assets/images/bg_1.png") #if display private #end class __ASSET__assets_images_bg_1_png extends lime.graphics.Image {}
@:image("assets/images/bg_2.png") #if display private #end class __ASSET__assets_images_bg_2_png extends lime.graphics.Image {}
@:image("assets/images/bg_dirt.png") #if display private #end class __ASSET__assets_images_bg_dirt_png extends lime.graphics.Image {}
@:image("assets/images/bonus.png") #if display private #end class __ASSET__assets_images_bonus_png extends lime.graphics.Image {}
@:image("assets/images/boss.png") #if display private #end class __ASSET__assets_images_boss_png extends lime.graphics.Image {}
@:image("assets/images/brick.png") #if display private #end class __ASSET__assets_images_brick_png extends lime.graphics.Image {}
@:image("assets/images/bubble.png") #if display private #end class __ASSET__assets_images_bubble_png extends lime.graphics.Image {}
@:image("assets/images/cloud.png") #if display private #end class __ASSET__assets_images_cloud_png extends lime.graphics.Image {}
@:image("assets/images/coin.png") #if display private #end class __ASSET__assets_images_coin_png extends lime.graphics.Image {}
@:image("assets/images/coinInBrick.png") #if display private #end class __ASSET__assets_images_coininbrick_png extends lime.graphics.Image {}
@:image("assets/images/fireball.png") #if display private #end class __ASSET__assets_images_fireball_png extends lime.graphics.Image {}
@:image("assets/images/fish.png") #if display private #end class __ASSET__assets_images_fish_png extends lime.graphics.Image {}
@:image("assets/images/flag.png") #if display private #end class __ASSET__assets_images_flag_png extends lime.graphics.Image {}
@:image("assets/images/flower.png") #if display private #end class __ASSET__assets_images_flower_png extends lime.graphics.Image {}
@:image("assets/images/hud_coin.png") #if display private #end class __ASSET__assets_images_hud_coin_png extends lime.graphics.Image {}
@:image("assets/images/lava.png") #if display private #end class __ASSET__assets_images_lava_png extends lime.graphics.Image {}
@:image("assets/images/menu_background.jpg") #if display private #end class __ASSET__assets_images_menu_background_jpg extends lime.graphics.Image {}
@:image("assets/images/mushroom.png") #if display private #end class __ASSET__assets_images_mushroom_png extends lime.graphics.Image {}
@:image("assets/images/octopus.png") #if display private #end class __ASSET__assets_images_octopus_png extends lime.graphics.Image {}
@:image("assets/images/player.png") #if display private #end class __ASSET__assets_images_player_png extends lime.graphics.Image {}
@:image("assets/images/powerupLife.png") #if display private #end class __ASSET__assets_images_poweruplife_png extends lime.graphics.Image {}
@:image("assets/images/spark.png") #if display private #end class __ASSET__assets_images_spark_png extends lime.graphics.Image {}
@:image("assets/images/tilesheet.png") #if display private #end class __ASSET__assets_images_tilesheet_png extends lime.graphics.Image {}
@:image("assets/images/tortoise.png") #if display private #end class __ASSET__assets_images_tortoise_png extends lime.graphics.Image {}
@:file("C:/HaxeToolkit/haxe/lib/flixel/4,2,1/assets/sounds/beep.mp3") #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends lime.utils.Bytes {}
@:file("C:/HaxeToolkit/haxe/lib/flixel/4,2,1/assets/sounds/flixel.mp3") #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends lime.utils.Bytes {}
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