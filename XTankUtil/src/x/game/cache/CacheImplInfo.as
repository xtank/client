package x.game.cache
{
	public class CacheImplInfo
	{
		public var cls:Class;
		public var maxCount:uint;
		public var loadType:String;

		public function CacheImplInfo(cls:Class, maxCount:uint, loadType:String)
		{
			this.cls=cls;
			this.maxCount=maxCount;
			this.loadType=loadType;
			super();
		}
	}
}
