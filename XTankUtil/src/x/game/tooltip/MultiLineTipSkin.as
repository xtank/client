package x.game.tooltip
{
    import flash.display.Sprite;
    
    import x.game.manager.UIManager;

    /**
     * @author barlow
     * 多行文本 提示皮肤类
     */
    public class MultiLineTipSkin extends TextTipSkin
    {
        private var _bg_mc:Sprite;

        public function MultiLineTipSkin(tip:String)
        {
            super(UIManager.getSprite("TIP_RES_UI_MultiLineTipSkin"), tip);
        }
		
		override protected function initTipView():void
		{
			super.initTipView();
			//
			_bg_mc = _tipSkin["bg_mc"];
		}
		
		override protected function updateTipView():void
		{
			super.updateTipView();
			
			if (_bg_mc)
			{
				_bg_mc.width =  _tipTxt.width + 10;
				_bg_mc.height = _tipTxt.y + _tipTxt.height + 6;
			}
			
		}

        override public function dispose():void
        {
            _bg_mc = null;
            super.dispose();
        }
    }
}

