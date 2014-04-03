package x.game.ui.button
{
    import flash.display.DisplayObject;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;


    /**
     * @author fraser
     * 创建时间：2013-7-19下午4:21:43
     * 类说明：todo 添加类注释
     */
    public class XToggleButton extends XSimpleButton implements IToggleButton
    {
        /** 按钮皮肤状态 */
        private var _upState:DisplayObject;
        private var _downState:DisplayObject;
        private var _overState:DisplayObject;
        /** 是否为选中状态  */
        private var _selected:Boolean;

        public function XToggleButton(skin:SimpleButton, data:Object = null, statisticsTag:Object = null, soundName:String =
            "")
        {
            super(skin, data, statisticsTag, soundName);
            //
            _upState = skin.upState;
            _downState = skin.downState;
            _overState = skin.overState;
            //
            initClickListener();
        }

        override public function dispose():void
        {
            _upState = null;
            _downState = null;
            _overState = null;
            //
            skin.removeEventListener(MouseEvent.MOUSE_DOWN, onUIDown);
            //
            super.dispose();
        }

        override protected function initClickListener():void
        {
            if (_clickFuns == null)
            {
                _clickFuns = new Vector.<Function>();
                skin.addEventListener(MouseEvent.MOUSE_DOWN, onUIDown);
            }
        }

        override protected function onUIClick(event:MouseEvent):void
        {
            // do nothing	
        }

        override public function clickManual():void
        {
            onUIDown(null);
        }

        protected function onUIDown(event:MouseEvent):void
        {
            if (_enable)
            {
                selected = !selected ;
                //
                var len:uint = _clickFuns.length;
                for (var i:uint = 0; i < len; i++)
                {
                    _clickFuns[i](this);
                }
            }
        }
        
        public function set selected(value:Boolean):void
        {
            _selected = value;
            
            if (_selected) // 按下状态
            {
                skin.overState = _downState;
                skin.upState = _downState;
                skin.downState = _downState;
            }
            else //复位状态
            {
                skin.overState = _overState;
                skin.upState = _upState;
                skin.downState = _downState;
            }
        }

        public function get selected():Boolean
        {
            return _selected;
        }

        public function set toggle(value:Boolean):void
        {
            // do nothing
        }

        public function get toggle():Boolean
        {
            return true;
        }

    }
}
