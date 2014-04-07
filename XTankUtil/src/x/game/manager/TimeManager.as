package x.game.manager
{
	import flash.utils.getTimer;

	public class TimeManager
	{
		static private var _serverTime:int ; // s 
		// 网络延时 （单程）
		static private var _delayTime:int ; // ms 
		//
		static private var _date:Date ;
		/////////////////////////////////////
		
		static private var _refreshTag:int ;
		
		public static function updateDelayTime(requestTime:int,serverTime:int):void
		{
			trace("设置服务器时间：" + serverTime);
			_refreshTag = getTimer() ;
			//
			_delayTime = (_refreshTag - requestTime)/2 ; 
			_serverTime = serverTime + _delayTime ;
		}
		
		/** 返回 秒  */
		public static function get serverTime():int
		{
			return _serverTime + (getTimer() - _refreshTag) ;
		}
		
		public static function get serverDate():Date
		{
			if(_date == null)
			{
				_date = new Date(serverTime) ;
			}
			else
			{
				_date.time = serverTime ;
			}
			return _date ;
		}
	}
}