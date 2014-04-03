package x.game.loader.core
{
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	
	internal class IntegrateLoaderEvent extends Event
	{
		public static const COMPLETE:String = "complete";
		
		private var _content:*;
		private var _domain:ApplicationDomain;
		public function IntegrateLoaderEvent(type:String,content:*,domain:ApplicationDomain=null)
		{
			super(type);
			_content = content;
			_domain = domain;
		}
		public function get content():*
		{
			return _content;
		}
		public function get domain():ApplicationDomain
		{
			return _domain;
		}
	}
}