package x.game.util
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.utils.ByteArray;
	
	import mx.graphics.codec.PNGEncoder;
	import mx.utils.Base64Decoder;
	import mx.utils.Base64Encoder;
	
	/**
	 * 位图帮助类
	 * @author fraser
	 *
	 */
	public class BitmapUtil
	{
		// ------- Private vars -------
		
		private static const _resolution:Number = .025;
		
		private static const palette:String = "@#$%&8BMW*mwqpdbkhaoQ0OZXYUJCLtfjzxnuvcr[]{}1()|/?Il!i><+_~-;,. ";
		
		public static function bmdToAscii(data:BitmapData, whiteThreshold:Number = 0xD8, blackThreshold:Number = 0x10):String
		{
			var rgbVal:uint;
			var redVal:uint;
			var greenVal:uint;
			var blueVal:uint;
			var grayVal:uint;
			var index:uint;
			
			var verticalResolution:uint = Math.floor(data.height * _resolution);
			var horizontalResolution:uint = Math.floor(data.width * _resolution * 0.45);
			
			var result:String = "";
			
			for (var y:uint = 0; y < data.height; y += verticalResolution)
			{
				for (var x:uint = 0; x < data.width; x += horizontalResolution)
				{
					rgbVal = data.getPixel(x, y);
					redVal = (rgbVal & 0xFF0000) >> 16;
					greenVal = (rgbVal & 0x00FF00) >> 8;
					blueVal = rgbVal & 0x0000FF;
					grayVal = Math.floor(0.3 * redVal + 0.59 * greenVal + 0.11 * blueVal);
					if (grayVal > whiteThreshold)
					{
						grayVal = 0xFF;
					}
					else if (grayVal < blackThreshold)
					{
						grayVal = 0x00;
					}
					else
					{
						grayVal = Math.floor(0xFF * ((grayVal - blackThreshold) / (whiteThreshold - blackThreshold)));
					}
					index = Math.floor(grayVal / 4);
					result += palette.charAt(index);
				}
				result += "\n";
			}
			return result;
		}
		
		public static function scaleBitmapData(source:BitmapData, scaleX:Number, scaleY:Number):BitmapData
		{
			var dest:BitmapData = new BitmapData(source.width * scaleX, source.height * scaleY, true, 0x000000);
			var matrix:Matrix = new Matrix();
			matrix.scale(scaleX, scaleY);
			dest.draw(source, matrix);
			return dest;
		}
		
		public static function bmp2byte(source:BitmapData):ByteArray
		{
			var byteArray:ByteArray = source.getPixels(source.rect);
			source.dispose();
			source = null;
			return byteArray;
		}
		
		public static function bmd2String(bmd:BitmapData):String
		{
			var encoder:PNGEncoder = new PNGEncoder();
			var byteArray:ByteArray = encoder.encode(bmd);
			var base64:Base64Encoder = new Base64Encoder();
			base64.encodeBytes(byteArray);
			return base64.toString();
		}
		
		public static function string2Bmd(value:String, callBack:Function):void
		{
			var base64:Base64Decoder = new Base64Decoder();
			base64.decode(value);
			var bytes:ByteArray = base64.toByteArray(); //转化为ByteArray数据    
			var load:Loader = new Loader();
			load.loadBytes(bytes); //读取ByteArray    
			load.contentLoaderInfo.addEventListener(Event.COMPLETE, complete);
			//
			function complete(event:Event):void
			{
				var bitMap:Bitmap = event.target.content as Bitmap; //读取Bitmap    
				callBack(bitMap.bitmapData);
			}
		}
	}
}
