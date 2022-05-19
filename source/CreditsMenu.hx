package;

import openfl.display.BitmapData;
import openfl.system.System;
import flixel.util.FlxTimer;
import flixel.math.FlxRandom;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import lime.utils.Assets;
import flixel.addons.transition.FlxTransitionableState;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class CreditsMenu extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;

	private var grpSongs:FlxTypedGroup<Alphabet>;
	private var curPlaying:Bool = false;
	var descriptionText:FlxText;
	private var iconArray:Array<AttachedSprite> = [];
	var descBox:AttachedSprite;
	var offsetThing:Float = -75;
	var moveTween:FlxTween = null;

	public static var creditsStuff:Array<Array<String>> = [  //name //work
	["", ""],
	['Boyza', 'Charter/Credits BG Artist'], //1
	['BlackRS', 'Artist'], //2
	['PanPan', 'Logo/Sprite Animator',], //3
    ['Toni Kyouno', 'Musician of Shiningh'], //4
	['JXRetro2', 'Musician of Sukrol/ VoiceBank Creator'], //5
	['KoryM', 'Sprite Animator' ],//6
	['Gawaiii Fashion', ],//7
	['HopesRei', 'Programmer'],//8
    ['Kidemon', 'Creator/BG Artist/ Helper'] //9	

	];

	
	public static var credits:Array<String> = [

	"Press Enter To Red Social:",
	'Boyza', //1
	'BlackRS', //2
	'PanPan', //3
    'Toni Kyouno', //4
	'JXRetro2', //5
	'KoryMFur',//6
	'Gawaiii Fashion',//7
	'HopesRei',//8
    'Kidemon' //9
	];

	override function create()
	{
		FlxG.sound.cache('assets/shared/sounds/clickText.ogg');

//algun dia entendere esto
        #if windows
		DiscordClient.changePresence("Inside The Credits Menu...", null);
		#end

		if(!FlxG.sound.music.playing){
			FlxG.sound.playMusic(Paths.music("freakyMenu", "preload"));
		}
		
		FlxG.autoPause = false;
	
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image("bg/credits bg", 'akali'));
		add(bg);

		selector = new FlxText();

		selector.size = 40;
		selector.text = ">";
		// add(selector);

		grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);

		for (i in 0...credits.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, new EReg('_', 'g').replace(new EReg('0', 'g').replace(credits[i], 'O'), ' '), true, false);
			songText.isMenuItem = true;
			songText.targetY = i;


			if(credits[i].contains(":")){
				songText.color = 0xFFFFFFFF;
				songText.screenCenter();
			}

			    var icon:AttachedSprite = new AttachedSprite('credits/' + creditsStuff[i][0]);
				icon.xAdd = songText.width + 10;
				icon.sprTracker = songText;
				iconArray.push(icon);
				add(icon);

			
				descBox = new AttachedSprite();
				descBox.makeGraphic(1, 1, FlxColor.BLACK);
				descBox.xAdd = -10;
				descBox.yAdd = -10;
				descBox.alphaMult = 0;
				descBox.alpha = 0;
				add(descBox);

				descriptionText = new FlxText(50, FlxG.height + offsetThing - 25, 1180, "", 32);
				descriptionText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
				descriptionText.scrollFactor.set();
				descriptionText.screenCenter(X);
				descBox.sprTracker = descriptionText;
				add(descriptionText);


				descriptionText.text = creditsStuff[curSelected][1];


				descriptionText.y = FlxG.height - descriptionText.height + offsetThing - 60;
				if(moveTween != null) moveTween.cancel();
		        moveTween = FlxTween.tween(descriptionText, {y : descriptionText.y + 75}, 0.25, {ease: FlxEase.sineOut});
				descBox.setGraphicSize(Std.int(descriptionText.width + 20), Std.int(descriptionText.height + 25));
				descBox.updateHitbox();

				grpSongs.add(songText);
		}

		changeSelection();

		// FlxG.sound.playMusic(Paths.music('title'), 0);
		// FlxG.sound.music.fadeIn(2, 0, 0.8);
		selector = new FlxText();

		selector.size = 40;
		selector.text = ">";
		// add(selector);

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		
		if (FlxG.keys.justPressed.F)
		{
		FlxG.fullscreen = !FlxG.fullscreen;
		}

		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var upP = controls.UP_P;
		var downP = controls.DOWN_P;
		var accepted = controls.ACCEPT;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}
		

		if (controls.BACK)
		{
			FlxG.sound.music.stop();
			FlxG.autoPause = true;
			FlxG.switchState(new MainMenuState());
		}

		if (accepted)
		{
			trace(curSelected);
			switch (curSelected){
				case 0:
				case 1:
					fancyOpenURL("https://twitter.com/boyza___");
				case 2:
					fancyOpenURL("https://twitter.com/BlackRS81904174");
				case 3:
                    fancyOpenURL("https://twitter.com/panaderobonito?t=69g0Q46e8XnZ_brBsOLniA&s=09");
				case 4:
					fancyOpenURL("https://twitter.com/Koni_jaksj?s=09");
				case 5:
					fancyOpenURL("https://twitter.com/jxretro2?s=09");
				case 6:
					fancyOpenURL("https://mobile.twitter.com/KoryMFur");
				case 7:
					fancyOpenURL("https://twitter.com/lordXassisgood?t=LHI1nUb7lOxdKOLhklp8Aw&s=09");   
				case 8:
                    fancyOpenURL("https://twitter.com/HopesRei");
                 case 9:
                    fancyOpenURL("https://www.youtube.com/channel/UCG4qBqrjt2-RCMwj6x8w19A");                 

                            
				
				default:

					trace(curSelected);
			
			}
		}
	}

	function changeSelection(change:Int = 0)
	{

		curSelected += change;

		if (curSelected < 0)
			curSelected = credits.length - 1;
		if (curSelected >= credits.length)
			curSelected = 0;

		var changeTest = curSelected;

		if(credits[curSelected] == "" || credits[curSelected].contains(":") && credits[curSelected] != "PROGRAMMERS:" && credits[curSelected] != "Press Enter For Social:"){
			changeSelection(change == 0 ? 1 : change);
		}

		if(changeTest == curSelected){
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
			trace("ayo doep"); // ?????
		}
		

		var bullShit:Int = 0;

		for (item in grpSongs.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}

	}
}