package x.game.util
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.PixelSnapping;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * 显示功能
	 * @author tb
	 *
	 */
	public class DisplayUtil
	{
		
		public static function localToLocal(from:DisplayObject, _to:DisplayObject, p:Point = null):Point
		{
			if (p == null)
			{
				p = new Point(0, 0);
			}
			p = from.localToGlobal(p);
			p = _to.globalToLocal(p);
			return p;
		}

		/**
		 * 给显示对象填充颜色
		 * @param dis
		 * @param c
		 *
		 */
		public static function FillColor(target:DisplayObject, c:uint):void
		{
			var ctf:ColorTransform = new ColorTransform();
			ctf.color = c;
			target.transform.colorTransform = ctf;
		}
		
		/**
		 * 获取显示对象指定位置的颜色 
		 * @param src
		 * @param x
		 * @param y
		 * @param getAlpha
		 * @return 
		 * 
		 */		
		public static function getColor(target:DisplayObject, x:uint = 0, y:uint = 0, getAlpha:Boolean = false):uint
		{
			var bmp:BitmapData = new BitmapData(target.width, target.height);
			bmp.draw(target);
			var color:uint = (!getAlpha) ? bmp.getPixel(int(x), int(y)) : bmp.getPixel32(int(x), int(y));
			bmp.dispose();
			return color;
		}
		
		/**
		 * 等比缩放指定大小 
		 * @param target
		 * @param num
		 * 
		 */		
		public static function uniformScale(target:DisplayObject,num:Number):void
		{
			if(target.width >= target.height)
			{
				target.width = num;
				target.scaleY = target.scaleX;
			}
			else
			{
				target.height = num;
				target.scaleX = target.scaleY;
			}
		}
		/**
		 * 将显示对象用bitmapdata draw成一张位图，返回的位图坐标与原先的display对象内部元素的X，Y坐标相同
		 * @return 
		 * 
		 */		
		public static function copyDisplayAsBmp(dis:DisplayObject):Bitmap
		{
			var bmpdata:BitmapData = new BitmapData(dis.width,dis.height,true,0);
			var rect:Rectangle = dis.getRect(dis);
			var matrix:Matrix = new Matrix();
			matrix.translate(-rect.x,-rect.y);
			bmpdata.draw(dis,matrix);
			var bmp:Bitmap = new Bitmap(bmpdata,PixelSnapping.AUTO,true)
			bmp.x = rect.x;
			bmp.y = rect.y;
			return bmp;
		}
	}
}