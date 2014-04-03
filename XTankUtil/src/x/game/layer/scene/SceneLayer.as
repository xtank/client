package x.game.layer.scene
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import x.game.layer.ILayer;
	
	public class SceneLayer implements ILayer
	{
		/**  ui展现层   */
		public static const INDEX:uint = 5;
		//
		private var _rootContainer:DisplayObjectContainer;
		/** 层容器 */
		private var _layer:Sprite;
		
		public function SceneLayer(rootContainer:DisplayObjectContainer)
		{
			_layer = new Sprite();
			_layer.mouseEnabled = false;
			//
			_rootContainer = rootContainer;
			_rootContainer.addChild(_layer);
		}
		
		public function get skin():Sprite
		{
			return _layer;
		}
		
		public function get layerName():String{return "scene-layer" ;}
		
		public function addScene(scene:IAbstractScene):void
		{
			_layer.addChild(scene.skin) ;
		}
	}
}