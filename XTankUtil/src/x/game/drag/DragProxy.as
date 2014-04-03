package x.game.drag
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	import x.game.util.DisplayObjectUtil;

	public class DragProxy extends Sprite
	{
		public var icon:Bitmap;
		public var dragData:Object ;
		public var dropTest:IDropable ;
		public var dropComplete:IDragable ;
		public var target:Sprite ;
		
		/**
		 *  
		 * @param iconData
		 * @param dragData
		 * @param dropTest    	@param dragProxy  返回值能接收该拖拽数据的实例引用
		 * @param dropComplete
		 *  
		 */
		public function init(iconData:Bitmap, dragData:Object, dropTest:IDropable,dropComplete:IDragable):void
		{
			this.dragData = dragData;
			this.dropTest = dropTest;
			this.dropComplete = dropComplete;
			//
			this.icon = iconData;
			addChild(iconData);
			// 
			this.graphics.clear() ;
			this.graphics.beginFill(0xff0000,.5) ;
			this.graphics.drawRect(0,0,iconData.width,iconData.height) ;
			this.graphics.endFill() ;
		}
		
		public function dispose():void
		{
			
		}
		
		public function reset():void
		{
			DisplayObjectUtil.removeAllChildren(this) ;
			icon = null;
			dragData = null;
			dropTest = null;
			dropComplete = null;
		}
		
		public function dropFail():void
		{
			DisplayObjectUtil.removeFromParent(this);
			stopDrag();
			dropComplete.dropComplete(false, this)
		}
		
		public function dropSuccess(target:Sprite):void
		{
			this.target = target ;
			DisplayObjectUtil.removeFromParent(this);
			stopDrag();
			dropComplete.dropComplete(true, this)
		}
	}
}