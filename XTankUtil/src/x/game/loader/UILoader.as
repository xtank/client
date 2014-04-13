package x.game.loader
{
    import flash.events.ProgressEvent;
    
    import x.game.loader.core.ContentInfo;
    import x.game.loader.core.QueueInfo;
    import x.game.loader.core.QueueLoaderImpl;
    import x.game.loader.loadingUI.ILoaderUI;

    /**
     * 有loading显示的加载器
     * @author fraser
     *
     */
    public class UILoader
    {
        private static var _loaderUI:ILoaderUI ;
        private static var _loader:QueueLoaderImpl = new QueueLoaderImpl();
        private static var _waitList:Array = [];
        
        public static function setLoaderUI(ui:ILoaderUI):void
        {
            _loaderUI = ui ;
        }
        
        /**
         * 开始加载  (显示进度条)
         * @param url       地址
         * @param type      类型 LoadType
         * @param complete  加载完成方法回调
         * @param error     加载错误方法回调
         * @param title  	LoadingBar显示的标题
         * @param open      加载开始方法回调
         * @param progress  加载进度方法回调
         *
         */
        public static function load(url:String, 
                                    type:String, 
                                    complete:Function,
									error:Function = null, 
                                    title:String = "",
									data:* = null, 
                                    open:Function = null, 
									progress:Function = null,
									isCover:Boolean = true):void
        {
            if (hasWaitList(url, complete))
            {
                return;
            }

            var info:QueueInfo = new QueueInfo();
            info.url = url;
            info.type = type;
			info.isCover = isCover ;
            info.title = title;
            info.data = data;
            info.completeHandler = complete;
            info.errorHandler = error;
            info.openHandler = open;
            info.progressHandler = progress;
            _waitList.push(info);
            //
            _loader.load(url, type, onComplete, onError, null, 2, onOpen, onProgress,isCover);
        }

        /**
         * 取消当前加载
         * @param complete 加载完成的 回调方法
         *
         */
        public static function cancel(url:String, complete:Function):void
        {
            var b:Boolean = false;
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
            _loader.cancel(url, onComplete);
        }

        //--------------------------------------------------
        // private
        //--------------------------------------------------

        private static function hasWaitList(url:String, complete:Function):Boolean
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

        private static function onOpen(contentInfo:ContentInfo):void
        {
            var len:int = _waitList.length;
            for (var i:int = 0; i < len; i++)
            {
                var info:QueueInfo = _waitList[i];
                if (info)
                {
                    if (info.url == contentInfo.url)
                    {
                        _loaderUI.show(info.title,info.isCover);
                        
                        if (info.openHandler != null)
                        {
                            info.openHandler(new ContentInfo(info.url, info.type, null, null, info.data,info.isCover));
                        }
                        break;
                    }
                }
            }
        }

        private static function onComplete(contentInfo:ContentInfo):void
        {
            var len:int = _waitList.length;
            for (var i:int = 0; i < len; i++)
            {
                var info:QueueInfo = _waitList[i];
                if (info != null)
                {
                    if (info.url == contentInfo.url)
                    {
                        _waitList.splice(i, 1);
                        i--;
                        if (info.completeHandler != null)
                        {
                            info.completeHandler(new ContentInfo(info.url, info.type, contentInfo.content, contentInfo.domain, info.data,info.isCover));
                        }
                        info.dispose();
                    }
                }
            }
            _loaderUI.hide();
        }

        private static function onError(contentInfo:ContentInfo):void
        {
            var len:int = _waitList.length;
            for (var i:int = 0; i < len; i++)
            {
                var info:QueueInfo = _waitList[i];
                if (info != null)
                {
                    if (info.url == contentInfo.url)
                    {
                        _waitList.splice(i, 1);
                        i--;
                        if (info.errorHandler != null)
                        {
                            info.errorHandler(new ContentInfo(info.url, info.type, null, null, info.data,info.isCover));
                        }
                        info.dispose();
                    }
                }
            }
            _loaderUI.hide();
        }

        private static function onProgress(event:ProgressEvent):void
        {
            _loaderUI.progressTotal(event.bytesLoaded / event.bytesTotal * 100);
			//
            if (_loader.currentInfo)
            {
                var len:int = _waitList.length;
                for (var i:int = 0; i < len; i++)
                {
                    var info:QueueInfo = _waitList[i];
                    if (info)
                    {
                        if (info.url == _loader.currentInfo.url)
                        {
                            if (info.progressHandler != null)
                            {
                                info.progressHandler(event);
                            }
                            break;
                        }
                    }
                }
            }
        }
    }
}
