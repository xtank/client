package x.game.util
{
	import flash.display.DisplayObject;
	import flash.filters.BitmapFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.GlowFilter;

	/**
	 * ...
	 * @author fraser
	 */
	public class ColorFilter 
	{
		private static var _defaultGlowFilter:GlowFilter = new GlowFilter(0xFF0000,1,3,3,5) ;
		public static var BLACK_GLOWFILTER:GlowFilter = new GlowFilter(0x000000,1,3,3,5) ;
		public static var BLUE_GLOWFILTER:GlowFilter = new GlowFilter(0xD0FFFF,1,3,3,5) ;
		
		/** 设置发光滤镜 */
		public static function setGlowFilter(obj:DisplayObject,glowFilter:GlowFilter = null ):void
		{
			if(glowFilter == null)
			{
				obj.filters = [_defaultGlowFilter] ;
			}else{
				obj.filters = [glowFilter] ;
			}
		}
		
		/**
		 * 
		 * _nRed,_nGreen,_nBlue是计算机图形颜色亮度的常量
		 * 
		 */	
		private static const RED:Number = 0.3086;
		private static const GREEN:Number = 0.6094;
		private static const BLUE:Number = 0.0820;
		
		//-----------------------------------------------------------
		//  public function
		//-----------------------------------------------------------
		
		/**
		 * 设置亮度
		 * @param obj
		 * @param offset 取值范围 -100~100
		 * 
		 */		
		public static function setBrightness(obj:DisplayObject,offset:Number):void 
		{
			offset = ColorFilter.cleanValue(offset,100);
			if (offset == 0 || isNaN(offset))
			{
				return ;
			}
			
			var filter:ColorMatrixFilter = new ColorMatrixFilter([
				1,0,0,0,offset,
				0,1,0,0,offset,
				0,0,1,0,offset,
				0,0,0,1,0,
				0,0,0,0,1
			]);
			setDisplayObject(obj,filter);
		};
		
		public static function cacelGrayscale(obj:DisplayObject):void
		{
			obj.filters = null ;
			obj.alpha = 1 ;
		}
		/**
		 * 
		 * 灰度
		 * @return ColorMatrixFilter
		 * 
		 */	
		public static function setGrayscale(obj:DisplayObject,alphaFlag:Number = .6):void 
		{
			var filter:ColorMatrixFilter = new ColorMatrixFilter(
			[
				ColorFilter.RED, ColorFilter.GREEN, ColorFilter.BLUE, 0, 0, 
				ColorFilter.RED, ColorFilter.GREEN, ColorFilter.BLUE, 0, 0,
				ColorFilter.RED, ColorFilter.GREEN, ColorFilter.BLUE, 0, 0,
				0, 0, 0, 1, 0
			]);
			setDisplayObject(obj,filter);
			obj.alpha = alphaFlag ;
		}
		
		//-----------------------------------------------------------
		//  private function
		//-----------------------------------------------------------
		
		private static function cleanValue(p_val:Number,p_limit:Number):Number
		{
			return Math.min(p_limit,Math.max(-p_limit,p_val));
		}
		
		/**
		 * 把滤镜设置到显示对象
		 * @param obj
		 * @param f
		 * 
		 */		
		private static function setDisplayObject(obj:DisplayObject,f:BitmapFilter):void
		{
			var filters:Array = obj.filters;
			filters.push(f);
			obj.filters = filters;
		}
	}
}