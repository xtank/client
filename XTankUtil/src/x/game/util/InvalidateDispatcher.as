package x.game.util
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	/**
	 * 下一帧执行事件广播 
	 * @author tb
	 * 
	 */	
	public class InvalidateDispatcher
	{
		private static var _mc:Shape = new Shape();
		
		private var _ed:IEventDispatcher;
		private var _list:Array = [];
		
		public function InvalidateDispatcher(ed:IEventDispatcher)
		{
			_ed = ed;
		}
		public function destroy():void
		{
			_mc.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			_ed = null;
			_list = null;
		}
		
		public function addEvent(e:Event):void
		{
			_list.push(e);
			_mc.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(event:Event):void
		{
			_mc.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			if(_ed)
			{
				for each(var e:Event in _list)
				{
					_ed.dispatchEvent(e);
				}
			}
			_list.length = 0;
		}
	}
}