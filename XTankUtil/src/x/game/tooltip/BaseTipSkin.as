package x.game.tooltip
{
    import flash.display.Sprite;
    
    import x.game.core.IDataClearable;
    import x.game.core.IDisposeable;
    import x.game.manager.TooltipManager;
    import x.game.util.DisplayObjectUtil;

    /**
     * 提示皮肤基类
     * @author fraser
     *
     */
    public class BaseTipSkin extends Sprite implements IDisposeable,IDataClearable
    {
        protected var _tipSkin:Sprite;
        protected var _initData:*;
		
		private var _defaultDirX:Boolean = true ;
		private var _defaultDirY:Boolean = true ;

        /**
         * 子类中继承此方法，对tipSkin等变量进行赋值。
         * */
        public function BaseTipSkin(skin:Sprite, data:* = null)
        {
            DisplayObjectUtil.disableTarget(this);
            //
            _tipSkin = skin;
            //
            addChild(_tipSkin);
            //
            initTipView();
			setData(data);
        }

        public function dispose():void
        {
            dataClear() ;
            //
            _tipSkin = null;
            hide();
        }
		
		public function dataClear():void
		{
            _initData = null;
		}

        protected function initTipView():void
        {
			// override by child
        }
		
		protected function updateTipView():void
		{
			// override by child	
		}

        public function setData(data:*):void
        {
            _initData = data;
			updateTipView() ;
        }

        /** 显示提示内容 */
        public function show():void
        {
			TooltipManager.tipLayer.addChild(this);
        }

        public function hide():void
        {
            DisplayObjectUtil.removeFromParent(this);
        }
        
        /** 默认Tip X方向 (true 为右) */
        public function get defaultDirX():Boolean
        {
            return _defaultDirX;
        }
		
		public function set defaultDirX(value:Boolean):void
		{
			_defaultDirX = value ;
		}

        /** 默认Tip Y方向 (true 为下) */
        public function get defaultDirY():Boolean
        {
            return _defaultDirY;
        }
		
		public function set defaultDirY(value:Boolean):void
		{
			_defaultDirY = value ;
		}
    }
}
