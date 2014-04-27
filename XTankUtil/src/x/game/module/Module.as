package x.game.module
{
    import flash.utils.getQualifiedClassName;
    
    import x.game.layer.LayerManager;
    import x.game.manager.FocusManager;
    import x.game.manager.StageManager;
    import x.game.resize.IResizeable;
    import x.game.resize.ResizeManager;
    import x.game.statistic.StatisticsManager;

    /**
     * 外部模块基类
     * @author kramer
     *
     */
    public class Module extends AbstractModule implements IResizeable
    {
        /** 模块打开统计项 */
        protected var _openStatistics:Object ;
        //
        protected var _disposed:Boolean;
	
        public function Module()
        {
            super();
            ResizeManager.addComponent(this);
        }

        override public function dispose():void
        {
            ResizeManager.removeComponent(this);
            _disposed = true;
            super.dispose();
        }

        /** 显示模块    */
        override public function show():void
        {	
            // 添加到模块层显示
			LayerManager.moduleLayer.addModule(this);
            // 设置焦点
            FocusManager.setFocus(this);
			
            if (_openStatistics != null)
            {
                StatisticsManager.send(_openStatistics);
            }
        }

        override public function hide():void
        {
            super.hide();
            //
            LayerManager.moduleLayer.removeModule(this);
            FocusManager.removeFocus(this);
            _initData = null;
        }
        
        public function updatePosition(gameWidth:Number, gameHeight:Number):void
        {
            if(isAutoAlign == true)
            {
                x = StageManager.fixWidth - moduleWidth >> 1;
                y = StageManager.fixHeight - moduleHeight >> 1;
            }
        }
        
        //
        public function get resizeName():String
        {
            return getQualifiedClassName(this);
        }

        /** 是否使用出现显示效果 */
        public function get isPlayShowEffect():Boolean
        {
            return true;
        }

        /** 是否居中显示 */
        public function get isAutoAlign():Boolean
        {
            return true;
        }

        /** 自定义模块位置*/
        public function customPosition():void
        {
            // override by child
        }

    }
}


