package x.game.tick
{
    import x.game.core.IDataClearable;
    import x.game.core.IDisposeable;

    /**
     * tick基类
     * @author fraser
     *
     */
    public class BaseTicker implements IDisposeable,IDataClearable
    {
        protected var _timerFunc:Function;
		protected var _compFunc:Function;
		//
		public var tickId:uint ;

        public function BaseTicker(timerFunc:Function = null, compFunc:Function = null)
        {
            this._timerFunc = timerFunc;
            this._compFunc = compFunc;
        }

        public function start():void
        {
            TickerLauncher.instance.addTicker(this);
        }

        public function stop():void
        {
            TickerLauncher.instance.removeTicker(this);
        }

		/**
		 * 该帧使用的耗时 
		 * @param dtime  单位ms
		 * 
		 */
        public function doTick(dtime:Number):void
        {
			// override by child
        }

		public function dataClear():void 
		{
			_timerFunc = null;
            _compFunc = null;
		}

        public function dispose():void
        {
            stop();
			dataClear() ;
        }
    }
}
