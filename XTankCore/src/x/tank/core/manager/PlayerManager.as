package x.tank.core.manager
{
	import flash.events.EventDispatcher;
	
	import de.polygonal.ds.HashMap;
	
	import onlineproto.player_data_t;
	
	import x.tank.core.event.PlayerEvent;

	public class PlayerManager
	{
		private static var _players:HashMap = new HashMap();
		
		public static function addPlayer(data:player_data_t):player_data_t
		{
			_players.set(data.userid,data) ;
			dispatchEvent(new PlayerEvent(PlayerEvent.PLAYER_ADD,data)) ;
			//
			return data ;
		}
		
		public static function updatePlayer(data:player_data_t):player_data_t
		{
			var player:player_data_t = getPlayer(data.userid) ;
			player.name = data.name ;
			player.status = data.status ;
			player.teamid = data.teamid ;
			//
			dispatchEvent(new PlayerEvent(PlayerEvent.PLAYER_UPDATE,player));
			//
			return player ;
		}
		
		public static function removePlayer(userId:uint):player_data_t
		{
			var player:player_data_t = getPlayer(userId) ;
			_players.remove(player) ;
			//
			dispatchEvent(new PlayerEvent(PlayerEvent.PLAYER_DEL,player)) ;
			//
			return player ;
		}
		
		public static function getPlayer(userId:uint):player_data_t
		{
			return _players.get(userId) as player_data_t;
		}
		
		public static function hasPlayer(userId:uint):Boolean
		{
			return _players.contains(userId) ;
		}
		
		//############################################################
		//			            Event Dispatcher		
		//############################################################
		private static var _eventDispatcher:EventDispatcher = new EventDispatcher();
		
		static public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			_eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		static public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			_eventDispatcher.removeEventListener(type, listener, useCapture);
		}
		
		static public function dispatchEvent(event:PlayerEvent):Boolean
		{
			return _eventDispatcher.dispatchEvent(event);
		}
		
		static public function hasEventListener(type:String):Boolean
		{
			return _eventDispatcher.hasEventListener(type);
		}
		
		static public function willTrigger(type:String):Boolean
		{
			return _eventDispatcher.willTrigger(type);
		}
	}
}