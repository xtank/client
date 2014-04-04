package x.tank.core.event
{
	import flash.events.Event;
	
	import x.tank.core.model.Player;
	
	public class PlayerEvent extends Event
	{
		public static const PLAYER_ADD:String = "PLAYER_ADD" ;
		public static const PLAYER_DEL:String = "PLAYER_DEL" ;
		public static const PLAYER_UPDATE:String = "PLAYER_UPDATE" ;
		
		public var player:Player ;
		
		public function PlayerEvent(type:String, player:Player,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.player = player ;
		}
	}
}