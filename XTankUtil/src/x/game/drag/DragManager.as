package x.game.drag
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	
	/**
	 * 拖拽管理器 
	 * @author fraser
	 * 
	 */
	public class DragManager
	{
		private static var _stage:Stage;
		private static var _parentContainer:DisplayObjectContainer;

		public static function init(stage:Stage,parentContainer:DisplayObjectContainer):void
		{
			_stage=stage;
			_parentContainer = parentContainer ;
		}
		
		private static var _currentDragProxy:DragProxy;
		
		public static function startDrag(source:DisplayObject, dragData:Object,dropComplete:IDragable,dropTest:IDropable):void
		{
			_stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			//
			_currentDragProxy = new DragProxy() ;
			//
			var bmd:BitmapData = new BitmapData(source.width,source.height) ;
			bmd.draw(source) ;
			_currentDragProxy.init(new Bitmap(bmd), dragData, dropTest, dropComplete);
			_currentDragProxy.startDrag(true);
			//
			_parentContainer.addChild(_currentDragProxy) ;
		}
		
		private static function onMouseUp(event:MouseEvent):void
		{
			_stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			//
			var target:Sprite = _currentDragProxy.dropTest.drop(_currentDragProxy) ;
			if (target != null)
			{
				_currentDragProxy.dropSuccess(target);
			}
			else
			{
				_currentDragProxy.dropFail();
			}
			
		}
	}
}
