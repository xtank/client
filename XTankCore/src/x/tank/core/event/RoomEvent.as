package x.tank.core.event
{
	import flash.events.Event;
	
	import x.tank.core.model.Room;
	
	public class RoomEvent extends Event
	{
		public static const ROOM_ADD:String = "ROOM_ADD" ;
		public static const ROOM_UPDATE:String = "ROOM_UPDATE" ;
		public static const ROOM_DEL:String = "ROOM_DEL" ;
		
		public var room:Room ;
		
		public function RoomEvent(type:String, room:Room,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.room = room ;
		}
	}
}