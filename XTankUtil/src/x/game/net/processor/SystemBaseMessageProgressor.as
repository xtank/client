package x.game.net.processor
{
	import x.game.net.response.XMessageEvent;
	
	public class SystemBaseMessageProgressor implements IMessageProcessor
	{
		public function SystemBaseMessageProgressor()
		{
			setup() ;
		}
		
		public function setup():void
		{
		}
		
		public function onMessage(event:XMessageEvent):void
		{
		}
		
		public function dispose():void
		{
		}
	}
}