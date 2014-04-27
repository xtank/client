package x.game.util
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	public class DisplayObjectUtil
	{
		/** 自动对焦中心点 */
		public static function ajustCoordinate(displayObject:DisplayObject):void
		{
			var parent:DisplayObjectContainer = displayObject.parent;
			if (parent == null)
			{
				return;
			}
			var rect:Rectangle = displayObject.getBounds(parent);
			displayObject.x = -rect.left - rect.width / 2;
			displayObject.y = -rect.top - rect.height;
		}
		
		public static function setPosition(view:DisplayObject, dx:Number, dy:Number):void
		{
			view.x = dx - view.getBounds(view).left;
			view.y = dy - view.getBounds(view).top;
		}
		
		/** 放置到底层  */
		static public function switchToBottom(target:DisplayObject):void
		{
			var parent:DisplayObjectContainer = target.parent;
			if (parent != null)
			{
				parent.setChildIndex(target, 0);
			}
		}
		
		/** 放置到顶层  */
		static public function switchToTop(target:DisplayObject):void
		{
			var parent:DisplayObjectContainer = target.parent;
			if (parent != null)
			{
				parent.setChildIndex(target, parent.numChildren - 1);
			}
		}
		
		static public function removeAllChildren(target:DisplayObjectContainer):void
		{
			if (target != null)
			{
                if(target is MovieClip)
                {
                    MovieClipUtil.stopChild(target as MovieClip);
                }
				var child:DisplayObject;
				while (target.numChildren > 0)
				{
					child = target.removeChildAt(0);
				}
			}
		}
		
		static public function removeFromParent(target:DisplayObject):void
		{
			if (target && target.parent != null)
			{
				target.parent.removeChild(target);
				//
				if (target is MovieClip)
				{
					MovieClipUtil.stopAllChildren(target as MovieClip);
				}
			}
		}
		
		static public function disableTarget(target:InteractiveObject):void
		{
			if (target != null)
			{
				target.mouseEnabled = false ;
				if(target is Sprite)
				{
					(target as Sprite).mouseChildren = false;
				}
			}
		}
		
		static public function enableTarget(target:InteractiveObject):void
		{
			if (target != null)
			{
				target.mouseEnabled = true ;
				if(target is Sprite)
				{
					(target as Sprite).mouseChildren = true;
				}
			}
		}
		
		/** 是否灰化 */
		static public function enableGray(target:DisplayObject, value:Boolean):void
		{
            if(value)
            {
                ColorFilter.setGrayscale(target,1) ;
            }
            else
            {
                ColorFilter.cacelGrayscale(target) ; 
            }
		}
        
        public static function recoverDisplayObject(displayObj:DisplayObject):void
        {
            displayObj.filters = [];
        }
	}
}
