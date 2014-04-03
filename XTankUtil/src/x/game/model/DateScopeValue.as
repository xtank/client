package x.game.model      
{
	import x.game.core.IDisposeable;
	
	/** 
	 * 日期范围配置项 
	 * 
	 * @author fraser 
	 */
	public class DateScopeValue implements IDisposeable
	{
		/** 开始时间 */
		private var _startDate:Date ;
		/** 结束时间 */
		private var _endDate:Date ;
		//
		public var data:Object;
		
		/**
		 *  
		 * @param startDate format as '2013/1/1' 开始时间默认为00:00:00
		 * @param endDate  format as '2013/1/1'  结束时间默认为23:59:59
		 * 
		 */
		public function DateScopeValue(startDate:String,
									   endDate:String,
									   startHour:uint = 0,startMin:uint = 0,startSec:uint = 0,
									   endHour:uint = 23,endMin:uint = 59,endSec:uint = 59,
									   data:Object = null)
		{
			//
			startHour = startHour > 24 ? 24: startHour ;
			startMin = startMin > 59 ? 59: startMin ;
			startHour = startHour > 24 ? 24: startHour ;
			startHour = startHour > 24 ? 24: startHour ;
			startHour = startHour > 24 ? 24: startHour ;
			startHour = startHour > 24 ? 24: startHour ;
			startHour = startHour > 24 ? 24: startHour ;
			//
			var tmp:Array = startDate.split("/") ;
			_startDate = new Date(uint(tmp[0]),uint(tmp[1]) - 1,uint(tmp[2])) ;
			_startDate.hours = 0;
			_startDate.minutes = 0;
			_startDate.seconds = 0;
			//
			tmp = endDate.split("/") ;
			_endDate = new Date(uint(tmp[0]),uint(tmp[1]) - 1,uint(tmp[2])) ;
			_endDate.hours = 23;
			_endDate.minutes = 59;
			_endDate.seconds = 59;
			//
			this.data = data;
		}
		
		public function isInScopeByTime(time:Number):Boolean
		{
			if(time >= _startDate.time && time <= _endDate.time)
			{
				return true ;
			}
			else
			{
				return false ;
			}
		}
		
		public function isInScopeByDate(date:Date):Boolean
		{
			if(date.time >= _startDate.time && date.time <= _endDate.time)
			{
				return true ;
			}
			else
			{
				return false ;
			}
		}
		
		public function isInScope(year:uint,month:uint,date:uint):Boolean
		{
			var checkDate:Date = new Date(year,month,date) ;
			if(checkDate.time >= _startDate.time && checkDate.time <= _endDate.time)
			{
				return true ;
			}
			else
			{
				return false ;
			}
		}
		
		public function dispose():void
		{
			_startDate = null ;
			_endDate = null ;
		}

		public function get startDate():Date
		{
			return _startDate;
		}

		public function get endDate():Date
		{
			return _endDate;
		}


	}
}