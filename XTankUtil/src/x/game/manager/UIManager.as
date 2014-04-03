package x.game.manager
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.system.ApplicationDomain;
	import flash.utils.ByteArray;
	
	import de.polygonal.ds.HashMap;
	
	import x.game.util.DomainUtil;

	/**
	 * UI管理器
	 * @author fraser
	 *
	 */
	public class UIManager
	{
		private static var _domain:ApplicationDomain;
		private static var _cache:HashMap = new HashMap();

		public static function setup(domain:ApplicationDomain):void
		{
			_domain = domain;
		}

		public static function getClass(name:String):Class
		{
			return DomainUtil.getClass(name, _domain);
		}

		public static function getMovieClip(name:String):MovieClip
		{
			return DomainUtil.getMovieClip(name, _domain);
		}

		public static function getButton(name:String):SimpleButton
		{
			return DomainUtil.getSimpleButton(name, _domain);
		}

		public static function getBitmapData(name:String):BitmapData
		{
			if (_cache.hasKey(name))
			{
				return _cache.get(name) as BitmapData;
			}
			else
			{
				var o:BitmapData = DomainUtil.getBitmapData(name, _domain);
				if (o)
				{
					_cache.set(name, o);
					return o;
				}
				else
				{
					return null;
				}
			}
		}

		public static function getSound(name:String):Sound
		{
			if (_cache.hasKey(name))
			{
				return _cache.get(name) as Sound;
			}
			else
			{
				var o:Sound = DomainUtil.getSound(name, _domain);
				if (o)
				{
					_cache.set(name, o);
					return o;
				}
				else
				{
					return null;
				}
			}
		}

		public static function getSprite(name:String):Sprite
		{
			return DomainUtil.getSprite(name, _domain);
		}

		public static function getByteArray(name:String):ByteArray
		{
			return DomainUtil.getByteArray(name, _domain);
		}

		public static function hasDefinition(name:String):Boolean
		{
			return _domain.hasDefinition(name);
		}

		public static function getSimpleDisplayObject(name:String):DisplayObject
		{
			var result:DisplayObject = DomainUtil.getDisplayObject(name, _domain);
			if (result is InteractiveObject)
			{
				(result as InteractiveObject).mouseEnabled = false;
			}
			if (result is DisplayObjectContainer)
			{
				(result as DisplayObjectContainer).mouseChildren = false;
			}
			return result;
		}
	}
}
