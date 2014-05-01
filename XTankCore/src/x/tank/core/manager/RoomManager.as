package x.tank.core.manager
{
	import flash.events.EventDispatcher;
	
	import de.polygonal.ds.HashMap;
	
	import onlineproto.player_data_t;
	import onlineproto.room_data_t;
	
	import x.tank.core.event.RoomEvent;

	public class RoomManager
	{
		private static var _rooms:HashMap = new HashMap();
		
		public static function addRoom(data:room_data_t):void
		{
			_rooms.set(data.id,data) ;
			//
			dispatchEvent(new RoomEvent(RoomEvent.ROOM_ADD,data));
		}
		
		public static function updateRoom(data:room_data_t):void
		{
			var room:room_data_t = getRoom(data.id) ;
			room.ownerid = data.ownerid;
			room.status = data.status;
			room.mapid = data.mapid;
			room.passwd = data.passwd;
			room.name = data.name ;
			//
			var len:uint = data.playlist.length ;
			var player:player_data_t ;
			for(var i:uint = 0;i<len;i++)
			{
				player = data.playlist[i] ;
				if(PlayerManager.hasPlayer(player.userid) )
				{
					data.playlist[i] = PlayerManager.updatePlayer(player) ;
				}
				else
				{
					data.playlist[i] = PlayerManager.addPlayer(player) ;
				}
			}
			room.playlist = data.playlist ;
			//
			dispatchEvent(new RoomEvent(RoomEvent.ROOM_UPDATE,data));
		}
		
		public static function removeRoom(roomId:uint):void
		{
			var room:room_data_t = getRoom(roomId) ; 
			_rooms.remove(room) ;
			//
			dispatchEvent(new RoomEvent(RoomEvent.ROOM_DEL,room));
		}
		
		public static function getRoom(roomId:uint):room_data_t
		{
			return _rooms.get(roomId) as room_data_t;
		}
		
		public static function hasRoom(roomId:uint):Boolean
		{
			return _rooms.hasKey(roomId) ;
		}
		
		public static function getRooms():Array
		{
			return _rooms.toArray() ;
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
		
		static public function dispatchEvent(event:RoomEvent):Boolean
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