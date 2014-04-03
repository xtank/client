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
     * <-- 按钮    leftBtn
     * --> 按钮    rightBtn
     * 
     */
    public class HScroller extends Scroller
    {
        /** 往上按钮 */
        private var _leftBtn:IButton;
        /** 往下按钮 */
        private var _rightBtn:IButton;
        //
        private var _xOffset:Number;
        /**  */
        private var _leftLimit:Number;
        /**  */
        private var _rightLimit:Number;
        
        public function HScroller(mainUI:MovieClip, onScroll:Function, initData:ScrollerInitData)
        {
            super(mainUI,onScroll,initData);
        }
        
        override protected function initComponents():void
        {
            super.initComponents() ;
            if (skin[_initData.upBtnName] != null)
            {
                if(_skin[_initData.upBtnName] is SimpleButton)
                {
                    _leftBtn = new XSimpleButton(skin[_initData.upBtnName]);
                }
                else
                {
                    _leftBtn = new XButton(skin[_initData.upBtnName]);
                }
                
                _leftBtn.addDownClick(onUp);
            }
            //
            if (skin[_initData.downBtnName] != null)
            {
                if(_skin[_initData.downBtnName] is SimpleButton)
                {
                    _rightBtn = new XSimpleButton(skin[_initData.downBtnName]);
                }
                else
                {
                    _rightBtn = new XButton(skin[_initData.downBtnName]);
                }
                _rightBtn.addDownClick(onDown);
            }
            
            //
            _leftLimit = skin[_initData.trackName].x;
            if (_leftBtn != null)
            {
                _leftLimit += _leftBtn.width;
            }
            _thumbRange = skin[_initData.trackName].width - _sliderBtn.width;
            if (_leftBtn != null)
            {
                _thumbRange -= _leftBtn.width;
            }
            if (_rightBtn != null)
            {
                _thumbRange -= _rightBtn.width;
            }
            _rightLimit = _leftLimit + _thumbRange;
            //
            _sliderBtn.x = _leftLimit;
        }
        
        override public function dispose():void
        {
            if (_leftBtn != null)
            {
                _leftBtn.dispose();
                _leftBtn = null;
            }
            if (_rightBtn != null)
            {
                _rightBtn.dispose();
                _rightBtn = null;
            }
            
            //
            super.dispose();
        }
        
        override public function set scrollPercent(value:Number):void
        {
            super.scrollPercent = value ;
            _sliderBtn.x = _scrollPercent * _thumbRange + _leftLimit; 
        }
        
        override protected function thumb_onMouseDown(btn:IButton):void
        {
            _xOffset = skin.mouseX - _sliderBtn.x;
            super.thumb_onMouseDown(btn) ;
        }
        
        override protected function stage_onMouseMove(event:MouseEvent):void
        {
            var tarX:Number = skin.mouseX - _xOffset;
            if (tarX < _leftLimit)
            {
                tarX = _leftLimit;
            }
            else if (tarX > _rightLimit)
            {
                tarX = _rightLimit;
            }
            scrollPercent = (tarX - _leftLimit) / _thumbRange;
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


