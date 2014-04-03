package x.game.cache
{
	public class CacheManager
	{
		public static function getContent(url:String, type:uint, complete:Function, error:Function = null, data:* = null, priority:int = 2, open:Function = null, progress:Function = null):void
		{
			CacheType.getCacheImpl(type).getContent(url, CacheType.getLoadType(type), complete, error, data, priority, open, progress);
		}
		
		public static function cancel(url:String, type:uint, complete:Function):void
		{
			CacheType.getCacheImpl(type).cancel(url, complete);
		}
		
		public static function clear(type:uint):void
		{
			CacheType.getCacheImpl(type).clear();
		}
		
	}
}