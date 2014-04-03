package x.game.ui
{
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    
    import x.game.util.DisplayObjectUtil;


    /**
     * @author fraser
     * 创建时间：2013-7-19下午3:39:25
     * 类说明：基类
     */
    public class XSpriteComponent extends XComponent
    {
        private var _clickFuns:Vector.<Function>;
        private var _enable:Boolean;

        public function XSpriteComponent(skin:Sprite)
        {
            super(skin);
        }
		
		override public function dispose():void
		{
			_clickFuns = null ;
			//TooltipManager.remove(skin);
			super.dispose();
		}

        override public function set enable(value:Boolean):void
        {
            if (_enable != value)
            {
                _enable = value;
                if(_enable)
                {
                    DisplayObjectUtil.enableTarget(skin);
                }
                else
                {
                    DisplayObjectUtil.disableTarget(skin);
                }
            }
        }

        override public function get enable():Boolean
        {
            return _enable;
        }

        public function get skin():Sprite
        {
            return _skin as Sprite;
        }

        public function addClick(fun:Function):void
        {
            if (_clickFuns == null)
            {
                _clickFuns = new Vector.<Function>();
                //
                skin.buttonMode = true;
                skin.addEventListener(MouseEvent.CLICK, onUIClick);
            }
            //
            if (_clickFuns.indexOf(fun) == -1)
            {
                _clickFuns.push(fun);
            }
        }

        public function removeClick(fun:Function):void
        {
            if (_clickFuns == null)
            {
                return;
            }
            var index:int = _clickFuns.indexOf(fun);
            if (index != -1)
            {
                _clickFuns.splice(index, 1);
            }
        }

        private function onUIClick(event:MouseEvent):void
        {
            var len:uint = _clickFuns.length;
            for (var i:uint = 0; i < len; i++)
            {
                _clickFuns[i](this);
            }
        }
    }
}
