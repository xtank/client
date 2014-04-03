package x.game.module {
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import x.game.drag.MouseDragUtil;
	import x.game.manager.StageManager;
	
	/**
	 * A DraggableSprite is a Sprite that has the ability to interact
	 * with the Mouse in drag and drop scenarios.  All Sprites have
	 * the startDrop() and stopDrag() methods, but those methods only
	 * update the display list during enterFrame events, instead of
	 * during mouseMove events, which leads to choppy dragging.  The
	 * DraggableSprite provides a drag() method, similar to startDrag()
	 * and a drop() method, similar to stopDrag(), that enable smooth
	 * drag and drop operations.
	 */
	public class DraggableSprite extends Sprite 
	{
		private var _drag:MouseDragUtil;
		
		/**
		 * Constructor - nothing to do
		 */
		public function DraggableSprite()
		{
			// do nothing
		}
		
		/**
		 * Starts a smooth dragging operation, forcing the player to redraw
		 * the Sprite after every mouse move.  Cancel the drag() operation
		 * by calling the drop() method.
		 */
		public function drag( lockCenter:Boolean = false, rectangle:Rectangle = null ):void 
		{
			if (_drag == null)
			{
				_drag = new MouseDragUtil(this, rectangle);
			}
			
			_drag.drag(StageManager.stageRect);
		}
		
		public function dispose():void
		{
			if (_drag)
			{
				_drag.dispose();
				_drag = null;
			}
		}
	}
}