package x.game.cache
{
	import flash.system.ApplicationDomain;
	
	import x.game.core.IDisposeable;

	public class CacheInfo implements IDisposeable
	{
		public var url:String ;
		public var content:* ;
		public var domain:ApplicationDomain;

		public function dispose():void
		{
			content = null;
			domain = null;
		}
	}
}
