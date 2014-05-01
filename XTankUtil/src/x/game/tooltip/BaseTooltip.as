package x.game.tooltip
{    
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import de.polygonal.ds.HashMap;
	import de.polygonal.ds.Itr;
	
	import x.game.manager.StageManager;
	import x.game.tween.TweenLite;
    
    /**
     * 提示工具类
     * @author fraser
     *
     */
    public class BaseTooltip extends Sprite
    {
        private static const Y_OFFSET:int = 5;
        private static const X_OFFSET:int = 5;

        private var _map:HashMap;
        private var _currentTipSkin:BaseTipSkin;

        public function BaseTooltip()
        {
            _map = new HashMap(true) ;
        }

        public function add(target:InteractiveObject, tipSkin:Sprite):void
        {
			remove(target) ;
			//
            target.addEventListener(MouseEvent.ROLL_OVER, onTargetOver,false,0,true);
            target.addEventListener(MouseEvent.ROLL_OUT, onTargetOut,false,0,true);
            //
            _map.set(target, tipSkin);
        }

        public function remove(target:InteractiveObject):void
        {
           if( _map.hasKey(target))
            {
                target.removeEventListener(MouseEvent.ROLL_OVER, onTargetOver);
                target.removeEventListener(MouseEvent.ROLL_OUT, onTargetOut);
				//
				var baseTip:BaseTipSkin = _map.get(target) as BaseTipSkin;
				baseTip.dispose();
				baseTip = null;
                _map.clr(target);
            }
			target = null;
        }
		
		/** 隐藏所有Tip */
		public function hideAll():void
		{
			var itr:Itr = _map.iterator() ; 
			var tipSkin:BaseTipSkin ;
			while(itr.hasNext())
			{
				tipSkin = itr.next() as BaseTipSkin;
				tipSkin.hide() ;
			}
		}

        private function onTargetOver(evt:MouseEvent):void
        {
            var baseTip:BaseTipSkin = _map.get(evt.currentTarget as InteractiveObject) as BaseTipSkin;
            if (baseTip)
            {
				baseTip.show();
                _currentTipSkin = baseTip;
                deployTooltip(evt.stageX, evt.stageY, false);
				//
				StageManager.stage.addEventListener(MouseEvent.MOUSE_MOVE, onTooltipMove);
            }
        }

        private function onTargetOut(evt:MouseEvent):void
        {
			var baseTip:BaseTipSkin = _map.get(evt.currentTarget as InteractiveObject) as BaseTipSkin;
			baseTip.hide();
			//
            _currentTipSkin = null;
			StageManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onTooltipMove);
        }

        private function onTooltipMove(evt:MouseEvent):void
        {
            deployTooltip(evt.stageX, evt.stageY);
        }

        private function deployTooltip(tmpX:int, tmpY:int, isEasing:Boolean = true):void
        {
			var tipParent:DisplayObjectContainer = _currentTipSkin.parent;
			if (tipParent)
			{
				var tarX:int;
				var tarY:int;
				//
				var stageRect:Rectangle = StageManager.stageRect;
				var isFlipX:Boolean = true;
				if (_currentTipSkin.defaultDirX)
				{
					if ((tmpX + X_OFFSET + _currentTipSkin.width) > stageRect.right)
					{
						tarX = tmpX - _currentTipSkin.width - X_OFFSET;
						isFlipX = false;
					}
					else
					{
						tarX = tmpX + X_OFFSET;
						isFlipX = true;
					}
				}
				else
				{
					if ((tmpX - X_OFFSET - _currentTipSkin.width) < 0)
					{
						tarX = tmpX + X_OFFSET;
						isFlipX = true;
					}
					else
					{
						tarX = tmpX - _currentTipSkin.width - X_OFFSET;
						isFlipX = false;
					}
				}
				
				var isFlipY:Boolean = true;
				if (_currentTipSkin.defaultDirY)
				{
					if ((tmpY + Y_OFFSET + _currentTipSkin.height) > stageRect.bottom)
					{
						tarY = tmpY - _currentTipSkin.height - Y_OFFSET;
						isFlipY = false;
					}
					else
					{
						tarY = tmpY + Y_OFFSET;
						isFlipY = true;
					}
				}
				else
				{
					if ((tmpY - Y_OFFSET - _currentTipSkin.height) < 0)
					{
						tarY = tmpY + Y_OFFSET;
						isFlipY = true;
					}
					else
					{
						tarY = tmpY - _currentTipSkin.height - Y_OFFSET;
						isFlipY = false;
					}
				}
				_currentTipSkin.defaultDirX = isFlipX ;
				_currentTipSkin.defaultDirY = isFlipY ;
	
				if (isEasing)
				{
					var tween:TweenLite = TweenLite.to(_currentTipSkin, 0.2, {x:tarX, y:tarY,onComplete: function():void
					{
						tween.kill();
						tween = null;
					}}); 
				}
				else
				{
					_currentTipSkin.x = tarX;
					_currentTipSkin.y = tarY;
				}
			}
        }
    }
}