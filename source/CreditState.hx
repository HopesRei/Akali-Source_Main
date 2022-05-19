package;

//import js.html.FileSystem;
import flixel.addons.plugin.taskManager.FlxTask;
import flixel.system.FlxSound;
import flixel.util.FlxTimer;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;

#if windows
import Sys;
import sys.FileSystem;
#end

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class CreditState extends MusicBeatState
{
	/*var panelBottom:FlxSprite;
	var panelTop:FlxSprite;*/
	var panelMiddle:FlxSprite;
	var arrowLeft:FlxSprite;
	var arrowRight:FlxSprite;

	var creditsPage1:FlxTypedGroup<CreditIcon>;
	var textPage1:FlxTypedGroup<FlxSprite>;
    var collertext:FlxTypedGroup<FlxText>;
	var curPage:Int = 0;

	var canDoStuff:Bool = false;
	
	override function create()
	{
		super.create();
		FlxG.camera.zoom = 0.8;

		FlxG.mouse.visible = true;

		panelMiddle = new FlxSprite(-100).loadGraphic(Paths.image("bg/credits bg", 'akali'));
		panelMiddle.antialiasing = true;
		panelMiddle.alpha = 0;
		panelMiddle.setGraphicSize(Std.int(panelMiddle.width * 1.1));
		panelMiddle.updateHitbox();
		panelMiddle.screenCenter();
		add(panelMiddle);

		/*panelBottom = new FlxSprite(0, 500).loadGraphic(Paths.image("credits/panelBottom"));
		panelBottom.antialiasing = true;
		add(panelBottom);

		panelTop = new FlxSprite(0, -500).loadGraphic(Paths.image("credits/panelTop"));
		panelTop.antialiasing = true;
		add(panelTop);*/
		var ui_tex = Paths.getSparrowAtlas('campaign_menu_UI_assets');
		creditsPage1 = new FlxTypedGroup<CreditIcon>();
		add(creditsPage1);

		textPage1 = new FlxTypedGroup<FlxSprite>();
		add(textPage1);

		collertext = new FlxTypedGroup<FlxText>();
		add(collertext);

		arrowLeft = new FlxSprite(182, 1000);
		arrowLeft.frames = ui_tex;
		arrowLeft.animation.addByPrefix('idle', "arrow left");
		arrowLeft.animation.addByPrefix('press', "arrow push left");
		arrowLeft.animation.play('idle');
		arrowLeft.updateHitbox();
		add(arrowLeft);

		arrowRight = new FlxSprite(1015, 1000);
		arrowRight.frames = ui_tex;
		arrowRight.animation.addByPrefix('idle', 'arrow right');
		arrowRight.animation.addByPrefix('press', "arrow push right", 24, false);
		arrowRight.animation.play('idle');
		arrowRight.updateHitbox();
		add(arrowRight);

		for (i in 0...9) {
			var icon:CreditIcon = new CreditIcon();
			var name:FlxText = new FlxText();
			name.setFormat(Paths.font("vcr.ttf"), 32);
			var work:FlxText = new FlxText();
			work.font = name.font;
			switch (i) {
				case 0:
					icon = new CreditIcon(61, 133, 'Boyza', 'https://twitter.com/boyza___');
					name = new FlxText (160, 137, 0, "Boyza", 40);
					work = new FlxText (160, 140, 0, "Charter/ Credits BG", 40);
				case 1:
					icon = new CreditIcon(64, 236, 'BlackRS', 'https://twitter.com/BlackRS81904174');
					name = new FlxText (162, 257, 0, "BlackRS", 40);
					work = new FlxText (162, 257, 0, "Artist", 40);
				case 2:
					icon = new CreditIcon(60, 362, 'PanPan', 'https://twitter.com/panaderobonito?t=69g0Q46e8XnZ_brBsOLniA&s=09');
					name = new FlxText (160, 137, 0, "PanPan", 40);
					work = new FlxText (160, 140, 0, "Logo/Sprite Animator", 40);
				case 3:
					icon = new CreditIcon(50, 484, 'Toni Kyouno', 'https://twitter.com/Koni_jaksj?s=09');
					name = new FlxText (160, 137, 0, "Toni Kyouno", 40);
					work = new FlxText (160, 140, 0, "Musician of Shiningh", 40);
				case 4:
					icon = new CreditIcon(458, 127, 'JXRetro2', 'https://twitter.com/jxretro2?s=09');
					name = new FlxText (160, 137, 0, "JXRetro2", 40);
					work = new FlxText (160, 140, 0, "Musician of Sukrol/ VoiceBank Creator", 40);
				case 5:
					icon = new CreditIcon(460, 268, 'KoryM', 'https://mobile.twitter.com/KoryMFur');
					name = new FlxText (160, 137, 0, "KoryMFur", 40);
					work = new FlxText (160, 140, 0, "Sprite Animator", 40);
				case 6:
					icon = new CreditIcon(460, 375, 'Gawaiii Fashion', 'https://twitter.com/lordXassisgood?t=LHI1nUb7lOxdKOLhklp8Aw&s=09');
					name = new FlxText (160, 137, 0, "Gawaiii Fashion", 40);
					work = new FlxText (160, 140, 0, "Sprite Artist", 40);
				case 7:
					icon = new CreditIcon(806, 119, 'HopesRei', 'https://twitter.com/HopesRei');
					name = new FlxText (160, 137, 0, "HopesRei", 40);
					work = new FlxText (160, 140, 0, "Coder", 40);
				case 8:
					icon = new CreditIcon(861, 171, 'Kidemon', 'https://twitter.com/OfiKidemonYT');
					name = new FlxText (160, 137, 0, "Kidemon", 40);
					work = new FlxText (160, 140, 0, "Creator/BG Artist/Helper", 40);
			}
			icon.x += FlxG.width * 4;
			name.x += FlxG.width * 4;
			work.x += FlxG.width * 4;
			icon.antialiasing = true;
			creditsPage1.add(icon);
			collertext.add(name);
			collertext.add(work);
			//textPage1.add(text);
		}
		FlxTween.tween(FlxG.camera, {zoom: 1.05}, 1.2, {
			ease: FlxEase.cubeOut,
			onComplete: function (twn:FlxTween) {
				FlxTween.tween(FlxG.camera, {zoom: 1}, 0.2, {
					ease: FlxEase.quadIn
				});
			}
		});

		FlxTween.tween(arrowLeft, {y: 593}, 1, {
			ease: FlxEase.quadOut,
			startDelay: 1.2,
		});

		FlxTween.tween(arrowRight, {y: 593}, 1, {
			ease: FlxEase.quadOut,
			startDelay: 1.4,
		});

		/*FlxTween.tween(panelTop, {y: 0}, 1, {
			ease: FlxEase.quadOut,
			//startDelay: 0.6,
		});

		FlxTween.tween(panelBottom, {y: 0}, 1, {
			ease: FlxEase.quadOut,
			//startDelay: 0.6,
		});*/

		FlxTween.tween(panelMiddle, {alpha: 1}, 1.4, {
			ease: FlxEase.cubeOut,
			//startDelay: 0.6,
		});

		for (i in creditsPage1) {
			FlxTween.tween(i, {x: i.x - FlxG.width}, 0.6, {
				ease: FlxEase.cubeOut,
			});
		}

		for (i in textPage1) {
			FlxTween.tween(i, {x: i.x - FlxG.width}, 0.6, {
				ease: FlxEase.cubeOut,
			});
		}

		for (i in collertext)
			{
				FlxTween.tween(i, {x: i.x - FlxG.width}, 0.6, {
					ease: FlxEase.cubeOut,
				});
			}

		new FlxTimer().start(0.6, function(tmr:FlxTimer)
		{
			for (i in 0...4) {
				FlxTween.tween(creditsPage1.members[i], {x: creditsPage1.members[i].x - FlxG.width}, 1.4, {
					ease: FlxEase.cubeOut,
					//startDelay: 0.6,
				});

				FlxTween.tween(collertext.members[i], {x: collertext.members[i].x - FlxG.width}, 1.4, {
					ease: FlxEase.cubeOut,
					//startDelay: 0.6,
				});
	
				FlxTween.tween(textPage1.members[i], {x: textPage1.members[i].x - FlxG.width}, 1.4, {
					ease: FlxEase.cubeOut,
					//startDelay: 0.6,
				});
			}
	
			for (i in 4...8) {
				FlxTween.tween(creditsPage1.members[i], {x: creditsPage1.members[i].x - FlxG.width}, 1.4, {
					ease: FlxEase.cubeOut,
					startDelay: 0.1,
				});

				FlxTween.tween(collertext.members[i], {x: collertext.members[i].x - FlxG.width}, 1.4, {
					ease: FlxEase.cubeOut,
					startDelay: 0.1,
				});
	
				FlxTween.tween(textPage1.members[i], {x: textPage1.members[i].x - FlxG.width}, 1.4, {
					ease: FlxEase.cubeOut,
					startDelay: 0.1,
				});
			}
			for (i in 8...37) {
				FlxTween.tween(creditsPage1.members[i], {x: creditsPage1.members[i].x - FlxG.width}, 1.4, {
					ease: FlxEase.cubeOut,
					startDelay: 0.2,
				});
			}
			for (i in 8...37) {
				FlxTween.tween(textPage1.members[i], {x: textPage1.members[i].x - FlxG.width}, 1.4, {
					ease: FlxEase.cubeOut,
					startDelay: 0.2,
					onComplete: function(twn:FlxTween) {
						canDoStuff = true;
					}
				});
			}
		});
		
	}

	override function update(elapsed:Float)
	{
		if (canDoStuff) {
			if (controls.LEFT_P) {
				changePage(-1);
			}
			if (controls.RIGHT_P) {
				changePage(1);
			}
			if (controls.BACK)
				outTransition();
		}

		if (controls.RIGHT)
			arrowRight.scale.set(0.92, 0.92);
		else
			arrowRight.scale.set(0.95, 0.95);

		if (controls.LEFT)
			arrowLeft.scale.set(0.92, 0.92);
		else
			arrowLeft.scale.set(0.95, 0.95);

		if (FlxG.mouse.overlaps(arrowLeft)) {
			arrowLeft.scale.set(1, 1);
			if (FlxG.mouse.pressed)
				arrowLeft.scale.set(0.92, 0.92);
			if (FlxG.mouse.justPressed && canDoStuff)
				changePage(-1);
		} else if (!controls.LEFT)
			arrowLeft.scale.set(0.95, 0.95);

		if (FlxG.mouse.overlaps(arrowRight)) {
			arrowRight.scale.set(1, 1);
			if (FlxG.mouse.pressed)
				arrowRight.scale.set(0.92, 0.92);
			if (FlxG.mouse.justPressed && canDoStuff)
				changePage(1);
		} else if (!controls.RIGHT)
			arrowRight.scale.set(0.95, 0.95);

		for (i in creditsPage1) {
			if (FlxG.mouse.overlaps(i)) {
				i.scale.set(1.1, 1.1);
				if (FlxG.mouse.justPressed) {
					#if linux
					Sys.command('/usr/bin/xdg-open', [i.link, "&"]);
					#else
					FlxG.openURL(i.link);
					#end
				}
			} else {
				i.scale.set(1, 1);
			}
		}
	}

	function changePage(change:Int = 0):Void {
		canDoStuff = false;
		var prevPage = curPage;
		curPage += change;
		if (curPage < 0) {
			curPage = 0;
			canDoStuff = true;
		} else if (curPage > 3) {
			curPage = 3;
			canDoStuff = true;
		}
		if (prevPage != curPage) {
			for (i in creditsPage1) {
				FlxTween.tween(i, {x: i.x + FlxG.width * -change}, 1, {
					ease: FlxEase.quadOut,
				});
			}
			for (i in textPage1) {
				FlxTween.tween(i, {x: i.x + FlxG.width * -change}, 1, {
					ease: FlxEase.quadOut,
					onComplete: function (twn:FlxTween) {
						canDoStuff = true;
					},
				});
			}
		}
	}

	function outTransition():Void {
		canDoStuff = false;
		FlxTween.tween(arrowLeft, {y: 973}, 1, {
			ease: FlxEase.quadOut,
		});


		FlxTween.tween(arrowRight, {y: 973}, 1, {
			ease: FlxEase.quadOut,
			startDelay: 0.2,
		});

		/*FlxTween.tween(panelTop, {y: -500}, 1, {
			ease: FlxEase.quadOut,
			//startDelay: 0.6,
		});

		FlxTween.tween(panelBottom, {y: 500}, 1, {
			ease: FlxEase.quadOut,
			//startDelay: 0.6,
		});*/

		FlxTween.tween(panelMiddle, {alpha: 0}, 1, {
			ease: FlxEase.cubeOut,
			startDelay: 0.6,
			onComplete: function(twn:FlxTween) {
				FlxG.switchState(new MainMenuState());
			}
		});

		FlxTween.tween(FlxG.camera, {zoom: 0.8}, 0.6, {startDelay: 0.6});

		var imFuckingDumb:Int = 0;
		var dumb3:Int = 0;
		switch (curPage) {
			case 0:
				dumb3 = 24;
				imFuckingDumb = 9;
		}
		//sorry :(
		for (i in creditsPage1)
			i.alpha = 0;
		for (i in textPage1)
			i.alpha = 0;
		for (i in collertext)
			i.alpha = 0;
		/*if (curPage == 3) {
			for (i in 37...42) {
				textPage1.members[i].alpha = 1;

				FlxTween.tween(textPage1.members[i], {x: textPage1.members[i].x - FlxG.width * 1.5}, 1.4, {
					ease: FlxEase.cubeOut,
					startDelay: 0.4,
				});
			}
		} else {*/
			for (i in (4 * curPage)...imFuckingDumb) {
				creditsPage1.members[i].alpha = 1;
				textPage1.members[i].alpha = 1;
				collertext.members[i].alpha = 1;
				FlxTween.tween(creditsPage1.members[i], {x: creditsPage1.members[i].x - FlxG.width * 1.5}, 1.4, {
					ease: FlxEase.cubeOut,
					startDelay: 0.4,
				});

				FlxTween.tween(collertext.members[i], {x: collertext.members[i].x - FlxG.width * 1.5}, 1.4, {
					ease: FlxEase.cubeOut,
					startDelay: 0.4,
				});

				FlxTween.tween(textPage1.members[i], {x: textPage1.members[i].x - FlxG.width * 1.5}, 1.4, {
					ease: FlxEase.cubeOut,
					startDelay: 0.4,
				});
			}
		//}
		/*if (curPage > 0) {
			for (i in (4 * (curPage - 1))...dumb2) {
				creditsPage1.members[i].visible = false;
				textPage1.members[i].visible = false;
			}
		}

		if (curPage < 2) {
			for (i in (4 * (curPage + 1))...dumb3) {
				creditsPage1.members[i].visible = false;
				textPage1.members[i].visible = false;
			}
		}*/
	}
	override function beatHit()
	{
		super.beatHit();
		
	}
}
