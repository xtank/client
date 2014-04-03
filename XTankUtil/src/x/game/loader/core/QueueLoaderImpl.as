package x.game.loader.core
{
    import flash.events.ErrorEvent;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.system.ApplicationDomain;
    import flash.utils.clearTimeout;
    import flash.utils.setTimeout;
    
    import x.game.log.core.Logger;

    /**
     * 统一资源加载执行类
     * @author tb
     *
     */
    public class QueueLoaderImpl
    {
        private static const SORT_NAME:String = "priority";
        private static const TIMEOUT_MAX:uint = 2; //最大超时次数
        //
        private var _waitList:Array = []; //需要加载的资源列表，内容类型：QueueInfo
        private var _isStop:Boolean = false; //是否停止
        private var _loader:IntegrateLoader = new IntegrateLoader(); //加载器
        private var _timeoutID:uint; //超时ID

        public function QueueLoaderImpl()
        {
        }

        /**
         * 当前正在加载的信息
         * @return
         *
         */
        public function get currentInfo():QueueInfo
        {
            return _loader.info;
        }

        public function get waitList():Array
        {
            return _waitList;
        }

        //--------------------------------------------------
        // public function
        //--------------------------------------------------

        public function load(url:String, type:String, complete:Function, error:Function = null, 
            data:* = null, priority:int = 2, open:Function = null, progress:Function = null):void
        {
            if (hasCompleteHandler(url, complete))
            {
                return;
            }
            //
            var info:QueueInfo = new QueueInfo();
            info.url = url;
            info.type = type;
            info.data = data;
            info.priority = priority;
            info.completeHandler = complete;
            info.errorHandler = error;
            info.openHandler = open;
            info.progressHandler = progress;
            _waitList.push(info);
            _waitList.sortOn(SORT_NAME, Array.NUMERIC);
            //加载
            if (priority == QueuePriority.COERCE)
            {
                if (_loader.info.priority != QueuePriority.COERCE)
                {
                    nextLoad(true);
                    return;
                }
            }
            nextLoad();
        }

        /**
         * 添加预加载
         * @param url
         *
         */
        public function addBef(url:String, type:String):void
        {
            var info:QueueInfo;
            for each (info in _waitList)
            {
                if (info.url == url)
                {
                    return;
                }
            }
            info = new QueueInfo();
            info.priority = QueuePriority.LOW;
            info.url = url;
            info.type = type;
            _waitList.push(info);
            //
            nextLoad();
        }

        /**
         * 停止加载
         *
         */
        public function pause():void
        {
            _isStop = true;
            close();
        }

        /**
         * 开启加载
         *
         */
        public function resume():void
        {
            if (_isStop)
            {
                _isStop = false;
                nextLoad(true);
            }
        }

        /**
         * 取消全部加载项
         *
         */
        public function cancelAll():void
        {
            close();
            for each (var info:QueueInfo in _waitList)
            {
                info.dispose();
            }
            _waitList.length = 0;
        }

        /**
         * 取消指定的加载
         * @param url
         * @param complete
         *
         */
        public function cancel(url:String, complete:Function):void
        {
            if (complete == null)
            {
                return;
            }
            //
            var info:QueueInfo = _loader.info;
            if (info)
            {
                if (info.url == url)
                {
                    if (info.completeHandler == complete)
                    {
                        close();
                    }
                }
            }
            //
            var len:int = _waitList.length;
            for (var i:int = 0; i < len; i++)
            {
                info = _waitList[i];
                if (info.url == url)
                {
                    if (info.completeHandler == complete)
                    {
                        _waitList.splice(i, 1);
                        info.dispose();
                        break;
                    }
                }
            }
            //
            nextLoad();
        }

        /**
         * 取消指定url的全部加载
         * @param url
         *
         */
        public function cancelURL(url:String):void
        {
            var info:QueueInfo = _loader.info;
            if (info)
            {
                if (info.url == url)
                {
                    close();
                }
            }
            removeURL(url);
            //
            nextLoad();
        }

        /**
         * 取消指定的侦听项
         * @param complete
         *
         */
        public function cancelHandler(complete:Function):void
        {
            if (complete == null)
            {
                return;
            }
            //
            var info:QueueInfo = _loader.info;
            if (info)
            {
                if (info.completeHandler == complete)
                {
                    close();
                }
            }
            removeHandler(complete);
            nextLoad();
        }

        /**
         * 从data中指定的属性和值取消加载
         * @param attribute
         * @param value
         *
         */
        public function cancelData(attribute:String, value:*, url:String = null):void
        {
            if (attribute == null || attribute == "")
            {
                return;
            }
            var info:QueueInfo = _loader.info;
            if (info && info.data)
            {
                if (url == null)
                {
                    if (attribute in info.data)
                    {
                        if (info.data[attribute] == value)
                        {
                            close();
                        }
                    }
                }
                else
                {
                    if (info.url == url)
                    {
                        if (attribute in info.data)
                        {
                            if (info.data[attribute] == value)
                            {
                                close();
                            }
                        }
                    }
                }
            }
            removeData(attribute, value, url);
            nextLoad();
        }

        public function hasCompleteHandlerFromData(url:String, attribute:String, complete:Function):Boolean
        {
            for each (var info:QueueInfo in _waitList)
            {
                if (info.url == url && info.data)
                {
                    if (attribute in info.data)
                    {
                        if (info.data[attribute] == complete)
                        {
                            return true;
                        }
                    }
                }
            }
            return false;
        }

        //--------------------------------------------------
        // private function
        //--------------------------------------------------

        private function hasCompleteHandler(url:String, complete:Function):Boolean
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

        private function close():void
        {
            _loader.removeEventListener(Event.OPEN, onOpen);
            _loader.removeEventListener(Event.COMPLETE, onComplete);
            _loader.removeEventListener(ProgressEvent.PROGRESS, onProgress);
            _loader.removeEventListener(ErrorEvent.ERROR, onError);
            _loader.close();
        }

        /**
         * 从等待列表中移除要加载的信息
         * @param url
         *
         */
        private function removeURL(url:String):void
        {
            var len:int = _waitList.length;
            for (var i:int = 0; i < len; i++)
            {
                var info:QueueInfo = _waitList[i];
                if (info)
                {
                    if (info.url == url)
                    {
                        _waitList.splice(i, 1);
                        i--;
                        info.dispose();
                    }
                }
            }
        }

        private function removeHandler(complete:Function):void
        {
            var len:int = _waitList.length;
            for (var i:int = 0; i < len; i++)
            {
                var info:QueueInfo = _waitList[i];
                if (info)
                {
                    if (info.completeHandler == complete)
                    {
                        _waitList.splice(i, 1);
                        i--;
                        info.dispose();
                    }
                }
            }
        }

        private function removeData(attribute:String, value:*, url:String = null):void
        {
            var len:int = _waitList.length;
            for (var i:int = 0; i < len; i++)
            {
                var info:QueueInfo = _waitList[i];
                if (info && info.data)
                {
                    if (url == null)
                    {
                        if (attribute in info.data)
                        {
                            if (info.data[attribute] == value)
                            {
                                _waitList.splice(i, 1);
                                i--;
                                info.dispose();
                            }
                        }
                    }
                    else
                    {
                        if (info.url == url)
                        {
                            if (attribute in info.data)
                            {
                                if (info.data[attribute] == value)
                                {
                                    _waitList.splice(i, 1);
                                    i--;
                                    info.dispose();
                                }
                            }
                        }
                    }

                }
            }
        }

        /**
         * 下一个加载
         *
         */
        private function nextLoad(coerce:Boolean = false):void
        {
            if (coerce)
            {
                close();
            }
            else
            {
                if (_loader.info)
                {
                    return;
                }
            }
            clearTimeout(_timeoutID);
            if (_isStop)
            {
                return;
            }
            //是否还有可加载信息
            if (_waitList.length > 0)
            {
                _loader.addEventListener(Event.OPEN, onOpen);
                _loader.addEventListener(Event.COMPLETE, onComplete);
                _loader.addEventListener(ProgressEvent.PROGRESS, onProgress);
                _loader.addEventListener(ErrorEvent.ERROR, onError);
                var info:QueueInfo = _waitList[0];
                _loader.load(info);
                _timeoutID = setTimeout(onTimeout, 5000);
                if (info.openHandler != null)
                {
                    info.openHandler(new ContentInfo(info.url, info.type, null, null, info.data));
                }
            }
        }

        private function onTimeout():void
        {
            if (_loader.info)
            {
                if (_loader.info.timeCount >= TIMEOUT_MAX)
                {
                    removeURL(_loader.info.url);
                }
                else
                {
                    _loader.info.timeCount++;
                }
                nextLoad(true);
            }
        }

        private function getOuts(url:String):Array
        {
            var outs:Array = [];
            var len:int = _waitList.length;
            for (var i:int = 0; i < len; i++)
            {
                var info:QueueInfo = _waitList[i];
                if (info)
                {
                    if (info.url == url)
                    {
                        _waitList.splice(i, 1);
                        i--;
                        outs.push(info);
                    }
                }
            }
            return outs;
        }

        //--------------------------------------------------
        // event
        //--------------------------------------------------

        private function onOpen(event:Event):void
        {
            clearTimeout(_timeoutID);
        }

        private function onComplete(event:IntegrateLoaderEvent):void
        {
            var info:QueueInfo = _loader.info;
            close();
            var outs:Array = getOuts(info.url);
            nextLoad();
            outComplete(outs, event.content, event.domain);
        }

        private function outComplete(outs:Array, content:*, domain:ApplicationDomain):void
        {
            for each (var info:QueueInfo in outs)
            {
                if (info.completeHandler != null)
                {
                    info.completeHandler(new ContentInfo(info.url, info.type, content, domain, info.data));
                }
                info.dispose();
            }
        }

        private function onError(event:ErrorEvent):void
        {
            clearTimeout(_timeoutID);
            var info:QueueInfo = _loader.info;
            close();
            Logger.error("Loader onError --->>> " + info.url);
            var outs:Array = getOuts(info.url);
            nextLoad();
            outError(outs);
        }

        private function outError(outs:Array):void
        {
            for each (var info:QueueInfo in outs)
            {
                if (info.errorHandler != null)
                {
                    info.errorHandler(new ContentInfo(info.url, info.type, null, null, info.data));
                }
                info.dispose();
            }
        }

        private function onProgress(event:ProgressEvent):void
        {
            var info:QueueInfo = _loader.info;
            if (info.progressHandler != null)
            {
                info.progressHandler(event);
            }
        }
    }
}


