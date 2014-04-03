package x.game.ui.flipbar
{
    import flash.display.DisplayObject;
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.text.TextField;
    
    import x.game.ui.XComponent;
    import x.game.ui.button.IButton;
    import x.game.ui.button.XButton;
    import x.game.ui.button.XSimpleButton;
    
    
    /**
     * XUIFlash - XSimpleFlipBar
     * 
     * Created By fraser on 2014-2-19
     * Copyright TAOMEE 2014.All rights reserved
     */
    public class XSimpleFlipBar extends XComponent
    {
        protected var _initData:SimpleFlipBarInitData;
        /** 下一页按钮 */
        protected var _nextButton:IButton;
        /** 上一页按钮 */
        protected var _preButton:IButton;
        /** 页码文本 */
        protected var _pageTxt:TextField;
        /** 首页按钮 */
        private var _firstButton:IButton;
        /** 末页按钮 */
        private var _lastButton:IButton;
        
        public function XSimpleFlipBar(initData:SimpleFlipBarInitData,skin:DisplayObject)
        {
            super(skin);
            _initData = initData;
            initComponents() ;
            //
            updateDisplay() ;
        }
        
        override public function dispose():void
        {
            _initData = null;
            _nextButton.dispose();
            _preButton.dispose();
            _nextButton = null;
            _preButton = null;
            _pageTxt = null;
            _firstButton.dispose() ;
            _firstButton = null;
            _lastButton.dispose() ;
            _lastButton = null;
            super.dispose() ;
        }
        
        public function get skin():Sprite
        {
            return _skin as Sprite;
        }
        
        private function initComponents():void
        {
            if(_skin[_initData.nxtBtnName] is SimpleButton)
            {
                _nextButton = new XSimpleButton(_skin[_initData.nxtBtnName]);
            }
            else
            {
                _nextButton = new XButton(_skin[_initData.nxtBtnName]);
            }
            //
            if(_skin[_initData.preBtnName] is SimpleButton)
            {
                _preButton = new XSimpleButton(_skin[_initData.preBtnName]);
            }
            else
            {
                _preButton = new XButton(_skin[_initData.preBtnName]);
            }
            //
            _nextButton.addClick(onNextButton);
            _preButton.addClick(onPreButton);
            //
            _pageTxt = _skin[_initData.txtName];
            //
            if(_skin[_initData.firstBtnName] is SimpleButton)
            {
                _firstButton = new XSimpleButton(skin[_initData.firstBtnName]);
            }
            else
            {
                _firstButton = new XButton(skin[_initData.firstBtnName]);
            }
            //
            if(_skin[_initData.firstBtnName] is SimpleButton)
            {
                _lastButton = new XSimpleButton(skin[_initData.lastBtnName]);
            }
            else
            {
                _lastButton = new XButton(skin[_initData.lastBtnName]);
            }
            _firstButton.addClick(onClick);
            _lastButton.addClick(onClick);
        }
        
        private function onClick(button:IButton):void
        {
            if (button == _firstButton)
            {
                setPage(1);
            }
            else if (button == _lastButton)
            {
                setPage(totalPage);
            }
        }
        
        public function get totalPage():uint
        {
            return _initData.totalPage;
        }
        
        public function set totalPage(value:uint):void
        {
            if(_initData.totalPage == value)
                return ;
            _initData.totalPage = value ;
            if(_initData.currentPage > value)
            {
                _initData.changeToPage(totalPage) ;
            }
            
            if (_pageTxt != null)
            {
                _pageTxt.text = _initData.currentPage + "/" + _initData.totalPage;
            }
            //
            updateButtonStatus();
        }
        
        public function setPage(page:int):void
        {
            if(_initData.changeToPage(page))
            {
                updateDisplay();
            }
        }
        
        protected function onPreButton(button:IButton):void
        {
            if (_initData.prev())
            {
                updateDisplay();
            }
        }
        
        protected function onNextButton(button:IButton):void
        {
            if (_initData.next())
            {
                updateDisplay();
            }
        }
        
        protected function updateButtonStatus():void
        {
            if (_initData.currentPage <= 1)
            {
                _preButton.enable = false;
                _preButton.gray = true;
            }
            else
            {
                _preButton.enable = true;
                _preButton.gray = false;
            }
            
            if (_initData.currentPage >= _initData.totalPage)
            {
                _nextButton.enable = false;
                _nextButton.gray = true;
            }
            else
            {
                _nextButton.enable = true;
                _nextButton.gray = false;
            }
            if(_initData.currentPage <= 1)
            {
                _firstButton.enable = false ;
                _firstButton.gray = true;
            }
            else
            {
                _firstButton.enable = true ;
                _firstButton.gray = false;
            }
            
            if(_initData.currentPage >= _initData.totalPage)
            {				
                _lastButton.enable = false ;
                _lastButton.gray = true;
            }
            else
            {
                _lastButton.enable = true ;
                _lastButton.gray = false;
            }
        }
        
        protected function updateDisplay():void
        {
            if (_initData.host != null)
            {
                _initData.host.update(_initData.currentPage);
            }
            if (_pageTxt != null)
            {
                _pageTxt.text = _initData.currentPage + "/" + _initData.totalPage;
            }
            //
            updateButtonStatus();
        }
    }
}