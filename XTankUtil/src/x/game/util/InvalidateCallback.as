package x.game.util
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.utils.Dictionary;

	/**
	 * 在下一帧执行方法回调
	 * @author tb
	 *
	 */
	public class InvalidateCallback
	{
		private static var _mc:Shape = new Shape();
		private static var _map:Dictionary = new Dictionary();

		public static function addFunc(f:Function, args:Object = null):void
		{
			_map[f] = args;
			_mc.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		public static function removeFunc(f:Function):void
		{
			if (f in _map)
			{
				delete _map[f];
			}
		}

		private static function onEnterFrame(event:Event):void
		{
			_mc.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			var args:Object;
			for (var f:* in _map)
			{
				args = _map[f];
				if (args)
				{
					f(args);
				}
				else
				{
					f();
				}
			}
			_map = new Dictionary();
		}
	}
}
