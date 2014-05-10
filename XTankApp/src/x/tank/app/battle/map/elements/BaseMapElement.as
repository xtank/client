package x.tank.app.battle.map.elements
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	import x.game.ui.XComponent;

	/**
	 * 基础地图元素
	 *
	 * 坦克,障碍物,各种道具
	 */
	public class BaseMapElement extends XComponent
	{
		public static const GRID_WIDTH:uint = 10;
		public static const GRID_HEIGHT:uint = 10;
		//
		protected var _mapx:uint;
		protected var _mapy:uint;
		protected var _passable:Boolean ;

		public function BaseMapElement(skin:DisplayObject)
		{
			super(skin);
		}
		
		public function get occpys():Vector.<Point> 
		{
			return null ;
		}
		
		public function get elementSkin():DisplayObject
		{
			return _skin ;
		}

		public function get passable():Boolean
		{
			return _passable;
		}

		public function set passable(value:Boolean):void
		{
			_passable = value;
		}

		public function get mapx():uint
		{
			return _mapx;
		}

		public function set mapx(value:uint):void
		{
			_mapx = value;
			x = _mapx * GRID_WIDTH;
		}

		public function get mapy():uint
		{
			return _mapy;
		}

		public function set mapy(value:uint):void
		{
			_mapy = value;
			y = _mapy * GRID_HEIGHT ;
		}
	}
}
