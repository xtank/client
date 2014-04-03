package x.game.util
{
	import flash.geom.Point;
	
	public class ArrayUtilities
	{
		private static var AROUND:Array = [{x: -1, y: -1}, {x: -1, y: 0}, {x: -1, y: +1}, {x: 0, y: -1}, {x: 0, y: +1}, {x: +1, y: -1}, {x: 1, y: 0}, {x: +1, y: +1}];
		
		/**
		 * 获取中心点的周围的点集合
		 *
		 * @param	source  二维数组
		 * @param	center  中心点
		 * @param	maxRow  横向边界
		 * @param	maxCol  竖向边界
		 * @return
		 *
		 *	----> x
		 *  |
		 * 	|
		 * 	y
		 *
		 *  [ (i-1,j-1)   (i-1,j)  (i-1,j+1)]
		 * 	[ (i,j-1)     (i,j)    (i,j+1)  ]
		 *  [ (i+1,j-1)   (i+1,j)  (i+1,j+1)]
		 */
		public static function getAroundElement(source:Array, center:Point, maxRow:uint, maxCol:uint):Array
		{
			var result:Array = new Array();
			var len:uint = AROUND.length;
			var info:Object;
			for (var i:uint = 0; i < len; i++)
			{
				info = AROUND[i];
				var rowIndex:uint = center.y + info["x"];
				var colIndex:uint = center.x + info["y"];
				
				if (rowIndex < 0 || rowIndex >= maxRow)
				{
					continue;
				}
				if (colIndex < 0 || colIndex >= maxCol)
				{
					continue;
				}
				//
				result.push(source[rowIndex][colIndex]);
			}
			return result;
		}
		
		/** 从数组中随机抽取一个元素 */
		public static function getRandomElement(source:Array):*
		{
			var len:uint = source.length;
			if (len > 0)
			{
				var index:uint = Random.random(0, len - 1);
				return source.splice(index, 1)[0];
			}
			else
			{
				return null;
			}
		}
		
		/** 随机打散数组 */
		public static function randomize(aArray:Array):Array
		{
			var outputArr:Array = aArray.slice();
			var i:int = outputArr.length;
			var temp:*;
			var indexA:int;
			var indexB:int;
			while (i)
			{
				indexA = i - 1;
				indexB = Math.floor(Math.random() * i);
				i--;
				if (indexA == indexB)
					continue;
				temp = outputArr[indexA];
				outputArr[indexA] = outputArr[indexB];
				outputArr[indexB] = temp;
			}
			return outputArr;
		}
		
		/** 将数组中的所有 Number 类型的值相加 返回平均值 */
		public static function average(aArray:Array):Number
		{
			return sum(aArray) / aArray.length;
		}
		
		/** 将数组中的所有 Number 类型的值相加 返回 */
		public static function sum(aArray:Array):Number
		{
			var nSum:Number = 0;
			for (var i:Number = 0; i < aArray.length; i++)
			{
				if (typeof aArray[i] == "number")
				{
					nSum += aArray[i];
				}
			}
			return nSum;
		}
		
		// 获取数组中的最大值
		public static function max(aArray:Array):Number
		{
			var aCopy:Array = aArray.concat();
			aCopy.sort(Array.NUMERIC);
			var nMaximum:Number = Number(aCopy.pop());
			return nMaximum;
		}
		
		// 获取数组中的最小值
		public static function min(aArray:Array):Number
		{
			var aCopy:Array = aArray.concat();
			aCopy.sort(Array.NUMERIC);
			var nMinimum:Number = Number(aCopy.shift());
			return nMinimum;
		}
		
		/**  交换数组中 某两个下标位置的数据 */
		public static function switchElements(aArray:Array, nIndexA:Number, nIndexB:Number):void
		{
			var oElementA:Object = aArray[nIndexA];
			var oElementB:Object = aArray[nIndexB];
			aArray.splice(nIndexA, 1, oElementB);
			aArray.splice(nIndexB, 1, oElementA);
		}
		
		/**  打印对象内容   */
		static public function printArray(oArray:Object, nLevel:uint = 0):String
		{
			var sIndent:String = "";
			for (var i:Number = 0; i < nLevel; i++)
			{
				sIndent += "\t";
			}
			//
			var sOutput:String = "";
			for (var sItem:String in oArray)
			{
				if (oArray[sItem] is Object)
				{
					sOutput = sIndent + "** " + sItem + " **\n" + printArray(oArray[sItem], nLevel + 1) + sOutput;
				}
				else
				{
					sOutput += sIndent + sItem + ":" + oArray[sItem] + "\n";
				}
			}
			return sOutput;
		}
		
		static public function vector2Array(value:*):Array
		{
			var result:Array = [];
			var len:uint = value.length;
			for (var i:uint = 0; i < len; i++)
			{
				result.push(value[i]);
			}
			return result;
		}
		
		/** 没有顺序要求的数组删除元素,速度快  */
		static public function delElement(element:*, array:Array):void
		{
			var index:int = array.indexOf(element);
			if (index != -1)
			{
				array[index] = array[array.length - 1];
				array.pop();
			}
		}
	
	}

}
