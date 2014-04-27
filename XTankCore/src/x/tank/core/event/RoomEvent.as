package x.tank.core.event
{
	import flash.events.Event;
	
	import onlineproto.room_data_t;
	
	public class RoomEvent extends Event
	{
		public static const ROOM_ADD:String = "ROOM_ADD" ;
		public static const ROOM_UPDATE:String = "ROOM_UPDATE" ;
		public static const ROOM_DEL:String = "ROOM_DEL" ;
		//
		public static const ROOM_LIST_UPDATE:String = "ROOM_LIST_UPDATE" ;
		
		public var room:room_data_t ;
		
		public function RoomEvent(type:String, room:room_data_t = null ,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.room = room ;
		}
	}
}