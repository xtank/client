package x.game.util
{
	/**
	 * 位功能
	 * @author tb
	 * 
	 */	
	public class BitUtil
	{
		
		/**
		 * 设置标记位
		 * 二进制操作
		 * bitPos  0 - 7 
		 * */
		public static function setBit2(originData:uint, bitPos:uint, flag:Boolean):uint
		{
			bitPos = bitPos > 7 ? 7 : bitPos ;
			if(bitPos == 7 )
			{
				originData = uint(flag) << 7;  //Set bit 8 to true
			}
			else
			{
				originData |= uint(flag)<< bitPos; //Set bit 7 to true
			}
			return originData ;
		}

		/**
		 * @param unsigned32 无符号32位整型
		 * @param bit 要获取的相应的位数值, 从0开始
		 * @return
		 *
		 */
		public static function getBit2(unsigned32:uint, bit:uint):uint
		{
			const l:int = 32;
			const t:uint = 1;
			var i:int = 0;
			if (bit == 0) return unsigned32 & t;
			unsigned32 = unsigned32 >> bit;
			return unsigned32 & t;
		}
		
		public static function getBit(v:uint,index:int):Boolean
		{
			return v == (v | (1 << index));
		}
		
		public static function setBit(v:uint,index:int,bool:Boolean):uint
		{
			if (bool)
			{
                v = v | (1 << index);
			}
            else 
            {
                v = v & ~(1 << index);
            }
            return v;
		}
		
		/**
		 * 由uint转换为布尔数组
		 * @param v
		 * @param len 位数
		 * @return 返回的数组
		 * 
		 */		
        public static function toBitArray(v:uint,len:int):Array
        {
        	var arr:Array = [];
			for(var i:int=0;i<len;i++)
			{
				arr[i] = Boolean(v & 0x1);
				v = v >> 1;
			}
        	return arr;
        }
	}
}