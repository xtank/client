package x.game.date
{
	import flash.display.Sprite;
	
	/**
	 * [开源项目]as3时间处理工具类
	 * <br/>
	 * <strong>开发版本</strong> v20120321.4
	 * <br/>
	 * <strong>起点时间</strong> 2011.09.23
	 * <br/>
	 * <strong>语言版本</strong> as3.0 Flashplayer10
	 * <br/>
	 * <strong>作者</strong> xuechong
	 * <br/>
	 * <strong>QQ</strong> 632801102
	 * <br/><br/>
	 * 函数列表：
	 * <br/>
	 * dayNum                 得到指定的两个公历日期之间相差的天数  <br/>
	 * alreadyOverDay         指定的一年之内已经过了多少天了(算上当天)
	 * oneHour                一小时，即60分钟之内的秒数转化
	 * oneDay                 一天之内，即24小时之内的秒数转化
	 * anyMinutes             不限制在60分钟之内，只要是00:00格式的就行
	 * anyHours               不限制在24小时之内，只要是00:00:00格式的就行
	 * anyDays                所有时间的秒数转化
	 * isLeapYear             是否为闰年
	 * greMonthManyDays       指定公历年的某个月多少天
	 * manyWorkWeekDay        指定某公历年月内有几天工作日
	 * addDateNum             指定公历日期加上一定天数得到新日期
	 * delWeekendDaysAllNum   指定日期加上一定天数，返回加上后又减去周六日的总天数后的新日期
	 * minusDateNum           指定日期减去一定天数，返回减去后的新日期
	 * seqWeekOfMonth         指定公历日期所在周是当月的第几周
	 * seqWeekOfYear          指定公历日期所在周是当年的第几周
	 * objToTimeFormat        时间Date对象转化为标准时间格式YYYYMMDDHHMMSS
	 * yearAnimals            根据指定农历年份获得对应农历的生肖
	 * greToLunarArray        返回某公历年月日对应的农历年月日
	 * cyclical               获得指定农历年份的天干地支
	 * */
	public class DateUtil extends Sprite
	{
		public function DateUtil()
		{
			//trace(dayNum("19881008", "20120315"));    //8559
			//trace(alreadyOverDay("20120315"));    //75,291
		
			//trace(oneHour(200));    //03:20
			//trace(oneDay(20000));    //05:33:20
			//trace(anyMinutes(1234567));    //20576:07
			//trace(anyHours(1234567));    //342:56:07
			//trace(anyDays(1234567));    //14-06:56:07
		
			//trace(isLeapYear(2012));    //true
			//trace(greMonthManyDays(2012, 2));    //29
			//trace(manyWorkWeekDay(2012, 3));    //22
			//trace(addDateNum(1988, 10, 8, 8560));    //2012/3/16
			//trace(delWeekendDaysAllNum(2012, 3, 20, 5));    //2012/3/27
			//trace(minusDateNum(2012, 3, 20, 8564));    //1988/10/8
		
			//trace(seqWeekOfMonth(2012, 3, 20));     //4
			//trace(seqWeekOfYear(2012, 3, 20));    //12
		
			//trace(objToTimeFormat(new Date()));    //20120320150356
		
			//trace(yearAnimals(1988));    //龙
			//trace(greToLunarArray(2012, 3, 20));    //2012,2,28,148,1359,40996,0
			//trace(cyclical(2012));    //壬辰
		}
		
		/**
		 * 得到指定的两个公历日期之间相差的天数 <br/>
		 * 虽然名字为from和to， 两个参数所代表的开始和结束年份没有先后顺序
		 * @param $fromFormatDayStr 开始日期，格式如19881008
		 * @param $toFormatDayStr 结束日期，格式如20120315
		 * @return (int) 相差天数
		 * */
		public static function dayNum($fromFormatDayStr:String, $toFormatDayStr:String):int
		{
			return AmountDay.manyDayNum($fromFormatDayStr, $toFormatDayStr);
		}
		
		/**
		 * 指定的一年之内已经过了多少天了(算上当天) <br/>
		 * 要保证dayStr参数的格式和实际含义正确，如不能出现20100229
		 * @param $dayFormatStr 指定的日期，格式如20120315
		 * @return (Array) [0]表示已经过了多少天，[1]表示还剩下多少天
		 * */
		public static function alreadyOverDay($dayFormatStr:String):Array
		{
			return AmountDay.alreadyOverDay($dayFormatStr);
		}
		
		/**
		 * 是否为闰年 <br/>
		 * @param $greYear dayStr标准格式为YYYY，如2010
		 * @return (Boolean) 是润年返回true，不是润年返回false
		 * */
		public static function isLeapYear($greYear:int):Boolean
		{
			if (($greYear % 4 == 0 && $greYear % 100 != 0) || $greYear % 400 == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		/**
		 * 指定公历年的某个月多少天
		 * @param $greYear 年份，如2012
		 * @param $greMonth 月份，如2
		 * @return (int) 指定公历年月的天数
		 * */
		public static function greMonthManyDays($greYear:int, $greMonth:int):int
		{
			const DAYS_IN_MONTH:Array = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
			var manyDayNum:int = DAYS_IN_MONTH[$greMonth - 1];
			if (isLeapYear2() && $greMonth == 2)
			{
				manyDayNum++;
			}
			function isLeapYear2():Boolean
			{
				if (($greYear % 4 == 0 && $greYear % 100 != 0) || $greYear % 400 == 0)
				{
					return true;
				}
				else
				{
					return false;
				}
			}
			return manyDayNum;
		}
		
		/**
		 * 指定某公历年月内有几天工作日
		 * @param $greYear 公历年份
		 * @param $greMonth 公历月份
		 * @reutrn (int) 返回指定月份工作日的天数
		 * */
		public static function manyWorkWeekDay($greYear:int, $greMonth:int):int
		{
			var restWeekNum:int = 0;
			var date:Date = new Date($greYear, $greMonth - 1);
			var firstDayWeekNum:Number = date.getDay(); //每月的1号是星期几
			var manyDaysNum:int = greMonthManyDays($greYear, $greMonth);
			if (firstDayWeekNum >= 1 && firstDayWeekNum <= 5)
			{
				var numDateNum:int = 27 - firstDayWeekNum;
				if (manyDaysNum == 31)
				{
					if (numDateNum == 22)
					{
						restWeekNum = 10;
					}
					else if (numDateNum == 23)
					{
						restWeekNum = 9;
					}
					else
					{
						restWeekNum = 8;
					}
				}
				else if (manyDaysNum == 30)
				{
					if (numDateNum == 22)
					{ //这一号是星期五
						restWeekNum = 9;
					}
					else
					{
						restWeekNum = 8;
					}
				}
				else
				{ //每月有28天或29天
					restWeekNum = 8;
				}
			}
			else if (firstDayWeekNum == 6)
			{ //周六
				restWeekNum = 10;
				if (manyDaysNum == 28)
				{
					restWeekNum = 8;
				}
				else if (manyDaysNum == 29)
				{
					restWeekNum = 9;
				}
			}
			else if (firstDayWeekNum == 0)
			{ //周日
				if (manyDaysNum != 28)
				{
					restWeekNum = 9;
				}
				else
				{
					restWeekNum = 8;
				}
			}
			/*一个公历月有多少天*/
			function greMonthManyDays():Number
			{
				const DAYS_IN_MONTH:Array = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
				var manyDayNum:Number = DAYS_IN_MONTH[$greMonth - 1];
				if (isLeapYear3() && $greMonth == 2)
				{
					manyDayNum++;
				}
				return manyDayNum;
			}
			/*是否为闰年*/
			function isLeapYear3():Boolean
			{
				if (($greYear % 4 == 0 && $greYear % 100 != 0) || $greYear % 400 == 0)
				{
					return true;
				}
				else
				{
					return false;
				}
			}
			return manyDaysNum - restWeekNum;
		}
		
		/**
		 * 指定公历日期加上一定天数得到新日期 <br/>
		 * 如addDateNum(1988, 10, 8, 7992));    //2010/8/26
		 * @param $greYear 公历年份
		 * @param $greMonth 公历月份
		 * @param $greDay 公历日期
		 * @param $manyDay 加的天数
		 * @return (String) 年/月/日
		 * */
		public static function addDateNum($greYear:Number, $greMonth:Number, $greDay:Number, $manyDay:Number):String
		{
			return AfterDateHandler.addDateNum($greYear, $greMonth, $greDay, $manyDay);
		}
		
		/**
		 * 指定日期加上一定天数，返回加上后又减去周六日的总天数后的新日期 <br/>
		 * 如delWeekendDaysAllNum(2012, 3, 20, 5);    //2012/3/27
		 * @param $greYear 公历年份
		 * @param $greMonth 公历月份
		 * @param $greDay 公历日期
		 * @param $manyDay 加的天数
		 * @return (String) 年/月/日
		 * */
		public static function delWeekendDaysAllNum($greYear:Number, $greMonth:Number, $greDay:Number, $addManyDaysNum:Number):String
		{
			return AfterDateNoWeekend.delWeekendDaysAllNum($greYear, $greMonth, $greDay, $addManyDaysNum);
		}
		
		/**
		 * 指定日期减去一定天数，返回减去后的新日期 <br/>
		 * 如minusDateNum(2012, 3, 20, 8564);    //
		 * @param $greYear 公历年份
		 * @param $greMonth 公历月份
		 * @param $greDay 公历日期
		 * @param $manyDay 减去的天数
		 * @return (String) 返回减后的日期:年/月/日
		 * */
		public static function minusDateNum($greYear:Number, $greMonth:Number, $greDay:Number, $manyDay:Number):String
		{
			return BeforeDataHandler.minusDateNum($greYear, $greMonth, $greDay, $manyDay);
		}
		
		/**
		 * 指定公历日期所在周是当月的第几周 <br/>
		 * 如seqWeekOfMonth(2012, 3, 20);     //4
		 * @param $greYear 公历年份
		 * @param $greMonth 公历月份
		 * @param $greDay 公历日期
		 * @return (Number) 返回当月内的周序列
		 * */
		public static function seqWeekOfMonth($greYear:Number, $greMonth:Number, $greDay:Number):Number
		{
			var date:Date = new Date($greYear, $greMonth - 1, $greDay);
			var diff:Number = date.getDate() - 1;
			date.setDate(1);
			var dateWeek:Number = 7 - date.getDay();
			if (diff > dateWeek)
			{
				diff -= dateWeek;
				var dateMod:Number = diff % 7;
				if (dateMod > 0)
				{
					return (diff - dateMod) / 7 + 2;
				}
				else
				{
					return diff / 7 + 1;
				}
			}
			else
			{
				return 1;
			}
		}
		
		/**
		 * 指定公历日期所在周是当年的第几周 <br/>
		 * 如seqWeekOfYear(2012, 3, 20);    //12
		 * @param $greYear 公历年份
		 * @param $greMonth 公历月份
		 * @param $greDay 公历日期
		 * @return (Number) 返回当年内的周序列
		 * */
		public static function seqWeekOfYear($greYear:Number, $greMonth:Number, $greDay:Number):Number
		{
			var date:Date = new Date($greYear, $greMonth - 1, $greDay);
			var startDate:Date = new Date($greYear, 0, 1);
			var diff:Number = date.valueOf() - startDate.valueOf();
			var d:Number = Math.round(diff / 86400000);
			return Math.ceil((d + ((startDate.getDay() + 1) - 1)) / 7);
		}
		
		/**
		 * 时间Date对象转化为标准时间格式YYYYMMDDHHMMSS <br/>
		 * 如objToTimeFormat(new Date());    //20120320150356
		 * @param $date 指定的日期对象
		 * @return (String) 返回标准时间格式
		 * */
		public static function objToTimeFormat($date:Date):String
		{
			var yearStr:String = String($date.fullYear);
			var monthStr:String = String($date.month + 1);
			var dateStr:String = String($date.date);
			var hourStr:String = String($date.hours);
			var minutesStr:String = String($date.minutes);
			var secondStr:String = String($date.seconds);
			if ($date.month < 9)
			{
				monthStr = "0" + monthStr;
			}
			if ($date.date < 10)
			{
				dateStr = "0" + dateStr;
			}
			if ($date.hours < 10)
			{
				hourStr = "0" + hourStr;
			}
			if ($date.minutes < 10)
			{
				minutesStr = "0" + minutesStr;
			}
			if ($date.seconds < 10)
			{
				secondStr = "0" + secondStr;
			}
			return yearStr + monthStr + dateStr + hourStr + minutesStr + secondStr;
		}
		
		/**
		 * 返回某公历年月日对应的农历年月日 <br/>
		 * 如greToLunarArray(2012, 3, 20);    //2012,2,28,148,1359,40996,0
		 * @param $greYear 公历年份
		 * @param $greMonth 公历月份
		 * @param $greDay 公历日期
		 * @return (Array) 返回指定公历年月日对应的农历年月日
		 * */
		public static function greToLunarArray($greYear:int, $greMonth:int, $greDay:int):Array
		{
			return GreToLunarDate.greToLunarArray($greYear, $greMonth, $greDay);
		}
		
		private static var tianganArr:Array = new Array("甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸");
		private static var dizhiArr:Array = new Array("子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥");
		//
		private static var animalArr:Array = new Array("鼠", "牛", "虎", "兔", "龙", "蛇", "马", "羊", "猴", "鸡", "狗", "猪");
		
		/**
		 * 获得指定农历年份的天干地支 <br/>
		 * 注:传入农历年份返回干支(此农历年份要大于等于1864) <br/>
		 * 如cyclical(2012);    //壬辰
		 * @param $lunarYear 指定的农历年份
		 * @return (String) 指定农历年份的天干地支
		 * */
		public static function cyclical($lunarYear:int):String
		{
			var num:int = $lunarYear - 1900 + 36;
			return (tianganArr[num % 10] + dizhiArr[num % 12]);
		}
		
		/**
		 * 根据指定农历年份获得对应农历的生肖 <br/>
		 * 如yearAnimals(1988);    //龙
		 * @param $greYear 指定农历年份
		 * @return (String) 生肖动物名称
		 * */
		public static function yearAnimals($lunarYear:int):String
		{
			return animalArr[($lunarYear - 4) % 12];
		}
	
	}
}
