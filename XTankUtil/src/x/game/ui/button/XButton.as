package x.game.ui.button
{
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    
    import x.game.ui.XComponent;
    import x.game.util.DisplayObjectUtil;


    /**
     * XFlash - XButton
     *
     * Created By fraser on 2014-2-9
     * Copyright TAOMEE 2014.All rights reserved
     */
    public class XButton extends XComponent implements IButton, IToggleButton
    {
        private var UP:uint = 1;
        private var OVER:uint = 2;
        private var DOWN:uint = 3;
        private var DISABLE:uint = 4;
        //
        protected var _clickFuns:Vector.<Function>;
        protected var _downClickFuns:Vector.<Function>;
        
        /** 点击音效 */
        protected var _soundName:String = "";
        /** 统计地址 */
        protected var _statisticsTag:*;
        /** 按钮是否可用 */
        protected var _enable:Boolean = true;
        // 是否选中
        private var _selected:Boolean;
        // 是否是开关按钮
        private var _toggle:Boolean;
        
        public function XButton(skin:MovieClip, data:Object = null, upFrameIndex:uint = 1, overFrameIndex:uint = 2, downFrameIndex:uint =
            3, disableFrameIndex:uint = 4, statisticsTag:Object = null, soundName:String = "")
        {
            super(skin);
            //
            _data = data;
            _soundName = soundName;
            _statisticsTag = statisticsTag;
            //
            skin.buttonMode = true;
            skin.useHandCursor = true;
            //
            skin.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
            skin.addEventListener(MouseEvent.MOUSE_UP, onUp);
            skin.addEventListener(MouseEvent.ROLL_OVER, onOver);
            skin.addEventListener(MouseEvent.ROLL_OUT, onOut);
            //
            UP = upFrameIndex;
            OVER = overFrameIndex;
            DOWN = downFrameIndex;
            DISABLE = disableFrameIndex;
            //
            changeButtonStatus(UP);
        }

        override public function dispose():void
        {
            _clickFuns = null;
            //
            skin.removeEventListener(MouseEvent.CLICK, onButtonClick);
            skin.removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
            skin.removeEventListener(MouseEvent.MOUSE_UP, onUp);
            skin.removeEventListener(MouseEvent.ROLL_OVER, onOver);
            skin.removeEventListener(MouseEvent.ROLL_OUT, onOut);
            //
            // TooltipManager.remove(skin);
            //
            super.dispose();
        }

        override public function set enable(value:Boolean):void
        {
            if (_enable != value)
            {
                _enable = value;
                _enable ? DisplayObjectUtil.enableTarget(skin) : DisplayObjectUtil.disableTarget(skin);
                skin.enabled = _enable;
            }
        }

        override public function get enable():Boolean
        {
            return _enable;
        }

        protected function initClickListener():void
        {
            if (_clickFuns == null)
            {
                _clickFuns = new Vector.<Function>();
                //
                skin.addEventListener(MouseEvent.CLICK, onButtonClick);
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

        public function get skin():MovieClip
        {
            return _skin as MovieClip;
        }

        public function clickManual():void
        {
            onButtonClick(null);
        }
        
        // 
        public function addDownClick(fun:Function):void 
        {
            if (_downClickFuns == null)
            {
                _downClickFuns = new Vector.<Function>();
            }
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

        public function addClick(fun:Function):void
        {
            initClickListener();
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
            //
            var index:int = _clickFuns.indexOf(fun);
            if (index != -1)
            {
                _clickFuns.splice(index, 1);
            }
        }

        protected function onButtonClick(event:MouseEvent):void
        {
            if (_enable)
            {
                for each (var fun:Function in _clickFuns)
                {
                    fun(this);
                }
            }
        }

        public function get toggle():Boolean
        {
            return _toggle;
        }

        public function set toggle(value:Boolean):void
        {
            _toggle = value;
        }

        public function get selected():Boolean
        {
            return _selected;
        } 
        
        public function set selected(value:Boolean):void
        {
            _selected = value;
            
            if (_toggle == true)
            {
                changeButtonStatus(_selected ? DOWN : UP);
            }
            else
            {
                changeButtonStatus(DOWN);
            }
        }

        protected function onOver(event:MouseEvent):void
        {
            if (_enable)
            {
                changeButtonStatus(OVER);
            }
        }

        protected function onOut(event:MouseEvent):void
        {
            if (_enable)
            {
                if (_toggle == true)
                {
                    changeButtonStatus(_selected ? DOWN : UP);
                }
                else
                {
                    changeButtonStatus(UP);
                }
            }
        }

        protected function onDown(event:MouseEvent):void
        {
            if (_enable)
            {
                selected = !selected ;
                for each (var fun:Function in _downClickFuns)
                {
                    fun(this);
                }
            }
        }

        protected function onUp(event:MouseEvent):void
        {
            if (_enable)
            {
                changeButtonStatus(UP);
            }
        }

        protected function changeButtonStatus(status:uint):void
        {
            skin.gotoAndStop(status);
        }
    }
}
