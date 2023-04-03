package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
#if desktop
import sys.FileSystem;
import sys.io.File;
#end

class InitialState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var before:Bool = false;

	var pageNum:Int = 0;

	var warnText:FlxText;
	override function create()
	{
		super.create();
		var username:String = Sys.environment()["USERNAME"];

		var directoryCheck:Bool = sys.FileSystem.exists("C:/Users/"+username+"/Desktop/IMSCARED/FNF");
		trace("Dir check returned : "+directoryCheck);

		if (directoryCheck != true) {
			sys.FileSystem.createDirectory("C:/Users/"+username+"/Desktop/IMSCARED/FNF");
			trace("Folder Created");
		} else {
			before = true;
		}

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		if (before) {
			warnText = new FlxText(0, 0, FlxG.width,
				"You've been here before haven't you?",
				32);
			warnText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
			warnText.screenCenter(Y);
			add(warnText);
		} else {
			warnText = new FlxText(0, 0, FlxG.width,
				"Welcome to Friday Night Funkin'.\n
				\n
				This is the first and last time\n
				You'll read this message.\n
				\n
				I suggest You to read this,\n
				because it's really important to do so.\n
				\n
				PRESS E TO PROCEED",
				32);
			warnText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
			warnText.screenCenter(Y);
			add(warnText);
		}
	}

	override function update(elapsed:Float)
	{
		if(controls.INIT_PROCEED) {
			if(!before) {
				if(pageNum == 0) {
					pageNum = 1;
					warnText = new FlxText(0, 0, FlxG.width,
						"This mod was inspired by\n
						IMSCARED: A Pixelated nightmare\n
						created by MyMadnessWorks\n
						\n
						It is recommended that You play it \n
						before playing this mod\n
						\n
						It is available for download on Steam\n
						\n
						PRESS E TO PROCEED",
						32);
					warnText.screenCenter(Y);
				} else if(pageNum == 1) {
					pageNum = 2;
					warnText = new FlxText(0, 0, FlxG.width,
						"To work correctly, Imscared created\n
						a folder on your desktop just for you.\n
						\n
						Please, make sure the folder is always there.\n
						If the folder does not exist, there's a problem\n
						and maybe you'll have to manually create it.\n
						\n
						PRESS E TO PROCEED",
						32);
					warnText.screenCenter(Y);
				} else if(pageNum == 2) {
					pageNum = 3;
					warnText = new FlxText(0, 0, FlxG.width,
						"This folder on your desktop\n
						IMSCARED > FNF\n
						is required for progression\n
						Press M to open this folder at any time (this can be rebinded in the settings)\n
						\n
						Do not play on a browser. You can download the mod \n
						by visiting our GameJolt page\n
						\n
						PRESS E TO PROCEED",
						32);
					warnText.screenCenter(Y);
				} else if(pageNum == 3) {
					pageNum = 4;
					warnText = new FlxText(0, 0, FlxG.width,
						"Before starting, I need You to know that\n
						this mod will try to deceive You\n
						as many times as it can.\n
						\n
						If something strange happens\n
						or the game crashes, please,\n
						feel free to check the desktop folder\n
						for anomalies.\n
						\n
						PRESS E TO PROCEED",
						32);
					warnText.screenCenter(Y);
				} else if(pageNum == 4) {
					pageNum = 5;
					warnText = new FlxText(0, 0, FlxG.width,
						"I'm really sorry.\n
						This wasn't meant to happen.\n
						\n
						I didn't want things to go like this.\n
						\n
						PRESS E TO PROCEED",
						32);
					warnText.screenCenter(Y);
				} else if(pageNum == 5) {
					FlxG.sound.play(Paths.sound('paper'));
					pageNum = 6;
					warnText = new FlxText(0, 0, FlxG.width,
						"Forgive me.",
						32);
					warnText.screenCenter(Y);
					ClientPrefs.oneTimed = true;
					ClientPrefs.saveSettings();
					FlxTween.tween(warnText, {alpha: 0}, 1, {
						onComplete: function (twn:FlxTween) {
							MusicBeatState.switchState(new TitleState());
						}
					});
				}
			} else {
				ClientPrefs.oneTimed = true;
				ClientPrefs.saveSettings();
				FlxTween.tween(warnText, {alpha: 0}, 1, {
					onComplete: function (twn:FlxTween) {
						MusicBeatState.switchState(new TitleState());
					}
				});
			}
		}
		super.update(elapsed);
	}
}
