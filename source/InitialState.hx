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
				This is the first and last time\n
				You'll read this message.\n
				I suggest You to read this,\n
				because it's really important to do so.\n
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
					FlxG.sound.play(Paths.sound('paper'));
					pageNum = 1;
					warnText.text = "This mod was inspired by\nIMSCARED: A Pixelated nightmare\ncreated by MyMadnessWorks\nIt is recommended that You play it \nbefore playing this mod\nIt is available for download on Steam\nPRESS E TO PROCEED";
					warnText.screenCenter(Y);
				} else if(pageNum == 1) {
					FlxG.sound.play(Paths.sound('paper'));
					pageNum = 2;
					warnText.text = "To work correctly, Imscared created\na folder on your desktop just for you.\nPlease, make sure the folder is always there.\nIf the folder does not exist, there's a problem\nand maybe you'll have to manually create it.\nPRESS E TO PROCEED";
					warnText.screenCenter(Y);
				} else if(pageNum == 2) {
					FlxG.sound.play(Paths.sound('paper'));
					pageNum = 3;
					warnText.text = "This folder on your desktop\nIMSCARED > FNF\nis required for progression\nPress M to open this folder at any time (this can be rebinded in the settings)\nDo not play on a browser. You can download the mod \nby visiting our GameJolt page\nPRESS E TO PROCEED";
					warnText.screenCenter(Y);
				} else if(pageNum == 3) {
					FlxG.sound.play(Paths.sound('paper'));
					pageNum = 4;
					warnText.text = "Before starting, I need You to know that\nthis mod will try to deceive You\nas many times as it can.\nIf something strange happens\nor the game crashes, please,\nfeel free to check the desktop folder\nfor anomalies.\nPRESS E TO PROCEED";
					warnText.screenCenter(Y);
				} else if(pageNum == 4) {
					FlxG.sound.play(Paths.sound('paper'));
					pageNum = 5;
					warnText.text = "I'm really sorry.\nThis wasn't meant to happen.\nI didn't want things to go like this.\nPRESS E TO PROCEED";
					warnText.screenCenter(Y);
				} else if(pageNum == 5) {
					FlxG.sound.play(Paths.sound('paper'));
					pageNum = 6;
					warnText.text = "Forgive me.";
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
