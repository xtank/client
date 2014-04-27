package x.game.ui.scroller
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    
    import x.game.ui.button.IButton;
    import x.game.ui.button.XButton;
    import x.game.ui.button.XSimpleButton;

    /**
     * 滚动条包装
     * @author fraser
     *
     * 滚动条组成原件：
     * 向上按钮    upBtn
     * 向下按钮    downBtn
     * 滑块按钮    sliderBtn
     * 轨道        track
     *
     */
    public class VScroller extends Scroller
    {
        /** 往上按钮 */
        private var _upBtn:IButton;
        /** 往下按钮 */
        private var _downBtn:IButton;
        
        //
        private var _yOffset:Number;
        /**  */
        private var _topLimit:Number;
        /**  */
        private var _bottomLimit:Number;
        
        public function VScroller(mainUI:MovieClip, onScroll:Function, initData:ScrollerInitData)
        {
            super(mainUI,onScroll,initData);
            //
        }
        
        override protected function initComponents():void
        {
            super.initComponents() ;
            if (skin[_initData.upBtnName] != null)
            {
                if(_skin[_initData.upBtnName] is SimpleButton)
                {
                    _upBtn = new XSimpleButton(skin[_initData.upBtnName]);
                }
                else
                {
                    _upBtn = new XButton(skin[_initData.upBtnName]);
                }
                
                _upBtn.addDownClick(onUp);
            }
            //
            if (skin[_initData.downBtnName] != null)
            {
                if(_skin[_initData.downBtnName] is SimpleButton)
                {
                    _downBtn = new XSimpleButton(skin[_initData.downBtnName]);
                }
                else
                {
                    _downBtn = new XButton(skin[_initData.downBtnName]);
                }
                _downBtn.addDownClick(onDown);
            }
            
            //
            _topLimit = skin[_initData.trackName].y;
//            if (_upBtn != null)
//            {
//                _topLimit += _upBtn.height;
//            }
            _thumbRange = skin[_initData.trackName].height - _sliderBtn.height;
//            if (_upBtn != null)
//            {
//                _thumbRange -= _upBtn.height;
//            }
//            if (_downBtn != null)
//            {
//                _thumbRange -= _downBtn.height;
//            }
            _bottomLimit = _topLimit + _thumbRange;
            _sliderBtn.y = _topLimit;
        }

        override public function dispose():void
        {
            if (_upBtn != null)
            {
                _upBtn.dispose();
                _upBtn = null;
            }
            if (_downBtn != null)
            {
                _downBtn.dispose();
                _downBtn = null;
            }

            //
            super.dispose();
        }
        
        override public function set scrollPercent(value:Number):void
        {
            super.scrollPercent = value ;
            _sliderBtn.y = _scrollPercent * _thumbRange + _topLimit; 
        }

        override protected function thumb_onMouseDown(btn:IButton):void
        {
            _yOffset = skin.mouseY - _sliderBtn.y;
            super.thumb_onMouseDown(btn) ;
        }

        override protected function stage_onMouseMove(event:MouseEvent):void
        {
            var tarY:Number = skin.mouseY - _yOffset;
            if (tarY < _topLimit)
            {
                tarY = _topLimit;
            }
            else if (tarY > _bottomLimit)
            {
                tarY = _bottomLimit;
            }
            scrollPercent = (tarY - _topLimit) / _thumbRange;
        }

        private function onDown(btn:IButton):void
        {
            _curSpeed = _initData.speed;
            startMoveSpeed();
        }

        private function onUp(btn:IButton):void
        {
            _curSpeed = -_initData.speed;
            startMoveSpeed();
        }
    }
}
