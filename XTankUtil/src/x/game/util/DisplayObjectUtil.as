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
		
		public static function align(target:DisplayObject, bounds:Rectangle, horizontalAlign:String = "center", verticalAlign:String = "middle"):void
		{	
			var horizontalDifference:Number = bounds.width - target.width;
			switch(horizontalAlign)
			{
				case "left":
					target.x = bounds.x;
					break;
				case "center":
					target.x = bounds.x + (horizontalDifference) / 2;
					break;
				case "right":
					target.x = bounds.x + horizontalDifference;
					break;
			}
			
			var verticalDifference:Number = bounds.height - target.height;
			switch(verticalAlign)
			{
				case "top":
					target.y = bounds.y;
					break;
				case "middle":
					target.y = bounds.y + (verticalDifference) / 2;
					break;
				case "bottom":
					target.y = bounds.y + verticalDifference;
					break;
			}
		}
		
		public static function resizeAndMaintainAspectRatio(target:DisplayObject, width:Number, height:Number, aspectRatio:Number = NaN):void
		{
			var currentAspectRatio:Number = !isNaN(aspectRatio) ? aspectRatio : target.width / target.height;
			var boundsAspectRatio:Number = width / height;
			
			if(currentAspectRatio < boundsAspectRatio)
			{
				target.width = int(height * currentAspectRatio);
				target.height = height;
			}
			else
			{
				target.width = width;
				target.height = int(width / currentAspectRatio);
			}
		}
		
		
		/**
		 * 停止一个容器里的所有MovieClip,如果当前容器是MovieClip，也停止
		 * @param dis
		 *
		 */
		public static function stopAllMovieClip(dis:DisplayObjectContainer):void
		{
			var mc:MovieClip = dis as MovieClip;
			if (mc != null)
			{
				mc.stop();
				mc = null;
			}
			var num:int = dis.numChildren - 1;
			if (num < 0)
			{
				return;
			}
			var child:DisplayObjectContainer;
			var i:int = num;
			for (i; i >= 0; i--)
			{
				child = dis.getChildAt(i) as DisplayObjectContainer;
				if (child != null)
				{
					stopAllMovieClip(child);
				}
			}
		}
		
		/**
		 * 移除容器里的所有显示对象
		 * @param dis
		 *
		 */
		public static function removeAllChildren(dis:DisplayObjectContainer):void
		{
			var child:DisplayObjectContainer;
			while (dis.numChildren > 0)
			{
				child = dis.removeChildAt(0) as DisplayObjectContainer;
				if (child != null)
				{
					stopAllMovieClip(child);
					child = null;
				}
				
			}
		}
		
		/**
		 * 从该显示对象的父级移除该显示对象
		 * @param dis
		 *
		 */
		public static function removeFromParent(dis:DisplayObject,gc:Boolean = true):void
		{
			if(dis == null)
			{
				return;
			}
			if (dis.parent == null)
			{
				return ;
			}
			if(!dis.parent.contains(dis))
			{
				return ;
			}
			if(gc)
			{
				var disc:DisplayObjectContainer = dis as DisplayObjectContainer;
				if(disc)
				{
					stopAllMovieClip(disc);
					disc = null;
				}
			}
			dis.parent.removeChild(dis);
		}
		
		public static function hasParent(target:DisplayObject):Boolean
		{
			if (target.parent == null)
			{
				return false;
			}
			return target.parent.contains(target);
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
