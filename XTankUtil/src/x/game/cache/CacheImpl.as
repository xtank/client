package x.game.cache
{
    import x.game.core.IDisposeable;
    import x.game.loader.core.ContentInfo;
    import x.game.loader.core.QueueInfo;
    import x.game.loader.core.QueueLoader;


    /** 缓存处理类  */
    public class CacheImpl implements IDisposeable
    {
        /**  最大缓存数  */
        public var maxCount:uint;
        /** 已缓存列表 */
        protected var _cacheList:Array = [];
        /** 等待加载列表*/
        protected var _waitList:Array = [];

        public function dispose():void
        {
            clear();
            _waitList = null;
            _cacheList = null;
        }

        public function clear():void
        {
            for each (var winfo:QueueInfo in _waitList)
            {
                winfo.dispose();
            }
            for each (var cinfo:CacheInfo in _cacheList)
            {
                cinfo.dispose();
            }
            //
            _waitList.splice(0, _waitList.length);
            _cacheList.splice(0, _cacheList.length);
        }

        public function getContent(url:String, type:String, complete:Function, error:Function = null, data:* = null, priority:int = 2, open:Function = null, progress:Function = null):void
        {
            for each (var cacheInfo:CacheInfo in _cacheList)
            {
                if (cacheInfo.url == url)
                {
                    parseOutput(url, type, complete, cacheInfo, data);
                    return;
                }
            }
            //
            if (hasWaitList(url, complete))
            {
                return ;
            }
            //
            var info:QueueInfo = new QueueInfo();
            info.url = url;
            info.type = type;
            info.data = data;
            info.completeHandler = complete;
            info.errorHandler = error;
            _waitList.push(info);
            //
            QueueLoader.load(url, type, onComplete, onError, data, priority, open, progress);
        }

        public function cancel(url:String, complete:Function):void
        {
            var b:Boolean = false;
			//
            var len:int = _waitList.length;
            var info:QueueInfo;
            for (var i:int = 0; i < len; i++)
            {
                info = _waitList[i];
                if (info.url == url)
                {
                    if (info.completeHandler == complete)
                    {
                        _waitList.splice(i, 1);
                        info.dispose();
                        b = true;
                        break;
                    }
                }
            }
            if (b == false)
            {
                return;
            }
            for each (info in _waitList)
            {
                if (info.url == url)
                {
                    return;
                }
            }
            //
            QueueLoader.cancel(url, onComplete);
        }

        protected function onComplete(contentInfo:ContentInfo):void
        {
            var len:int = _waitList.length;
            for (var i:int = 0; i < len; i++)
            {
                var waitInfo:QueueInfo = _waitList[i];
                if (waitInfo != null)
                {
                    if (waitInfo.url == contentInfo.url)
                    {
                        _waitList.splice(i, 1);
                        i--;
                        var cacheInfo:CacheInfo;
                        for each (var cacheItem:CacheInfo in _cacheList)
                        {
                            if (cacheItem.url == waitInfo.url)
                            {
                                cacheInfo = cacheItem;
                                break;
                            }
                        }
                        if (cacheInfo == null)
                        {
                            cacheInfo = new CacheInfo();
                            cacheInfo.url = waitInfo.url;
                            //
                            parseContent(cacheInfo, contentInfo);
                            addCache(cacheInfo);
                        }
                        if (waitInfo.completeHandler != null)
                        {
                            parseOutput(waitInfo.url, contentInfo.type, waitInfo.completeHandler, cacheInfo, waitInfo.data);
                        }
                        waitInfo.dispose();
                    }
                }
            }
        }

        //--------------------------------------------------
        // 
        //--------------------------------------------------

        private function hasWaitList(url:String, complete:Function):Boolean
        {
            for each (var info:QueueInfo in _waitList)
            {
                if (info.url == url)
                {
                    if (info.completeHandler == complete)
                    {
                        return true;
                    }
                }
            }
            return false;
        }

        private function addCache(info:CacheInfo):void
        {
            var len:int = _cacheList.length;
            if (len > maxCount)
            {
                parseCache(_cacheList);
            }
            _cacheList.push(info);
        }

        private function onError(contentInfo:ContentInfo):void
        {
            var len:int = _waitList.length;
            for (var i:int = 0; i < len; i++)
            {
                var info:QueueInfo = _waitList[i];
                if (info)
                {
                    if (info.url == contentInfo.url)
                    {
                        _waitList.splice(i, 1);
                        i--;
                        if (info.errorHandler != null)
                        {
                            info.errorHandler(new ContentInfo(info.url, contentInfo.type, null, null, info.data));
                        }
                        info.dispose();
                    }
                }
            }
        }

        //--------------------------------------------------
        // 
        //--------------------------------------------------

        /** 处理输出方法（在调用complete方法时） */
        protected function parseOutput(url:String, type:String, complete:Function, cacheInfo:CacheInfo, data:* = null):void
        {
            complete(new ContentInfo(url, type, cacheInfo.content, cacheInfo.domain, data));
        }

        /**  处理缓存方法（在缓存大于最大缓存数，移除缓存中）  */
        protected function parseCache(cacheList:Array):void
        {
            var info:CacheInfo = cacheList.shift();
            info.dispose();
        }

        /** 处理内容方法（在加载完成后，添加缓存前）  */
        protected function parseContent(cacheInfo:CacheInfo, contentInfo:ContentInfo):void
        {
            cacheInfo.content = contentInfo.content;
            cacheInfo.domain = contentInfo.domain;
        }
    }
}
