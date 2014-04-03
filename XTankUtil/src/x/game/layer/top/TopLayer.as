package x.game.layer.top
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;
    import x.game.layer.ILayer;

    /**
     * 顶层管理
     * @author fraser
     *
     */
    public class TopLayer implements ILayer
    {
        /**  顶层 （主要用于全屏动画  提示等）  */
        public static const INDEX:uint = 1;
		
		private var _rootContainer:DisplayObjectContainer;
        private var _layer:Sprite;

        public function TopLayer(rootContainer:DisplayObjectContainer)
        {
            _layer = new Sprite();
            _layer.mouseEnabled = false;
            //
			_rootContainer = rootContainer;
			_rootContainer.addChild(_layer);
        }
		
		public function get layerName():String {return "top-layer" ;}

        public function get skin():Sprite
        {
            return _layer;
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
    }
}
