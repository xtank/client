package x.game.layer.dialog
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import x.game.layer.ILayer;

	/**
	 * 对话层
	 * @author fraser
	 *
	 */
	public class DialogLayer implements ILayer
	{
        /**  对话层   */
        public static const INDEX:uint = 3;
		/** 层容器 */
		private var _layer:Sprite;

		public function DialogLayer(rootContainer:DisplayObjectContainer)
		{
			_layer = new Sprite();
			_layer.mouseEnabled = false;
			rootContainer.addChild(_layer);
		}
		
		public function get layerName():String {return "dialog-layer" ;}
		
		public function get skin():Sprite 
		{
			return _layer ;
		}

		/** 显示对话框   */
		public function addDialog(value:DisplayObject):void
		{
			_layer.addChild(value);
		}

	}
}
