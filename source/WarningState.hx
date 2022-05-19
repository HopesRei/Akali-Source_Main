package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import io.newgrounds.NG;
import lime.app.Application;
import openfl.Assets;

#if windows
import Discord.DiscordClient;
#end

#if cpp
import sys.thread.Thread;
#end

using StringTools;

class WarningState extends MusicBeatState
{   

    
	var dropText:FlxText;
	var warningMusic:FlxSound;

    override  function create():Void
	{
        #if windows
        DiscordClient.changePresence("Opening Menu", null);
        #end

        FlxG.sound.music.stop();
        warningMusic = new FlxSound().loadEmbedded(Paths.music("PauseTheme-Soft", "shared"), true, true);
		warningMusic.volume = 0;
		warningMusic.play(false, FlxG.random.int(0, Std.int(warningMusic.length / 2)));
		
		FlxG.sound.list.add(warningMusic);

        var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.antialiasing = true;
        bg.alpha = 0;
		add(bg);

        dropText = new FlxText(-150, 0, Std.int(FlxG.width * 1.2), "", 32);
		dropText.font = 'DK Inky Fingers';
		dropText.color = FlxColor.WHITE;
        dropText.alignment = FlxTextAlign.CENTER;
        dropText.alpha = 0;
		add(dropText);
        FlxTween.tween(bg, {alpha: 1}, 1.2, {ease: FlxEase.circOut});
        FlxTween.tween(dropText, {alpha: 1}, 1.2, {ease: FlxEase.circOut});
       
    }


    override function update(elapsed:Float)
	{
		if (warningMusic.volume < 0.3)
			warningMusic.volume += 0.01 * elapsed;
			
        dropText.text = "This is a demo version, the full week version will include
        -artistic redesigns on stage
        -3 mechanics
        -more songs
        If you like and are interested in the demo,
        do not hesitate to leave us a like on the gamebanana page so that more people know the mod
        (Press any key to continue)";
        dropText.visible = true;
        dropText.screenCenter();
         if (FlxG.keys.justPressed.ANY)
		{
            FlxG.sound.music.stop();
            FlxG.switchState(new MainMenuState());
		}
       
    }
}