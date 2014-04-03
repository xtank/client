package x.game.tooltip
{
    import flash.display.Sprite;
    import flash.text.TextFieldAutoSize;
    
    import x.game.manager.UIManager;
    import x.game.util.DisplayObjectUtil;

    /**
     *
     * @author fraser
     * 单行文本提示皮肤类
     */
    public class SingleLineTipSkin extends TextTipSkin
    {
        private var _bg_1:Sprite;
        private var _bg_2:Sprite;
        private var _bg_3:Sprite;
        private var _bg_4:Sprite;

        public function SingleLineTipSkin(tip:String = "")
        {
            super(UIManager.getSprite("TIP_RES_UI_SingleLineTipSkin"), tip);
        }

        override public function dispose():void
        {
            _bg_1 = null;
            _bg_2 = null;
            _bg_3 = null;
            _bg_4 = null;
            super.dispose();
        }
		
		override protected function initTipView():void
		{
			super.initTipView();
			//
			_bg_1 = _tipSkin["bg_1"] as Sprite;
			_bg_2 = _tipSkin["bg_2"] as Sprite;
			_bg_3 = _tipSkin["bg_3"] as Sprite;
			_bg_4 = _tipSkin["bg_4"] as Sprite;
			//
			DisplayObjectUtil.disableTarget(_bg_1) ;
			DisplayObjectUtil.disableTarget(_bg_2) ;
			DisplayObjectUtil.disableTarget(_bg_3) ;
			DisplayObjectUtil.disableTarget(_bg_4) ;
		}

        override protected function updateTipView():void
        {
			super.updateTipView();
			//
            _tipTxt.autoSize = TextFieldAutoSize.LEFT;
            _tipTxt.multiline = false;

            if (_bg_1)
            {
                _bg_1.width =  _tipTxt.width + 10;
                _bg_1.height = _tipTxt.height + 14;
            }
            if (_bg_2)
            {
                _bg_2.width =  _tipTxt.width + 10;
                _bg_2.height = _tipTxt.height + 14;
            }
            if (_bg_3)
            {
                _bg_3.width =  _tipTxt.width + 10;
                _bg_3.height = _tipTxt.height + 14;
            }
            if (_bg_4)
            {
                _bg_4.width =  _tipTxt.width + 10;
                _bg_4.height = _tipTxt.height + 14;
            }

        }
		
		override public function set defaultDirX(value:Boolean):void
		{
			super.defaultDirX = value ;
			updateDirView() ;
		}
		
		override public function set defaultDirY(value:Boolean):void
		{
			super.defaultDirY = value ;
			updateDirView() ;
		}

        private function updateDirView():void
        {
            _bg_1.visible = false;
            _bg_2.visible = false;
            _bg_3.visible = false;
            _bg_4.visible = false;

            if (defaultDirX)
            {
                if (defaultDirY)
                {
                    _bg_4.visible = true;
                }
                else
                {
                    _bg_2.visible = true;
                }
            }
            else
            {
                if (defaultDirY)
                {
                    _bg_3.visible = true;
                }
                else
                {
                    _bg_1.visible = true;
                }
            }
        }

        override public function get defaultDirY():Boolean
        {
            return false;
        }
    }
}


