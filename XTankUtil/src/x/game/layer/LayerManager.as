package x.game.layer
{
	import de.polygonal.ds.HashMap;
	import de.polygonal.ds.Itr;
	
	import x.game.layer.dialog.DialogLayer;
	import x.game.layer.module.ModuleLayer;
	import x.game.layer.scene.SceneLayer;
	import x.game.layer.top.TopLayer;
	import x.game.layer.ui.UILayer;
	import x.game.manager.StageManager;
	import x.game.util.DisplayObjectUtil;

	/**
	 * 游戏层管理器
	 * @author fraser
	 *
	 */
	public class LayerManager
	{
		
		private static var _layers:HashMap = new HashMap() ;
		
		public static function initLayers():void
		{
			// 初始化场景层级
			_layers.set(SceneLayer.INDEX, new SceneLayer(StageManager.stage));
			_layers.set(UILayer.INDEX, new UILayer(StageManager.stage));
			_layers.set(DialogLayer.INDEX, new DialogLayer(StageManager.stage));
			_layers.set(ModuleLayer.INDEX, new ModuleLayer(StageManager.stage));
			_layers.set(TopLayer.INDEX, new TopLayer(StageManager.stage));
		}
		
		public static function getLayer(layerIndex:uint):ILayer
		{
			return _layers.get(layerIndex) as ILayer;
		}
		
		public static function set lockLayers(value:Boolean):void
		{
            var itr:Itr = _layers.iterator() ;
            var layer:ILayer ;
            if(value)
            {
                while(itr.hasNext())
                {
                    layer = itr.next() as ILayer;
                    DisplayObjectUtil.disableTarget(layer.skin);
                } 
            }
            else
            {
                while(itr.hasNext())
                {
                    layer = itr.next() as ILayer;
                    DisplayObjectUtil.enableTarget(layer.skin);
                } 
            }
		}
		
		public static function get dialogLayer():DialogLayer
		{
			return getLayer(DialogLayer.INDEX) as DialogLayer ;
		}
		
		public static function get moduleLayer():ModuleLayer
		{
			return getLayer(ModuleLayer.INDEX) as ModuleLayer ;
		}
		
		public static function get sceneLayer():SceneLayer
		{
			return getLayer(SceneLayer.INDEX) as SceneLayer ;
		}
		
		public static function get topLayer():TopLayer
		{
			return getLayer(TopLayer.INDEX) as TopLayer ;
		}
		
		public static function get uiLayer():UILayer
		{
			return getLayer(UILayer.INDEX) as UILayer ;
		}
	}
}
