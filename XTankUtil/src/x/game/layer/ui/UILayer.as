package x.game.layer.ui
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;
    
    import x.game.util.DisplayObjectUtil;
    import x.game.layer.ILayer;

    /**
     * UI 层管理
     * @author fraser
     *
     */
    public class UILayer implements ILayer
    {
        /**  ui展现层   */
        public static const INDEX:uint = 4;
		//
        private var _rootContainer:DisplayObjectContainer;
        /** 层容器 */
		private var _layer:Sprite;

        public function UILayer(rootContainer:DisplayObjectContainer)
        {
			_layer = new Sprite();
			_layer.mouseEnabled = false;
            //
            _rootContainer = rootContainer;
            _rootContainer.addChild(_layer);
        }
		
		public function get layerName():String {return "ui-layer" ;}
		
		public function get skin():Sprite 
		{
			return _layer ;
		}
		
		public function contains(value:DisplayObject):Boolean
		{
			return _layer.contains(value);
		}
		
		public function addChildAt(value:DisplayObject, index:uint):void
		{
			_layer.addChildAt(value, index);
		}
		
		public function addChild(value:DisplayObject):void
		{
			addChildAt(value, _layer.numChildren);
		}

        public function hide():void
        {
            DisplayObjectUtil.removeFromParent(_layer);
        }

        public function show():void
        {
            _rootContainer.addChild(_layer);
        }
    }
}
