package x.game.util
{

    public class FormatUtil
    {
        public static const HOURS:uint = 2;
        public static const MINUTES:uint = 1;
        public static const SECONDS:uint = 0;

        /*
        trace(TimeFormat.formatTime(200, TimeFormat.SECONDS));
        outputs "0:03:20". Full class after the break.
        */
        public static function formatTime(time:Number, detailLevel:uint = 2):String
        {
            var intTime:uint = Math.floor(time);
            var hours:uint = Math.floor(intTime / 3600);
            var minutes:uint = (intTime - (hours * 3600)) / 60;
            var seconds:uint = intTime - (hours * 3600) - (minutes * 60);
            var hourString:String = detailLevel == HOURS ? hours + ":" : "";
            var minuteString:String = detailLevel >= MINUTES ? ((detailLevel == HOURS && minutes < 10 ? "0" : "") + minutes + ":") : "";
            var secondString:String = ((seconds < 10 && (detailLevel >= MINUTES)) ? "0" : "") + seconds;
            return hourString + minuteString + secondString;
        }


        public function numberFormat(number:Number, maxDecimals:int = 2, forceDecimals:Boolean = false, siStyle:Boolean = true):String
        {
            var i:int = 0, inc:Number = Math.pow(10, maxDecimals), str:String = String(Math.round(inc * number) / inc);
            var hasSep:Boolean = str.indexOf(".") == -1, sep:int = hasSep ? str.length : str.indexOf(".");
            var ret:String = (hasSep && !forceDecimals ? "" : (siStyle ? "," : ".")) + str.substr(sep + 1);
            if (forceDecimals)
                for (var j:int = 0; j <= maxDecimals - (str.length - (hasSep ? sep - 1 : sep)); j++)
                    ret += "0";
            while (i + 3 < (str.substr(0, 1) == "-" ? sep - 1 : sep))
                ret = (siStyle ? "." : ",") + str.substr(sep - (i += 3), 3) + ret;
            return str.substr(0, sep - i) + ret;
        }
		
		/**
		 * 格式数字秒表类型输出 00:00
		 * @param value
		 * @param length
		 * @return
		 *
		 */
		public static function dateFormat(value:int):String
		{
			var minute:int = value / 60;
			var second:int = value % 60;
			var strM:String = (minute < 10) ? ("0" + minute.toString()) : minute.toString();
			var strS:String = (second < 10) ? ("0" + second.toString()) : second.toString();
			return strM + ":" + strS;
		}
		
		/**
		 * 日期格式
		 * @param value 时间
		 * @param sm    格式间隔符
		 * @return
		 *
		 */
		public static function timeFormat(value:int, sm:String = "-"):String
		{
			var t:Date = new Date(value * 1000);
			return t.getFullYear().toString() + sm + (t.getMonth() + 1).toString() + sm + t.getDate().toString();
		}
    }
}
