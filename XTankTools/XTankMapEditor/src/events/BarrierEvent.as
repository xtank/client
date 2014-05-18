package events
{
	import flash.events.Event;
	import flash.geom.Point;
	
	public class BarrierEvent extends Event
	{
		public static const UU:String = "uu" ;
		public static const RR:String = "rr" ;
		
		public var info:BarrierInfo ;
		public var stagePoint:Point ;
		
		public function BarrierEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}