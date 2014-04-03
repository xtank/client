package x.game.tick
{    
    import flash.utils.Dictionary;

    /**
     * 倒计时定时器
     * @author fraser
     *
     */
    final public class TimeTicker extends BaseTicker
    {
        //实用的静态方法
        public static var sTickerId:int = 0;
        public static var sTickerMap:Dictionary = new Dictionary();

        /**
         * 移除一个定时器
         *
         * @param id:由setTimeout返回的id
         */
        public static function clear(id:int):void
        {
            if (id == 0)
            {
                return;
            }
            var ticker:TimeTicker = sTickerMap[id];
            if (ticker)
            {
                ticker.dispose();
                delete sTickerMap[id];
            }
        }

        /**
         * 设置一个指定时间后回调的定时器
         *
         * @param delay:延迟时间
         * @param callback:回调
         */
        public static function setTimeout(delay:Number, callback:Function):int
        {
            var ticker:TimeTicker = new TimeTicker(delay, 1, null, onTimeout);
			ticker.tickId = ++sTickerId % int.MAX_VALUE;
            ticker.start();
            sTickerMap[ticker.tickId] = ticker;
            return ticker.tickId;

            function onTimeout():void
            {
                clear(ticker.tickId);
                callback();
            }
        }

        /**
         * 设置一个定时器，间隔delay(ms)执行一次
         *
         * @param delay:间隔时间 (ms)
         * @param callback:回调
         * @param immediately:是否立即回调一次
         *
         */
        public static function setInterval(delay:Number, callback:Function):int
        {
            var ticker:TimeTicker = new TimeTicker(delay, 0, callback);
			ticker.tickId = ++sTickerId % int.MAX_VALUE;
            ticker.start();
            sTickerMap[ticker.tickId] = ticker;
            return ticker.tickId;
        }

        /**
         * 设置一个指定次数的定时器
         *
         * @param delay:间隔时间
         * @param repeatCount:次数
         * @param callback:回调
         * @param complete:完成后的回调
         */
        public static function setTicker(delay:Number, repeatCount:int, callback:Function, compFunc:Function = null):int
        {
            var ticker:TimeTicker = new TimeTicker(delay, repeatCount, callback, onComplete);
			ticker.tickId = ++sTickerId % int.MAX_VALUE;
            ticker.start();
            sTickerMap[ticker.tickId] = ticker;
            return ticker.tickId;

            function onComplete():void
            {
                if (compFunc != null)
                {
                    compFunc();
                }
                clear(ticker.tickId);
            }
        }
		
		/////////////////////////////////////////////////////////////
        private var _delay:Number;
        private var _repeatCount:int;

        public function TimeTicker(delay:Number, repeatCount:int = 0, timerFunc:Function = null, compFunc:Function = null)
        {
            super(timerFunc, compFunc);
            //
            _delay = Math.abs(delay);
            _repeatCount = Math.max(0, repeatCount);
			_tickTime = 0 ;
			_tickCount = 0 ;
        }

        override public function dispose():void
        {
            super.dispose() ;
			_delay = 0 ;
			_repeatCount = 0 ;
        }

        override public function dataClear():void 
        {
            super.dataClear() ;
            _delay = 0;
            _repeatCount = 0;
        }

        private var _tickTime:Number;
        private var _tickCount:int;

        override public function doTick(dtime:Number):void
        {
            _tickTime += dtime;

            while (_tickTime >= _delay)
            {
                _tickTime -= _delay;
                //
                ++_tickCount;
                if (_timerFunc != null)
                {
					
                    _timerFunc(dtime);
                }
                //
                if (_repeatCount > 0 && _tickCount >= _repeatCount)
                {
                    if (_compFunc != null)
                    {
                        _compFunc();
                    }
                    clear(tickId);
                    return;
                }
            }
        }
    }
}
