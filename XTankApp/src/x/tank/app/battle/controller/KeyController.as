package x.tank.app.battle.controller
{
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	import onlineproto.cs_tank_move;
	import onlineproto.cs_tank_move_stop;
	
	import x.game.manager.StageManager;
	import x.game.manager.TimeManager;
	import x.game.net.post.SimplePost;
	import x.tank.app.battle.map.tank.Tank;
	import x.tank.app.battle.utils.Direction;
	import x.tank.net.CommandSet;

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
						_tank.walk(_keyDirMapping[String(event.keyCode)],new Point(_tank.x,_tank.y)) ;
						//
						var msg:cs_tank_move = new cs_tank_move() ;
						msg.dir = _tank.direction ;
						msg.startX = uint(_tank.x) ;
						msg.startY = uint(_tank.y) ;
						msg.startTime = TimeManager.serverTime ;
						//
						new SimplePost(CommandSet.$304.id,msg).send() ; 
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
						_tank.wait(_tank.direction,new Point(_tank.x,_tank.y)) ;
						//
						var msg:cs_tank_move_stop = new cs_tank_move_stop() ;
						msg.stopX = uint(_tank.x) ;
						msg.stopY = uint(_tank.y) ;
						//
						new SimplePost(CommandSet.$305.id,msg).send() ;
					}
					break;
				}
			}
		}
	}
}