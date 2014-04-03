package x.game.model
{
    import x.game.core.IDisposeable;


    /**
     * 范围
     * @author fraser
     *
     */
    public class ScopeValue implements IDisposeable
    {
		
		public static function createScopeValue(min:int, max:int, data:Object = null):ScopeValue
		{
			return new ScopeValue(min, max, data);
		}
		
		/**
		 *  
		 * @param value  format as "1 10"
		 * @param data
		 * @return 
		 * 
		 */
		public static function createScopeValueByString(value:String, data:Object = null):ScopeValue
		{
			var tmp:Array = value.split(" ");
			var max:int = 0;
			var min:int = 0;
			if (tmp.length < 2)
			{
				max = tmp[0];
			}
			else
			{
				min = tmp[0];
				max = tmp[1];
			}
			//
			return new ScopeValue(min, max, data);
		}
		
		// ==================================================================================
		// 
		// ==================================================================================
        public var min:int;
        public var max:int;
        public var data:Object;

        public function ScopeValue(min:int, max:int, data:Object = null):void
        {
            if (max < min)
            {
                throw new Error(" max less than min");
            }

            this.min = min;
            this.max = max;
            this.data = data;
        }

        public function dispose():void
        {
            data = null;
        }

        /** 是否在范围内 */
        public function isInScope(value:int):Boolean
        {
            return value >= min && value <= max;
        }

        /** 范围跨度 */
        public function get length():int
        {
            return max - min;
        }
    }
}
