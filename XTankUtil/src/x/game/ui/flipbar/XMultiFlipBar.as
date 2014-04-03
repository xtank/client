package x.game.ui.flipbar
{
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    
    import x.game.ui.button.IButton;
    import x.game.ui.button.XButton;
    import x.game.ui.button.XSimpleButton;

    /**
     * 有第一页 和 最后一页的翻页组建
     * @author fraser
     *
     */
    public class XMultiFlipBar extends XFlipBar
    {
        /** 首页按钮 */
        private var _firstButton:IButton;
        /** 末页按钮 */
        private var _lastButton:IButton;

        public function XMultiFlipBar(initData:FlipBarInitData, skin:Sprite)
        {
            super(initData, skin);
        }
        //
        override protected function initComponents():void
        {
            super.initComponents() ;
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
            _firstButton.soundName = _initData.soundName;
            _lastButton.soundName = _initData.soundName;
            _firstButton.addClick(onClick);
            _lastButton.addClick(onClick);
        }
//		
		override protected function updateButtonStatus():void
		{
			super.updateButtonStatus() ;
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
//		
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
//		
		override public function dispose():void
		{
			super.dispose() ;
			_firstButton.dispose() ;
			_firstButton = null;
			_lastButton.dispose() ;
			_lastButton = null;
		}
    }
}
