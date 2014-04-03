package x.game.drag
{	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import x.game.core.IDisposeable;
	import x.game.manager.StageManager;
	import x.game.tick.TimeTicker;
	import x.game.util.DisplayObjectUtil;


	/**
	 * 跟随
	 *
	 * @author barlow
	 * <p>创建日期 2012-6-16</p>
	 * */
	public class MouseDragUtil extends EventDispatcher implements IDisposeable
	{
		/** 拖动停止 */
		public static const DRAG_STOP:String = "MouseDrag_Stop";
		/** 移动 */
		public static const DRAG_MOVE:String = "MouseDrag_Move";
		
		private var _target:DisplayObject;		
		private var _startPos:Point;
		private var _oldPos:Point;
		private var _rect:Rectangle;
		//
		private var _index:uint ;
		
		public function MouseDragUtil(disObj:DisplayObject, rect:Rectangle = null)
		{
			_rect = rect == null ? StageManager.stageRect : rect;
			
			_target = disObj;
			drag(rect);
		}
		
		public function drag(rect:Rectangle):void
		{
			DisplayObjectUtil.switchToTop(_target);
			
			_oldPos = new Point(_target.x, _target.y);
			_startPos = new Point(StageManager.stage.mouseX,StageManager.stage.mouseY);
			
			StageManager.stage.addEventListener(MouseEvent.MOUSE_UP, onDragUp);
			_index = TimeTicker.setInterval(1000, onMove) ;
		}
		
		private function onMove(delay:Number):void
		{
			var disPos:Point = new Point(StageManager.stage.mouseX - _startPos.x ,StageManager.stage.mouseY - _startPos.y);
			var endPos:Point = new Point(_oldPos.x + disPos.x, _oldPos.y + disPos.y);
			
			if (StageManager.stage.mouseX >= 0 && StageManager.stage.mouseX <= _rect.width)
			{
				_target.x = endPos.x;
			}
			if (StageManager.stage.mouseY >= 0 && StageManager.stage.mouseY <= _rect.height)
			{
				_target.y = endPos.y;
			}
			//
			dispatchEvent(new Event(DRAG_MOVE));
		}
		
		protected function onDragUp(e:MouseEvent):void
		{
			dispose();
		}
		
		public function dispose():void
		{
			StageManager.stage.removeEventListener(MouseEvent.MOUSE_UP, onDragUp);
			TimeTicker.clear(_index) ;
			//
			dispatchEvent(new Event(DRAG_STOP));
		}

		public function get target():DisplayObject
		{
			return _target;
		}
	}
}