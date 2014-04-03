package x.game.util
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.system.ApplicationDomain;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	
	/**
	 * 公共功能
	 * @author tb
	 * 
	 */	
	public class DomainUtil
	{
		/**
		 * 从应用程序域中获取MovieClip 
		 * @param name
		 * @param domain
		 * @return 
		 * 
		 */		
		public static function getMovieClip(name:String, domain:ApplicationDomain):MovieClip
		{
			var o:DisplayObject = getDisplayObject(name, domain);
			return ((o == null) ? null : (o as MovieClip));
		}
			
		/**
		 * 从应用程序域中获取Sprite
		 * @param name
		 * @param domain
		 * @return 
		 * 
		 */		
		public static function getSprite(name:String, domain:ApplicationDomain):Sprite
		{
			var o:DisplayObject = getDisplayObject(name, domain);
			return ((o == null) ? null : (o as Sprite));
		}
		
		/**
		 * 从应用程序域中获取SimpleButton
		 * @param name
		 * @param domain
		 * @return 
		 * 
		 */		
		public static function getSimpleButton(name:String, domain:ApplicationDomain):SimpleButton
		{
			var o:DisplayObject = getDisplayObject(name, domain);
			return ((o == null) ? null : (o as SimpleButton));
		}
		
		/**
		 * 从应用程序域中获取Sound
		 * @param name
		 * @param domain
		 * @return 
		 * 
		 */		
		public static function getSound(name:String, domain:ApplicationDomain):Sound
		{
			var classReference:Class = getClass(name,domain);
			if(classReference)
			{
				try
				{
					return new classReference() as Sound;
				}
				catch(e:Error)
				{
					trace("DomainUtil getSound error:" + e.toString());
				}
			}
			return null;
		}
		
		/**
		 * 从应用程序域中获取BitmapData
		 * @param name
		 * @param domain
		 * @return 
		 * 
		 */		
		public static function getBitmapData(name:String, domain:ApplicationDomain):BitmapData
		{
			var classReference:Class = getClass(name, domain);
			if (classReference)
			{
				try
				{
					return new classReference(0, 0) as BitmapData;
				}
				catch(e:Error)
				{
					trace("DomainUtil getBitmapData error:" + e.toString());
				}
			}
			return null;
		}
		
		/**
		 * 从应用程序域中获取DisplayObject
		 * @param name
		 * @param loader
		 * @return 
		 * 
		 */		
		public static function getDisplayObject(name:String, domain:ApplicationDomain):DisplayObject
		{
			var classReference:Class = getClass(name, domain);
			if (classReference != null)
			{
				try
				{
					return new classReference() as DisplayObject;
				}
				catch(e:Error)
				{
					trace("DomainUtil getDisplayObject error:" + e.toString());
					return null;
				}
			}
			return null;
		}
		
		public static function getByteArray(name:String, domain:ApplicationDomain):ByteArray
		{
			var classReference:Class = getClass(name,domain);
			if (classReference != null)
			{
				try
				{
					return new classReference() as ByteArray;
				}
				catch(e:Error)
				{
					trace("DomainUtil getByteArray error:" + e.toString());
					return null;
				}
			}
			return null;
		}
		
		/**
		 * 从应用程序域中获取Class
		 * @param name
		 * @param domain
		 * @return 
		 * 
		 */	
		public static function getClass(name:String, domain:ApplicationDomain):Class
		{
			if(domain.hasDefinition(name))
			{
				return domain.getDefinition(name)as Class;
			}
			else
			{
				trace("DomainUtil getClass not hasDefinition:"+name);
			}
			return null;
		}
		
		/**
		 * 返回 name 参数指定的类的类
		 * @param name
		 * @return 
		 * 
		 */		
		public static function getCurrentDomainClass(name:String):Class
		{
			try
			{
				var classReference:Class = getDefinitionByName(name)as Class;
			}
			catch(e:Error)
			{
				trace("DomainUtil getCurrentDomainClass " + name + "error" + e.message);
				return null;
			}
			return classReference;
		}
	}
}



