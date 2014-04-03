package x.game.util
{
    import flash.display.DisplayObject;
    import flash.geom.Point;

    /**
     * ...
     * @author fraser
     */
    public class MathUtil
    {
        
        /**  解析数字返回数组  */
        public static function parseNumberToDigitVec(number:int):Vector.<int>
        {
            var digitVec:Vector.<int> = new Vector.<int>();
            if (number > 0)
            {
                while (number > 0)
                {
                    var digit:int = number % 10;
                    digitVec.push(digit);
                    number /= 10;
                }
            }
            else if (number == 0)
            {
                digitVec.push(0);
            }
            return digitVec.reverse();
        }
        
		/**
		 * 在不够指定长度的字符串前补零
		 * @param str 需要在前面补零的字符串
		 * @param len 总长度
		 * @return
		 *
		 */
		public static function addZero(number:int, len:int):Vector.<int>
		{
			var tmp:Vector.<int> = parseNumberToDigitVec(number) ;
            while(tmp.length < len)
            {
                tmp.unshift(0) ;
            }
            return tmp ;
		}
		
        /**  取绝对值 */
        public static function abs(value:Number):Number
        {
            return value < 0 ? -value : value;
        }
        
        public static function round(nNumber:Number, nRoundToInterval:Number = 1):Number
        {
            return Math.round(nNumber / nRoundToInterval) * nRoundToInterval;
        }
        
        public static function floor(nNumber:Number, nRoundToInterval:Number = 1):Number
        {
            return Math.floor(nNumber / nRoundToInterval) * nRoundToInterval;
        }
        
        public static function ceil(nNumber:Number, nRoundToInterval:Number = 1):Number
        {
            return Math.ceil(nNumber / nRoundToInterval) * nRoundToInterval;
        }
        
        public static function angle2radius(angle:Number):Number
        {
            return angle * Math.PI / 180 ;
        }
        
        public static function radius2angle(radius:Number):Number
        {
            return radius * 180 / Math.PI ;
        }
        
        public static function rotation2Point(target:DisplayObject,point:Point):void
        {
            var dx:Number = point.x - target.x ;
            var dy:Number = point.y - target.y ;
            target.rotation = angle2radius(Math.atan2(dy, dx)) ;
        }
        
        public static function distance(point1:Point, point2:Point):Number
        {
            var dx:Number = point2.x - point1.x ;
            var dy:Number = point2.y - point1.y ;
            return Math.sqrt(dx * dx + dy * dy) ;
        }
        
        /** 穿过pass点的别塞尔曲线控制点 */
        public static function getControllerPoint(start:Point,pass:Point,end:Point):Point
        {
            var rs:Point = new Point() ;
            rs.x = pass.x * 2 -(start.x + end.x) / 2 ;
            rs.y = pass.y * 2 -(start.y + end.y) / 2 ;
            return rs ;
        }
    }

}
