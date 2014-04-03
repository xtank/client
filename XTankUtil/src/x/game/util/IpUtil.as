package x.game.util
{
	import flash.utils.ByteArray;
	
	/**
	 * AntUtilsSWC -  IpUtil
	 * 
	 * Created by fraser on 2013-12-19
	 * Copyright TAOMEE 2013. All rights reserved
	 *
	 */
	public class IpUtil
	{
		public static const HEX_Head:String = "0x";//十六进制数字表示头
		public static const DOT:String = ".";//点
		
		/**
		 * IP地址格式转为十进制数字
		 * @return i
		 *
		 */
		public static function ipToUint(i:String):uint
		{
			var arr:Array = i.split(DOT);
			var str:String = HEX_Head;
			
			for each (var item:String in arr)
			{
				str += uint(item).toString(16);
			}
			return uint(str);
		}
		
		/**
		 * 十进制数字转为IP地址格式 127.0.0.1
		 * @param a
		 * @return 
		 * 
		 */		
		public static function uintToIp(v:uint):String
		{
			var str:String = v.toString(16);
			var ip1:String = uint(HEX_Head+str.slice(0,2)).toString();
			var ip2:String = uint(HEX_Head+str.slice(2,4)).toString();
			var ip3:String = uint(HEX_Head+str.slice(4,6)).toString();
			var ip4:String = uint(HEX_Head+str.slice(6)).toString();
			return ip1+DOT+ip2+DOT+ip3+DOT+ip4;
		}
		
		/**
		 * ip地址转字节数组 
		 * @param i
		 * @return 
		 * 
		 */		
		public static function ipToBytes(i:String,endian:String = null):ByteArray
		{
			var arr:Array = i.split(".");
			var bytes:ByteArray = new ByteArray();
			if(endian != null && endian != "")
			{
				bytes.endian = endian;
			}
			for each(var item:String in arr)
			{
				bytes.writeByte(uint(item));
			}
			return bytes;
		}
		
		/**
		 * 十六进制数字转为IP地址格式
		 * @param a
		 * @return 
		 * 
		 */		
		public static function hexToIp(a:uint):String
		{
			var bytes:ByteArray = new ByteArray();
			bytes.writeUnsignedInt(a);
			bytes.position = 0;
			var str:String = "";
			for(var i:uint = 0;i<4;i++)
			{
				str +=  bytes.readUnsignedByte().toString()+DOT;
			}
			return str.substr(0,str.length-1);
		}
	}
}