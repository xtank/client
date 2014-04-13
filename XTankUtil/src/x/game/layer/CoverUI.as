package x.game.layer
{
	import flash.display.Shape;
	import flash.geom.Rectangle;
	
	import de.polygonal.ds.HashMap;
	
	import x.game.manager.StageManager;
	import x.game.resize.IResizeable;
	import x.game.resize.ResizeManager;
	import x.game.util.DisplayObjectUtil;


	/**
	 * XFlash - CoverUI
	 *
	 * Created By fraser on 2014-2-9
	 * Copyright TAOMEE 2014.All rights reserved
	 */
	public class CoverUI extends Shape implements IResizeable
	{
		private static var _instances:HashMap = new HashMap();

		public static function getInstance(layer:ILayer):CoverUI
		{
			var rs:CoverUI = _instances.get(layer.layerName) as CoverUI;
			if (rs == null)
			{
				rs = new CoverUI(new Singleton(), layer);
				_instances.set(layer.layerName, rs);
			}
			return rs;
		}

		public static function showCover(layer:ILayer):void
		{
			layer.skin.addChildAt(getInstance(layer), 0);
		}

		public static function hideCover(layer:ILayer):void
		{
			DisplayObjectUtil.removeFromParent(getInstance(layer));
		}
		
		public static function isCover(layer:ILayer):Boolean
		{
			return layer.skin.contains(CoverUI.getInstance(layer)) ;
		}

		//
		//
		//
		private var _layer:ILayer;

		public function CoverUI(singleton:Singleton, layer:ILayer)
		{
			super();
			_layer = layer;
			ResizeManager.addComponent(this);
			updatePosition(1,1) ;
		}

		public function get resizeName():String
		{
			return "CoverUI#" + _layer.layerName;
		}

		//
		public function updatePosition(newWidth:Number, newHeight:Number):void
		{
			var rect:Rectangle = StageManager.stageRect;
			//
			graphics.clear();
			graphics.beginFill(0x000000, .6);
			graphics.drawRect(0, 0, rect.width, rect.height);
			graphics.endFill();
		}
	}
}

class Singleton
{

}
