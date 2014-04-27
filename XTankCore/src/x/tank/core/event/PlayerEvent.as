package x.tank.core.event
{
	import flash.events.Event;
	
	import onlineproto.player_data_t;
	
	public class PlayerEvent extends Event
	{
		public static const PLAYER_ADD:String = "PLAYER_ADD" ;
		public static const PLAYER_DEL:String = "PLAYER_DEL" ;
		public static const PLAYER_UPDATE:String = "PLAYER_UPDATE" ;
		
		public var player:player_data_t ;
		
		public function PlayerEvent(type:String, player:player_data_t,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.player = player ;
		}
	}
}