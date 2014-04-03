package x.game.tick
{    
    import flash.utils.Dictionary;

    /**
     *
     * @author fraser
     *
     */
    final public class FrameTicker extends BaseTicker
    {
		//实用的静态方法
        public static var sTickerId:int = 0;
        public static var sTickerMap:Dictionary = new Dictionary();

        /**
         * 设置一个以帧率计算的回调
         *
         * @param callback:回调
         * @param frequency:频率
         */
        public static function setInterval(callback:Function, frequency:int = 1):int
        {
            var ticker:FrameTicker = new FrameTicker(frequency, 0, callback);
			ticker.tickId = ++sTickerId % int.MAX_VALUE;
            ticker.start();
            sTickerMap[ticker.tickId] = ticker;
            return ticker.tickId;
        }

        /**
         * 清除回调
         */
        public static function clearInterval(id:int):void
        {
            if (id == 0)
            {
                return;
            }

            var ticker:FrameTicker = sTickerMap[id];
            if (ticker != null)
            {
                ticker.dispose();
                delete sTickerMap[id];
            }
        }
		
		/////////////////////////////////////////////////////////////
		/////////////////////////////////////////////////////////////
		/////////////////////////////////////////////////////////////
        /* 频率  */
        private var _frequency:int;
		/** 重复次数*/
        private var _repeatCount:int;

        public function FrameTicker(frequency:int = 1, repeatCount:int = 0, 
								timerFunc:Function = null, compFunc:Function = null)
        {
			super(timerFunc, compFunc);
            //
            _frequency = Math.max(1, frequency);
            _repeatCount = Math.max(0, repeatCount);
        }

        override public function dispose():void
        {
            super.dispose() ;
			_frequency = 0 ;
			_repeatCount = 0 ;
        }

        override public function dataClear():void 
        {
            super.dataClear() ;
            _frequency = 0;
            _repeatCount = 0;
        }
		
		// 次数
        private var _totalCount:int;
		// 计数
        private var _tickCount:int;

        override public function doTick(dtime:Number):void
        {
            ++_tickCount;
			//
            if (_tickCount == _frequency)
            {
                _tickCount = 0;
                ++_totalCount;
                //
                if (_timerFunc != null)
                {
                    _timerFunc(dtime);
                }
                //
                if (_repeatCount > 0 && _totalCount >= _repeatCount)
                {
                    if (_compFunc != null)
                    {
                        _compFunc();
                    }
					//
                    clearInterval(tickId) ;
                }
            }
        }
    }
}
