package x.game.tick
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.utils.getTimer;

	/**
	 * Tick运行器 
	 * @author fraser
	 * 
	 */
    final public class TickerLauncher
    {	
		public static var instance:TickerLauncher = new TickerLauncher() ;
		private static var _isLaunching:Boolean = false ;
        
        public static function start():void
        {
            _isLaunching = true ;
			instance.start() ;
        }

        public static function stop():void
        {
            _isLaunching = false ;
			instance.stop() ;
        }
		
		//////////////////////////////////////////////////////////////
		public var tickerList:Array = [];
		private var _eventDispatcher:Sprite = new Sprite() ;
		private var _lastTime:Number = 0;
		
        private function start():void
		{
			_lastTime = getTimer() ;
			_eventDispatcher.addEventListener(Event.ENTER_FRAME, onUpdate);
		}
		
        private function stop():void
		{
			_eventDispatcher.removeEventListener(Event.ENTER_FRAME, onUpdate);
		}
		
        private function onUpdate(event:Event):void
        {
			// 时间差
            var time:Number = getTimer() ;
            var dtime:Number = time - _lastTime;
            _lastTime = time;
			doTick(dtime);
        }

        private function doTick(dtime:uint):void
        {
            for each (var ticker:BaseTicker in tickerList)
            {
                ticker.doTick(dtime);
            }
        }
        
        public function get length():int
        {
            return tickerList.length;
        }

        public function addTicker(ticker:BaseTicker):void
        {
            if(_isLaunching)
            {
                tickerList.push(ticker);
            }
            else
            {
                throw new Error("Ticker Not Launching.");
            }
        }

        public function removeTicker(ticker:BaseTicker):void
        {
            var index:int = tickerList.indexOf(ticker);
            if (index != -1)
            {
                tickerList.splice(index, 1);
            }
        }
    }
}
