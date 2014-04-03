package x.game.util
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * 位图数据功能 
	 * @author tb
	 * 
	 */	
	public class BitmapDataUtil
	{
		/**
		 * 截图一张位图，生成指定大小的位图数据列表 
		 * @param data 源位图数据
		 * @param width 宽
		 * @param height 高
		 * @param totalFrames 总帧数
		 * @param valids 有效帧索引，从0开始，如果为null，则所有帧有效
		 * @return 
		 * 
		 */		
		public static function makeList(data:BitmapData,width:int,height:int,frames:uint,valids:Array=null):Array
		{
			var wLen:int = int(Math.min(data.width,2880)/width);
			var hLen:int = int(Math.min(data.height,2880)/height);
			//
			var count:int = 0;
			var bm:BitmapData = null;
			var arr:Array = new Array(frames);
			var rect:Rectangle = new Rectangle(0,0,width,height);
			var pos:Point = new Point();
			//
			for(var ih:int = 0;ih<hLen;ih++)
			{
				for(var iw:int = 0;iw<wLen;iw++)
				{
					if(count >= frames)
					{
						return arr;
					}
					//
					rect.x = iw*width;
					rect.y = ih*height;
					if(valids)
					{
						if(valids.indexOf(count) != -1)
						{
							bm = new BitmapData(width,height);
							bm.copyPixels(data,rect,pos);
							arr[count] = bm;
						}
						else
						{
							arr[count] = null;
						}
					}
					else
					{
						bm = new BitmapData(width,height);
						bm.copyPixels(data,rect,pos);
						arr[count] = bm;
					}
					count++;
				}
			}
			return arr;
		}
	}
}