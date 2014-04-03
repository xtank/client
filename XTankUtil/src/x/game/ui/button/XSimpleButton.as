package x.game.ui.button
{
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    
    import x.game.ui.XComponent;

    /**
     * @author fraser
     * 创建时间：2013-7-19下午3:53:43
     * 类说明：
     */
    public class XSimpleButton extends XComponent implements IButton
    {
        protected var _clickFuns:Vector.<Function>;
        protected var _downClickFuns:Vector.<Function>;
        /** 点击音效 */
		protected var _soundName:String = "";
        /** 统计地址 */
		protected var _statisticsTag:* ;
        /** 按钮是否可用 */
		protected var _enable:Boolean = true;
        // 不可用时是否灰化
        protected var _grayWhenDisable:Boolean = false ;

        public function XSimpleButton(skin:SimpleButton, data:Object = null, statisticsTag:Object = null, soundName:String = "")
        {
            super(skin);
            //
            _data = data;
            _soundName = soundName;
            _statisticsTag = statisticsTag;
        }

		override public function dispose():void
		{
			_clickFuns = null;
            skin.removeEventListener(MouseEvent.MOUSE_DOWN,onDownClick) ;
            skin.removeEventListener(MouseEvent.CLICK, onUIClick);
            //
			// TooltipManager.remove(skin);
			//
			super.dispose();
		}
		
		protected function initClickListener():void
		{
			if (_clickFuns == null)
			{
				_clickFuns = new Vector.<Function>();
                skin.addEventListener(MouseEvent.CLICK, onUIClick);
			}
		}
        
        protected function initDownClickListener():void
        {
            if (_downClickFuns == null)
            {
                _downClickFuns = new Vector.<Function>();
                skin.addEventListener(MouseEvent.MOUSE_DOWN, onDownClick);
            }
        }

        public function get skin():SimpleButton
        {
            return _skin as SimpleButton;
        }

        public function clickManual():void
        {
            onUIClick(null);
        }

        public function addClick(fun:Function):void
        {
			initClickListener() ;
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
        
        protected function onDownClick(event:MouseEvent):void
        {
            if (_enable)
            {
                var len:uint = _downClickFuns.length;
                for (var i:uint = 0; i < len; i++)
                {
                    _downClickFuns[i](this);
                }
            }
        }

        protected function onUIClick(event:MouseEvent):void
        {
            if (_enable)
            {
                var len:uint = _clickFuns.length;
                for (var i:uint = 0; i < len; i++)
                {
                    _clickFuns[i](this);
                }
            }
        }
        
        // 
        public function addDownClick(fun:Function):void 
        {
            initDownClickListener() ;
            //
            if (_downClickFuns.indexOf(fun) == -1)
            {
                _downClickFuns.push(fun);
            }
        }
        
        public function removeDownClick(fun:Function):void 
        {
            if (_downClickFuns == null)
            {
                return;
            }
            //
            var index:int = _downClickFuns.indexOf(fun);
            if (index != -1)
            {
                _downClickFuns.splice(index, 1);
            }
        }

        override public function set enable(value:Boolean):void
        {
            if (_enable != value)
            {
                _enable = value;
                skin.enabled = _enable;
                if(_grayWhenDisable)
                {
                    gray = !_enable ;
                }
                else
                {
                    gray = false ;
                }
            }
        }

		override public function get enable():Boolean
        {
            return _enable;
        }
        
        public function get grayWhenDisable():Boolean
        {
            return _grayWhenDisable;
        }
        
        public function set grayWhenDisable(value:Boolean):void
        {
            _grayWhenDisable = value;
            //
            if(_grayWhenDisable)
            {
                gray = !_enable ;
            }
            else
            {
                gray = false ;
            }
        }

        public function set statisticsTag(value:*):void
        {
            _statisticsTag = value;
        }

        public function set soundName(name:String):void
        {
            _soundName = name;
        }
    }
}
