package x.game.util
{
	
	/**
	 * AntUtilsSWC -  StringValidateUtil
	 * 
	 * Created by fraser on 2013-12-19
	 * Copyright TAOMEE 2013. All rights reserved
	 * 字符串相关验证
	 */
	public class StringValidateUtil
	{
		/** 字符串是否可用 */
		public static function stringHasValue(s:String):Boolean
		{
			return (s != null && s.length > 0);
		}
		
		/**
		 * 一个字符串从开头起是否有指定的字符串
		 * @param input
		 * @param prefix
		 * @return
		 *
		 */
		public static function beginsWith(input:String, prefix:String):Boolean
		{
			return (prefix == input.substring(0, prefix.length));
		}
		
		/**
		 * 一个字符串从结尾起是否有指定的字符串
		 * @param input
		 * @param suffix
		 * @return
		 *
		 */
		public static function endsWith(input:String, suffix:String):Boolean
		{
			return (suffix == input.substring(input.length - suffix.length));
		}
		
		/**
		 * 对比两个字符串
		 * @param s1
		 * @param s2
		 * @param caseSensitive 是否区分大小写
		 * @return
		 *
		 */
		public static function stringsAreEqual(s1:String, s2:String, caseSensitive:Boolean):Boolean
		{
			if (caseSensitive)
			{
				return (s1 == s2);
			}
			else
			{
				return (s1.toUpperCase() == s2.toUpperCase());
			}
		}
		
		/**
		 * 指定字符是否在原字符串的开头
		 * @param $str 要指定的字符串
		 * @param $target 源字符串
		 * @return (Boolean) 指定字符串在开头返回true，否则返回false
		 * */
		public static function isTargetFirst($source:String, $target:String):Boolean
		{
			if ($target == $source.split("")[0])
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		/**
		 * 指定字符是否在原字符串的结尾
		 * @param $str 要指定的字符串
		 * @param $target 源字符串
		 * @return (Boolean) 指定字符串在结尾返回true，否则返回false
		 * */
		public static function isTargetEnd($source:String, $target:String):Boolean
		{
			var r:Array = $source.split("");
			if ($target == r[r.length - 1])
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		/** 字符串是否含有中文字符    */
		public static function hasChineseChar(char:String):Boolean
		{
			if (char == null)
			{
				return false;
			}
			char = StringFormatUtil.trim(char);
			var pattern:RegExp = /[^\x00-\xff]/;
			var result:Object = pattern.exec(char);
			if (result == null)
			{
				return false;
			}
			return true;
		}
		
		/**
		 * 是否全部都是中文字符(中文形式的标点符号也是中文、但数字和-都不算中文)
		 * @param $str 源字符串
		 * @return (Boolean) 如果源字符串全都是中文字符则返回true，否则返回false
		 * */
		public static function isChinese($str:String):Boolean
		{
			if ($str != null)
			{
				//str = trim(str);    //消除两边空格 
				var re:RegExp = /^[\u0391-\uFFE5]+$/;
				var obj:Object = re.exec($str);
				if (obj != null)
				{
					return true;
				}
				else
				{
					return false;
				}
			}
			else
			{
				return false;
			}
		}
		
		/**
		 * 当忽略大小写时字符串是否相等
		 * @param $str1
		 * @param $str2
		 * @return (Boolean) 如果相等返回true，否则返回false
		 * */
		public static function isEqual($str1:String, $str2:String):Boolean
		{
			if ($str1.toLowerCase() == $str2.toLowerCase())
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		/**
		 * 是否为空白，包括多个空白和换行空白等
		 * @param $str 源字符串
		 * @return (Boolean) 如源字符串含有空白则返回true，否则返回false
		 * */
		public static function isBlank($str:String):Boolean
		{
			switch ($str)
			{
				case " ":
				case "\t":
				case "\r":
				case "\n":
				case "\f":
					return true;
				default:
					return false;
			}
		}
		
		//URL地址;   
		public static function isURL(char:String):Boolean
		{
			if (char == null)
			{
				return false;
			}
			char = StringFormatUtil.trim(char).toLowerCase();
			var pattern:RegExp = /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/;
			var result:Object = pattern.exec(char);
			if (result == null)
			{
				return false;
			}
			return true;
		}
		
		//是否为Email地址;   
		public static function isEmail(char:String):Boolean
		{
			if (char == null)
			{
				return false;
			}
			char = StringFormatUtil.trim(char);
			var pattern:RegExp = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;
			var result:Object = pattern.exec(char);
			if (result == null)
			{
				return false;
			}
			return true;
		}
		//是否是数值字符串;   
		public static function isNumber(char:String):Boolean
		{
			if (char == null)
			{
				return false;
			}
			return !isNaN(Number(char));
		}
		//是否为Double型数据; 
		public static function isDouble(char:String):Boolean
		{
			char = StringFormatUtil.trim(char);
			var pattern:RegExp = /^[-\+]?\d+(\.\d+)?$/;
			var result:Object = pattern.exec(char);
			if (result == null)
			{
				return false;
			}
			return true;
		}
		//Integer;   
		public static function isInteger(char:String):Boolean
		{
			if (char == null)
			{
				return false;
			}
			char = StringFormatUtil.trim(char);
			var pattern:RegExp = /^[-\+]?\d+$/;
			var result:Object = pattern.exec(char);
			if (result == null)
			{
				return false;
			}
			return true;
		}
		//English;   
		public static function isEnglish(char:String):Boolean
		{
			if (char == null)
			{
				return false;
			}
			char = StringFormatUtil.trim(char);
			var pattern:RegExp = /^[A-Za-z]+$/;
			var result:Object = pattern.exec(char);
			if (result == null)
			{
				return false;
			}
			return true;
		}
		
		//双字节   
		public static function isDoubleChar(char:String):Boolean
		{
			if (char == null)
			{
				return false;
			}
			char = StringFormatUtil.trim(char);
			var pattern:RegExp = /^[^\x00-\xff]+$/;
			var result:Object = pattern.exec(char);
			if (result == null)
			{
				return false;
			}
			return true;
		}
		
		//注册字符;   
		public static function hasAccountChar(char:String, len:uint = 15):Boolean
		{
			if (char == null)
			{
				return false;
			}
			if (len < 10)
			{
				len = 15;
			}
			char = StringFormatUtil.trim(char);
			var pattern:RegExp = new RegExp("^[a-zA-Z0-9][a-zA-Z0-9_-]{0," + len + "}$", "");
			var result:Object = pattern.exec(char);
			if (result == null)
			{
				return false;
			}
			return true;
		}
	}
}