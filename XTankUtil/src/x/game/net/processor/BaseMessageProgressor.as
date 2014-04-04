package x.game.net.processor
{
	import x.game.net.response.XMessageEvent;
	
	public class BaseMessageProgressor implements IMessageProcessor
	{
		public function BaseMessageProgressor()
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