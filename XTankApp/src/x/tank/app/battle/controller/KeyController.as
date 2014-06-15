package x.tank.app.battle.controller
{
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	import x.game.manager.StageManager;
	import x.tank.app.battle.map.tank.Tank;
	import x.tank.app.battle.utils.Direction;

	public class KeyController
	{
		private static var _tank:Tank ;
		
		public static function set tank(value:Tank):void
		{
			_tank = value ;
		}
		
		public static function active():void
		{
			StageManager.stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown) ;
			StageManager.stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp) ;
		}
		
		public static function deActive():void
		{
			StageManager.stage.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDown) ;
			StageManager.stage.removeEventListener(KeyboardEvent.KEY_UP,onKeyUp) ;
		}
		
		private static var _keyPressList:Array = [] ;
		private static const _keyDirMapping:Object = 
			{
				"87":Direction.UP,
				"65":Direction.LEFT,
				"83":Direction.DOWN,
				"68":Direction.RIGHT
			} ;
		
		private static function onKeyDown(event:KeyboardEvent):void
		{
			if(_tank == null)
			{
				return ;
			}
			//
			switch(event.keyCode)
			{
				case Keyboard.W:
				case Keyboard.A:
				case Keyboard.S:
				case Keyboard.D:
				{
					if(_keyPressList[event.keyCode] != true)
					{
						_keyPressList[event.keyCode] = true ;
						_tank.walk(_keyDirMapping[String(event.keyCode)],new Point(_tank.mapx,_tank.mapy)) ;
					}
					break;
				}
				case Keyboard.J:
					break;
			}
		}
		
		private static function onKeyUp(event:KeyboardEvent):void
		{
			if(_tank == null)
			{
				return ;
			}
			//
			//
			switch(event.keyCode)
			{
				case Keyboard.W:
				case Keyboard.A:
				case Keyboard.S:
				case Keyboard.D:
				{
					if(_keyPressList[event.keyCode] == true)
					{
						_keyPressList[event.keyCode] = false ;
						_tank.wait(_tank.direction,new Point(_tank.mapx,_tank.mapy)) ;
					}
					break;
				}
			}
		}
	}
}