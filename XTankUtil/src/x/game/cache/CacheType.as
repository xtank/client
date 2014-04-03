package x.game.cache
{
    import de.polygonal.ds.HashMap;
    
    import x.game.loader.core.LoadType;

    internal class CacheType
    {
        public static const ICON:uint = 1;
        public static const TERRIAN:uint = 2;
        public static const ELEMENT:uint = 3;

        //
        private static var _infos:HashMap = new HashMap();
        private static var _cacheMap:HashMap = new HashMap();
        //
        init();

        //
        public static function init():void
        {
            _infos.set(TERRIAN, new CacheImplInfo(Object, 500, LoadType.IMAGE));
        }

		//
		public static function getLoadType(type:uint):String
        {
            var info:CacheImplInfo = _infos.get(type) as CacheImplInfo;
            return info.loadType;
        }

        //
		public static function getCacheImpl(type:uint):CacheImpl
        {
            var impl:CacheImpl = _cacheMap.get(type) as CacheImpl;
            if (impl == null)
            {
                var info:CacheImplInfo = _infos.get(type) as CacheImplInfo;
                if (info != null)
                {
                    var cls:Class = info.cls;
                    impl = new cls();
                    impl.maxCount = info.maxCount;
                }
                else
                {
                    impl = new CacheImpl();
                    impl.maxCount = 500;
                }
                _cacheMap.set(type, impl);
            }
            return impl;
        }
    }
}
