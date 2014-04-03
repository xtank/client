package x.game.util
{
	import flash.utils.ByteArray;
	
	/**
	 * AntUtilsSWC -  StringFormatUtil
	 * 
	 * Created by fraser on 2013-12-19
	 * Copyright TAOMEE 2013. All rights reserved
	 *
	 */
	public class StringFormatUtil
	{		
		/**
		 * 中文字符串转换为拼音函数
		 * @param $str 要转为拼音的中文字符串
		 * @return (String) 转换后的拼音字符串
		 * */
		public static function chinese2Py($str:String):String
		{
			return HanziToPinyin.toPinyin($str);
		}
		
		/**
		 * 消除双换行符
		 * @param $str 源字符串
		 * @return (String) 新字符串
		 * */
		public static function enterStr(str:String):String
		{
			return str.replace(/\r\n/gm, "\n");
		}	
		
		/**
		 * 字符串相反排列函数
		 * @param $str 原字符串
		 * @return (String) 返回相反的原字符串
		 * */
		public static function reverseSort($str:String):String
		{
			var s:String = "";
			var r:Array = $str.split("");
			var n:Number = r.length;
			for (var i:int = 0; i < n; i++)
			{
				s += r[n - i - 1];
			}
			return s;
		}
		
		/**
		 * 去掉两边空格
		 * @param input
		 * @return
		 *
		 */
		public static function trim(char:String):String
		{
			if (char == null)
			{
				return "";
			}
			return rightTrim(leftTrim(char));
		}
		
		/**
		 * 去掉左边空格
		 * @param input
		 * @return
		 *
		 */
		public static function leftTrim(char:String):String
		{
			if (char == null)
			{
				return "";
			}
			var pattern:RegExp = /^\s*/;
			return char.replace(pattern, "");
		}
		
		/**
		 * 去掉右边空格
		 * @param input
		 * @return
		 *
		 */
		public static function rightTrim(char:String):String
		{
			if (char == null)
			{
				return "";
			}
			var pattern:RegExp = /\s*$/;
			return char.replace(pattern, "");
		}
		
		/**
		 * 在不够指定长度的字符串前补零
		 * @param str 需要在前面补零的字符串
		 * @param len 总长度
		 * @return
		 *
		 */
		public static function renewZero(str:String, len:int):String
		{
			var bul:String = "";
			var strLen:int = str.length;
			if (strLen < len)
			{
				for (var i:int = 0; i < len - strLen; i++)
				{
					bul += "0";
				}
				return bul + str;
			}
			else
			{
				return str;
			}
		}
		
		/**　语句首单词大写处理  */
		public static function toTitleCase(original:String):String
		{
			var words:Array = original.split(" ");
			for (var i:int = 0; i < words.length; i++)
			{
				words[i] = toInitialCap(words[i]);
			}
			return (words.join(" "));
		}
		
		/**　首字母大写处理  */
		public static function toInitialCap(original:String):String
		{
			return original.charAt(0).toUpperCase() + original.substr(1).toLowerCase();
		}
		
		/**
		 * 将字符串转化为字节数组 
		 * @param s
		 * @param length
		 * @return 
		 * 
		 */		
		public static function toByteArray(s:String,length:uint):ByteArray
		{
			var bytes:ByteArray = new ByteArray();
			bytes.writeUTFBytes(s);
			bytes.length = length;
			bytes.position = 0;
			return bytes;
		}
		
		/**
		 * utf16转utf8编码;
		 * @param char
		 * @return
		 *
		 */
		public static function utf16to8(char:String):String
		{
			var out:Array = new Array();
			var len:uint = char.length;
			for (var i:uint = 0; i < len; i++)
			{
				var c:int = char.charCodeAt(i);
				if (c >= 0x0001 && c <= 0x007F)
				{
					out[i] = char.charAt(i);
				}
				else if (c > 0x07FF)
				{
					out[i] = String.fromCharCode(0xE0 | ((c >> 12) & 0x0F), 0x80 | ((c >> 6) & 0x3F), 0x80 | ((c >> 0) & 0x3F));
				}
				else
				{
					out[i] = String.fromCharCode(0xC0 | ((c >> 6) & 0x1F), 0x80 | ((c >> 0) & 0x3F));
				}
			}
			return out.join('');
		}
		
		/**
		 * utf8转utf16编码;
		 * @param char
		 * @return
		 *
		 */
		public static function utf8to16(char:String):String
		{
			var out:Array = new Array();
			var len:uint = char.length;
			
			var i:uint = 0;
			while (i < len)
			{
				var c:int = char.charCodeAt(i++);
				switch (c >> 4)
				{
					case 0:
					case 1:
					case 2:
					case 3:
					case 4:
					case 5:
					case 6:
					case 7:
						// 0xxxxxxx   
						out[out.length] = char.charAt(i - 1);
						break;
					case 12:
					case 13:
						// 110x xxxx   10xx xxxx   
						var char1:int = char.charCodeAt(i++);
						out[out.length] = String.fromCharCode(((c & 0x1F) << 6) | (char1 & 0x3F));
						break;
					case 14:
						// 1110 xxxx  10xx xxxx  10xx xxxx   
						var char2:int = char.charCodeAt(i++);
						var char3:int = char.charCodeAt(i++);
						out[out.length] = String.fromCharCode(((c & 0x0F) << 12) | ((char2 & 0x3F) << 6) | ((char3 & 0x3F) <<
							0));
						break;
				}
			}
			return out.join('');
		}
	}
}