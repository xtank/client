package x.tank.core.manager
{
	import flash.events.EventDispatcher;
	
	import de.polygonal.ds.HashMap;
	
	import onlineproto.room_data_t;
	
	import x.tank.core.event.RoomEvent;
	import x.tank.core.model.Room;

	public class RoomManager
	{
		private static var _rooms:HashMap = new HashMap();
		
		public static function addRoom(data:room_data_t):void
		{
			var room:Room = new Room() ;
			room.parse(data) ;
			_rooms.set(room.id,room) ;
			//
			dispatchEvent(new RoomEvent(RoomEvent.ROOM_ADD,room));
		}
		
		public static function updateRoom(data:room_data_t):void
		{
			var room:Room = getRoom(room.id) ;
			room.parse(data) ;
			//
			dispatchEvent(new RoomEvent(RoomEvent.ROOM_UPDATE,room));
		}
		
		public static function removeRoom(id:uint):void
		{
			var room:Room = getRoom(id) ; 
			_rooms.remove(room) ;
			//
			dispatchEvent(new RoomEvent(RoomEvent.ROOM_DEL,room));
		}
		
		public static function getRoom(id:uint):Room
		{
			return _rooms.get(id) as Room;
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