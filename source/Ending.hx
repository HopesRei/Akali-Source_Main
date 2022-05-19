package;
import flixel.*;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class Ending extends FlxState
{

	var _goodEnding:Bool = false;
	

	public function new(goodEnding:Bool = true) 
	{
		super();
		_goodEnding = goodEnding;
		
	}
	
	override function create() 
	{
		super.create();
		
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image("bg/to_be_continued", 'akali'));
		add(bg);
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		if (FlxG.keys.pressed.ENTER){
			endIt();
		}
		
	}
	
	
	public function endIt(e:FlxTimer=null){
		trace("ENDING");
		FlxG.switchState(new MainMenuState());
	}
	
}
