package x.game.ui.flipbar
{
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.text.TextField;
    
    import x.game.ui.XComponent;
    import x.game.ui.button.IButton;
    import x.game.ui.button.XButton;
    import x.game.ui.button.XSimpleButton;

    /**
     * 翻页组建
     * @author fraser
     *
     */
    public class XFlipBar extends XComponent
    {
        /** 回调主机 */
        protected var _initData:FlipBarInitData;
        /** 下一页按钮 */
        protected var _nextButton:IButton;
        /** 上一页按钮 */
        protected var _preButton:IButton;
        /** 页码文本 */
        protected var _pageTxt:TextField;

        public function XFlipBar(initData:FlipBarInitData, skin:Sprite)
        {
            super(skin) ;
			_initData = initData;
            //
            initComponents() ;
			//
			updateDisplay();
        }
        
        protected function initComponents():void
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
            _nextButton.soundName = _initData.soundName;
            _preButton.soundName = _initData.soundName;
            //
            _pageTxt = _skin[_initData.txtName];
        }

        override public function dispose():void
        {
			_initData = null;
            _nextButton.dispose();
            _preButton.dispose();
            _nextButton = null;
            _preButton = null;
            _pageTxt = null;
            super.dispose() ;
        }
		
		public function get skin():Sprite
		{
			return _skin as Sprite;
		}

        public function set dataProvide(value:Array):void
        {
			_initData.dataProvider = value ;
            updateDisplay();
        }

        public function get currentPageIndex():uint
        {
            return _initData.currentPage;
        }

        public function get totalPage():uint
        {
            return _initData.totalPage;
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

        protected function updateDisplay():void
        {
            if (_initData.host != null)
            {
				_initData.host.updatePageData(_initData.currentPageData);
            }
            if (_pageTxt != null)
            {
                _pageTxt.text = _initData.currentPage + "/" + _initData.totalPage;
            }
            //
            updateButtonStatus();
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
        }
    }
}
