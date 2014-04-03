package x.game.model
{
    
	
	/**
    *  时间配置  18/00-20/00
	 * @author fraser
	 * 创建时间：2012-12-26 下午12:45:24
	 */
	public class TimeScopeValue
	{
		/** 开始时间 */
        public var startHour:uint ;
		/** */
		public var startMin:uint ;
		/** 结束时间*/
        public var endHour:uint ;
		/** */
        public var endMin:uint ;
        
		/**
		 * 格式： 18/00-20/00
		 * @param content
		 * 
		 */
		public function TimeScopeValue(content:String)
		{
            var tmp:Array = content.split("-") ;
            var start:Array = String(tmp[0]).split("/") ;
            var end:Array = String(tmp[1]).split("/") ;
            //
            startHour = start[0] ;
            startMin = start[1] ;
            endHour = end[0] ;
			endMin = end[1] ;
		}
		
		public function isInScope(hour:uint,min:uint):Boolean
		{
			var rs:Boolean = false ;
			if(hour >= startHour && hour <= endHour)
			{
				if(min >= startMin && min <= endMin)
				{
					rs = true ;
				}
			}
			return rs ;
		}
	}
}